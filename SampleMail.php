<?php
class SampleMail
{
	//errors
	private  $isUnknownDestination = true;	//false когда получатель письма указан
	private  $isUnknownSender      = true;	//false когда отправитель письма указан
	
	private  $contentType          = "text/plain";
	private  $encoding             = "UTF-8";
	private  $subject              = "";
	private  $body                 = "";
	private  $fromSection          = "";  
	private  $toSection            = "";
	private  $boundary             = null;  
	private  $encodedFiles         = array();
	/*
	 * Принимает кодировку письма. По умолчанию стоит UTF-8.
	 * Тестировался также с WINDOWS-1251, но рекомендуется использовать UTF-8
	 * Все текстовые аргументы методам класса должны передаваться в той же кодировке
	 * что была передана в конструктор
	 * */
	public function __construct($charset = "UTF-8")
	{
		$this->encoding = $charset;
		$this->boundary  = md5(uniqid(time()));
	}
	/*
	 * Установка темы письма
	 * */
	public function setSubject($subject)
	{
		$this->subject = $subject;
	}
	/*
	 * Установка текста в формате html.
	 * Метод сделан для совместимости интерфейса с MailWrapper,
	 * рекомендуется использовать setPalinText 
	 * */
	public function setHtmlText($htmlText)
	{
		$this->body        = $htmlText;
		$this->contentType = "text/html";
	}
	/*
	 * Адрес отправителя (отправителей) можeт быть установлен в одном из следующих форматов:
	 * (рекомендуемый) массив array("vasyavetrov@mail.ru"=>"Вася Ветров", "lusyavetrova@mail.ru"=>"Люся Ветрова")
	 * строка "vasyavetrov@mail.ru"
	 * строка "vasyavetrov@mail.ru,lusyavetrova@mail.ru"
	 * массив array("vasyavetrov@mail.ru", "lusyavetrova@mail.ru")
	 * */
	public function setAddressFrom($address)
	{
		$result = $this->createMailsArray($address);
		if (count($result) > 0) 
		{
			$this->setFrom($result);
			$this->isUnknownSender = false;		
		}
		else $this->isUnknownSender = true;
	}
	 /*
	 * Адрес получателя (получателей) можeт быть установлен в одном из следующих форматов:
	 * (рекомендуемый) массив array("vasyavetrov@mail.ru"=>"Вася Ветров", "lusyavetrova@mail.ru"=>"Люся Ветрова")
	 * строка "vasyavetrov@mail.ru"
	 * строка "vasyavetrov@mail.ru,lusyavetrova@mail.ru"
	 * массив array("vasyavetrov@mail.ru", "lusyavetrova@mail.ru")
	 * */ 
	public function setAddressTo($address)
	{
		$result = $this->createMailsArray($address);
		if (count($result) > 0) 
		{
			$this->setTo($result);
			$this->isUnknownDestination = false;		
		}
		else $this->isUnknownDestination = true;
	}
	/*
	 * Текст может содержать произвольные уникальные тэги для вставки inline изображений
	 * Пример:
	 * setPlainText("Привет, вот смайлик {smile1},
	 * 				 а вот еще смайлик {smile2}", 
	 * array
	 * (
	 * 	"{smile1}"=>абсолютный_путь_к_вашему_изображению_на_жестком диске,
	 *  "{smile2}"=>абсолютный_путь_к_вашему_вторму_изображению_на_жестком диске,
	 * )
	 * )
	 * */
	public function setPlainText($text, $images = null)
	{
		$contentType = "text/plain";
		if (is_array($images))
		{
			$contentType = "text/html";
			foreach ($images as $tpl=>$img)
			{
				if (strpos($text, $tpl) !== false)
				{
					if (file_exists($img))
					{
						$cid = $this->embed($img);
						$img = "<img src = 'cid:$cid' />"; 
						$text = str_replace($tpl, $img, $text);
					}
					else $text = str_replace($tpl, "", $text);
				}
			}
			$text = str_replace("\r", "", $text);
			$text = str_replace("\n", "<br>", $text);
			$text = "<html><body>$text</body></html>";
		}
		$this->contentType = $contentType;
		$this->body        = $text;
	}
	/*
	 * Прикрепить файл как attachment. Можно сменить тип disposition на inline, по идее тогда должен вернуть cid
	 * */
	public function attachFile($pathToFile, $disposition = "attachment")
	{
		if(!file_exists($pathToFile)) return "file not found";
		if (($disposition != "inline")&&($disposition != "attachment")) return "unknown type disposition";
		$cid = null;
		$file = $pathToFile;
		$fileT = explode("/", $file);
		$fileT = $fileT[count($fileT) - 1];
		$boundary = $this->boundary;
		$mimeType  = $this->mimeType($file);
		$filePart  = "--$boundary\n";
		$filePart .= "Content-Disposition: $disposition; filename=$fileT\n";
		$filePart .= "Content-Type: $mimeType; name=$fileT\n";
		if ($disposition == "inline") 
		{
			$cid      = uniqid("$fileT@", true);
			$filePart .= "Content-ID: <$cid>\n";	
		}
		$filePart .= "Content-Transfer-Encoding: base64\r\n\r\n";
		$filePart .= chunk_split($this->encodeFileBase64($file));
		$this->encodedFiles[] = $filePart;
		return $cid;
	}
	/*
	 * Собственно, отправка письма 
	 * */
	public function send()
	{
		if ($this->isUnknownDestination) return "unknown recepient";
		if ($this->isUnknownSender) 	 return "unknown sender";
		try
		{
			return $this->buildMail();
			
		}catch(Exception $exc)
		{
			echo $exc->getMessage()."\r\n";
		}
	}
	//-----------------------------------------------------
	
	private function createMailsArray($address)
	{
		$result = array();
		if (is_array($address))
		{
			
			foreach ($address as $addr=>$recipient)
			{
				if ($this->checkMail($addr))
				{
					$result[$addr] = $recipient;
				}
				else if ($this->checkMail($recipient)) $result[] = $recipient;
			}
		}
		elseif (strpos($address, ",") !== false)
		{
			$result = array();
			$list   = explode(",", $address);
			foreach ($list as $i)
			{
				if ($this->checkMail($i)) $result[] = $i;
			}
		}
		elseif ($this->checkMail($address)) $result[] = $address;
		return $result;	
	}
	
	private function checkMail($candidateToEmailAddress)
	{		
		/*$ea = new CEmailAttribute();
		$v  = new CValidationContext();
		$v->SetValue($candidateToEmailAddress);
		if ($ea->IsValid($v)) return true;
		return false;*/
		return true;
	}
	
	private function setTo($addresses)
	{
		$this->parseMailsArray("to", $addresses);
	}
	
	private function setFrom($addresses)
	{
		$this->parseMailsArray("from", $addresses);		
	}	
	
	private function parseMailsArray($typeSection, $addresses)
	{
		$r2 = array();	//составные адресаты (email=> Имя получателя)
		$r1 = array();	//
		foreach($addresses as $key=>$item)
		{
			if ($this->checkMail($key))
			{
				if ($typeSection == "from") $r2[] = "=?$this->encoding?Q?".str_replace("+", " ", str_replace("%", "=",urlencode($item)))."?= <$key>";				
				else if ($typeSection == "to") $r2[] = "=?$this->encoding?Q?".str_replace("+", " ", str_replace("%", "=",urlencode($item)))."?=\n <$key>";				
			}
			else if ($this->checkMail($item)) $r1[] = $item; 
		}
		if (count($r2) != 0)
		{
			if ($typeSection == "from")$this->fromSection = join ("        ,", $r2);
			else if ($typeSection == "to")$this->toSection = join ("        ,", $r2);
		}
		else if (count($r1) != 0) 
		{
			if ($typeSection == "from")$this->fromSection = join (" ,", $r1);
			else if ($typeSection == "to") $this->toSection = join (" ,", $r1);
		}
	}
	
	private function buildMail()
	{	
		$boundary = $this->boundary;
		//Не надо удалять комментарий в следующей строчке, он мне нравится сильно
		//$this->toSection = "=?UTF-8?Q?".str_replace("%", "=",urlencode("Андрею"))."?=\n <lamzin@benefis.ru>";	
		$header  = "From: $this->fromSection\n";
		$header .= "To:   $this->toSection"."\n";
		$header .= "Mime-Version: 1.0\n";
		$header .= "Content-Type: multipart/mixed; boundary=$boundary\n\n";		
		$bodyHeader  = "--$boundary\n";
		$bodyHeader .= "Content-type: $this->contentType; charset=$this->encoding\n";
		$bodyHeader .= "Content-Transfer-Encoding: base64\r\n\r\n";
		//Далее код прикрепляющий файлы
		$files = "";
		if (count($this->encodedFiles) > 0) $files =  join("\r\n\r\n", $this->encodedFiles)."\r\n\r\n";
		return mail("",
				"=?$this->encoding?B?" . base64_encode($this->subject) . "?=",
				$bodyHeader ."\r\n\r\n". chunk_split(base64_encode($this->body)).$files,
				$header);
		/*
		 * mail(
				$address->Email,
				"=?UTF-8?B?" . base64_encode($message->Subject) . "?=",
				$message->TplBodyHeader ."\r\n\r\n". chunk_split(base64_encode($messageBody)). $message->TplEncodeFiles,
				$header);
		 * */		
	} 

	private function embed($img)
	{
		$imgT = explode("/", $img);
		$imgT = $imgT[count($imgT) - 1];
		$boundary = $this->boundary;
		$cid      = uniqid("$imgT@", true);
		// заголовки и данные прикрепленных файлов
		$mimeType  = $this->mimeType($img);
		$filePart  = "--$boundary\n";
		$filePart .= "Content-Disposition: inline\n";
		$filePart .= "Content-Type: $mimeType\n";
		$filePart .= "Content-ID: <$cid>\n";
		$filePart .= "Content-Transfer-Encoding: base64\r\n\r\n";
		$filePart .= chunk_split($this->encodeFileBase64($img));
		//$filePart .= "--$boundary--";
		$this->encodedFiles[] = $filePart;
		return $cid;
	}
	
	private  function encodeFileBase64($filePath) 
	{
		if(is_file($filePath)) 
		{
			$fh = fopen($filePath,"rb");
			$encodeFile = base64_encode(fread($fh, filesize($filePath)));
			return $encodeFile;
		}
		return null;
	}
	
	private function mimeType($file) 
	{
		switch (pathinfo($file, PATHINFO_EXTENSION))
		{
			case "jpg":
			case "jpeg":
				return image_type_to_mime_type(IMAGETYPE_JPEG);
			case "gif":
				return image_type_to_mime_type(IMAGETYPE_GIF);
			case "png":
				return image_type_to_mime_type(IMAGETYPE_PNG);
			case "bmp":
				return image_type_to_mime_type(IMAGETYPE_BMP);
			default:
				return "application/octet-stream";
		}
	}
}//end class definition
