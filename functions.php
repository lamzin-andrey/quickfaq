<?php

/**
 * ��������� win1251 utf8 ���� ������ � windows-1251
 * */
function utils_utf8($s) {
	return mb_convert_encoding($s, "UTF-8", "WINDOWS-1251");
	return $s;
}

/**/
function checkMail($mail)	 {
	 $reg = "#^[\w\.]+[^\.]@[\w]+\.[\w]{2,4}#";	 
	 $n = preg_match($reg, $mail, $m);
	 return $n;
 }
/**
 * ������ � ����� ������ � json �������
 * ������ ��������� - �����, �������� - ��������
 * � ������ ������ ������������ status => ok 
 * */
function json_ok() {
 $sz = func_num_args();
 $data['status'] = "ok";
 if ((int)@$_POST['reqi'] > 0) {
 	$data["reqi"]= $_POST['reqi'];
 }
 if ((int)@$_POST['dbfrts'] > 0) {
 	$data["dbfrts"]= $_POST['dbfrts'];
 }
 //"reqi", $_POST['reqi']
 for ($i = 0; $i < $sz; $i++) {
 	if ($i + 1 < $sz) {
 		$data[func_get_arg($i)] = func_get_arg($i + 1);
 		$i++;
 	}
 }mysql_close();
 die(json_encode($data));
}
/**
 * ������ � ����� ������ � json �������
 * ������ ��������� - �����, �������� - ��������
 * � ������ ������ ������������ status => error 
 * */
function json_error() {
	$sz = func_num_args();
	$data['status'] = "error";
	if ((int)@$_POST['dbfrts'] > 0) {
		$data["dbfrts"]= $_POST['dbfrts'];
	}
 	for ($i = 0; $i < $sz; $i++) {
 		if ($i + 1 < $sz) {
 			$data[func_get_arg($i)] = func_get_arg($i + 1);
 			$i++;
 		}
 	}mysql_close();
	die(json_encode($data));
}


/**
* @desc ������������ ������� ����� � ��������
*/

function utils_translite ($string)  {
	$string = @ereg_replace("�","e",$string);
	$string = @ereg_replace("�","i",$string);
	$string = @ereg_replace("�","u",$string);
	$string = @ereg_replace("�","'",$string);
	$string = @ereg_replace("�","ch",$string);
	$string = @ereg_replace("�","sh",$string);
	$string = @ereg_replace("�","c",$string);
	$string = @ereg_replace("�","y",$string);
	$string = @ereg_replace("�","k",$string);
	$string = @ereg_replace("�","e",$string);
	$string = @ereg_replace("�","n",$string);
	$string = @ereg_replace("�","g",$string);
	$string = @ereg_replace("�","sh",$string);
	$string = @ereg_replace("�","z",$string);
	$string = @ereg_replace("�","h",$string);
	$string = @ereg_replace("�","'",$string);
	$string = @ereg_replace("�","f",$string);
	$string = @ereg_replace("�","w",$string);
	$string = @ereg_replace("�","v",$string);
	$string = @ereg_replace("�","a",$string);
	$string = @ereg_replace("�","p",$string);
	$string = @ereg_replace("�","r",$string);
	$string = @ereg_replace("�","o",$string);
	$string = @ereg_replace("�","l",$string);
	$string = @ereg_replace("�","d",$string);
	$string = @ereg_replace("�","j",$string);
	$string = @ereg_replace("�","�",$string);
	$string = @ereg_replace("�","ya",$string);
	$string = @ereg_replace("�","s",$string);
	$string = @ereg_replace("�","m",$string);
	$string = @ereg_replace("�","i",$string);
	$string = @ereg_replace("�","t",$string);
	$string = @ereg_replace("�","b",$string);
	$string = @ereg_replace("�","E",$string);
	$string = @ereg_replace("�","I",$string);
	$string = @ereg_replace("�","U",$string);
	$string = @ereg_replace("�","CH",$string);
	$string = @ereg_replace("�","'",$string);
	$string = @ereg_replace("�","SH",$string);
	$string = @ereg_replace("�","C",$string);
	$string = @ereg_replace("�","Y",$string);
	$string = @ereg_replace("�","K",$string);
	$string = @ereg_replace("�","E",$string);
	$string = @ereg_replace("�","N",$string);
	$string = @ereg_replace("�","G",$string);
	$string = @ereg_replace("�","SH",$string);
	$string = @ereg_replace("�","Z",$string);
	$string = @ereg_replace("�","H",$string);
	$string = @ereg_replace("�","'",$string);
	$string = @ereg_replace("�","F",$string);
	$string = @ereg_replace("�","W",$string);
	$string = @ereg_replace("�","V",$string);
	$string = @ereg_replace("�","A",$string);
	$string = @ereg_replace("�","P",$string);
	$string = @ereg_replace("�","R",$string);
	$string = @ereg_replace("�","O",$string);
	$string = @ereg_replace("�","L",$string);
	$string = @ereg_replace("�","D",$string);
	$string = @ereg_replace("�","J",$string);
	$string = @ereg_replace("�","E",$string);
	$string = @ereg_replace("�","YA",$string);
	$string = @ereg_replace("�","S",$string);
	$string = @ereg_replace("�","M",$string);
	$string = @ereg_replace("�","I",$string);
	$string = @ereg_replace("�","T",$string);
	$string = @ereg_replace("�","B",$string);
	return $string;
}
 /**
 * @descr 
 * @param
 * @param
 * @return
 **/
 function utils_cp1251($s) {
 	return mb_convert_encoding($s, "WINDOWS-1251", "UTF-8");
 }
 /**
 * @desc 
 * @param
 * @param
 * @return
 **/
 function utils_money($v) {
 	$v = str_replace('.', ',', $v);
 	$a = explode(',', $v);
 	$s = $a[0];
 	$q = array();
 	for ($i = strlen($s) - 1, $j = 1; $i > -1; $i--, $j++) {
 		$q[] = $s[$i];
 		if ($j % 3 == 0) $q[] = ' ';
 	}
 	$a[0] = join("", array_reverse($q));
 	if (@$a[1] == '00') return $a[0] . utils_utf8(' ���.');
 	$v = join(",", $a);
 	return $v . utils_utf8(' ���.');
 }
 
function now() {
    $d = date("Y-m-d H:i:s");
    return date("Y-m-d H:i:s", strtotime($d) + SUMMER_TIME);
}
/**
 * @desc ������� ������� png c ����������� ������������
 * @param string $srcFilename   - ���� � ����� ����������� � ������� png
 * @param string $destFilename  - ���� � ����� ����������� � ������� png
 * @param int   $destW - ��������� ������ �����������
 * @param int   $destH - ��������� ������ �����������
 * @param array $defaultTransparentColor [0,0,0] - ��� �������� ����� ����� �������������� ��� ����������, ���� ���������� ���� �� �������� ���������� �� ��������� ����������� 
 * */
function utils_pngResize($srcFilename, $destFilename, $destW, $destH, $compression = 9, $defaultTransparentColor = array(0, 0, 0)) {
	if (!$img = @imagecreatefrompng($srcFilename)) {
		throw new Exception('������ ������� �����������');
	}
	$sz = getImageSize($srcFilename);
	$srcW = $sz[0];
	$srcH = $sz[1];
	$output = imagecreatetruecolor($destW, $destH);
    imagealphablending($output, false); //����� �� ���� ������������ ������� �� �������
    imagesavealpha($output, true);
    $transparencyIndex = imagecolortransparent($img);
    if ($transparencyIndex >= 0) {
        $transparencyColor = imagecolorsforindex($img, $transparencyIndex);
    }
    $transparenctColor = imagecolorallocate($output, $defaultTransparentColor[0], $defaultTransparentColor[1], $defaultTransparentColor[2]);
    imagecolortransparent($output, $transparencyIndex);
    imagefill($output, 0, 0, $transparencyIndex);
    imagecopyresampled($output, $img, 0, 0, 0, 0, $destW, $destH, $srcW, $srcH);
	if (!@imagepng($output, $destFilename, $compression)) {
    	throw new Exception('������ ���������� �����������');
	}
}
/**
 * @desc ������� ������� png c ����������� ������������
 * @param string $srcFilename   - ���� � ����� ����������� � ������� png
 * @param string $destFilename  - ���� � ����� ����������� � ������� png
 * @param int   $destW - ��������� ������ �����������
 * @param int   $destH - ��������� ������ �����������
 * @param array $defaultTransparentColor [0,0,0] - ��� �������� ����� ����� �������������� ��� ����������, ���� ���������� ���� �� �������� ���������� �� ��������� ����������� 
 * */
function utils_gifResize($srcFilename, $destFilename, $destW, $destH, $defaultTransparentColor = array(0, 0, 0)) {
	if (!$img = @imagecreatefromgif($srcFilename)) {
		throw new Exception('������ ������� �����������');
	}
	$sz = getImageSize($srcFilename);
	$srcW = $sz[0];
	$srcH = $sz[1];
	$output = imagecreatetruecolor($destW, $destH);
    //imagealphablending($output, false); //����� �� ���� ������������ ������� �� �������
    //imagesavealpha($output, true);
    $transparencyIndex = imagecolortransparent($img);
    if ($transparencyIndex !== -1) {
        $transparencyColor = imagecolorsforindex($img, $transparencyIndex);
    }
    $transparenctColor = imagecolorallocate($output, $defaultTransparentColor[0], $defaultTransparentColor[1], $defaultTransparentColor[2]);
    imagecolortransparent($output, $transparencyIndex);
    imagefill($output, 0, 0, $transparencyIndex);
    imagecopyresampled($output, $img, 0, 0, 0, 0, $destW, $destH, $srcW, $srcH);
	if (!@imagegif($output, $destFilename)) {
    	throw new Exception('������ ���������� �����������');
	}
}

function utils_jpgResize($srcFilename, $destFilename, $destW, $destH, $quality = 80) {
	if (!$img = @imagecreatefromjpeg($srcFilename)) {
		throw new Exception('������ ������� �����������');
	}
	$sz = getImageSize($srcFilename);
	$srcW = $sz[0];
	$srcH = $sz[1];
	$output = imagecreatetruecolor($destW, $destH);
    imagecopyresampled($output, $img, 0, 0, 0, 0, $destW, $destH, $srcW, $srcH);
	if (!@imagejpeg($output, $destFilename, $quality)) {
    	throw new Exception('������ ���������� �����������');
	}
}

function utils_404($template = null, $masterTemplate = null) {
	header("HTTP/1.1 404 Not Found");
	if ($template && !$masterTemplate) {
		if (file_exists($template)) {
			include_once $template;
		}
	} elseif($masterTemplate && $template){
		if (file_exists($template) && file_exists($masterTemplate)) {
			$content = $template;
			include_once $masterTemplate;
		}
	}elseif($masterTemplate){
		if (file_exists($masterTemplate)) {
			include_once $masterTemplate;
		}
	}
	
	exit;
}

function utils_302($location = "/") {
	header("location: $location");
	exit;
}

function utils_getExt($filename){
	if (strpos($filename, '.') === false) {
		return '';
	}
	$a = explode(".", $filename);
	$s = $a[ count($a) - 1 ];
	return $s;
}
function utils_getImageMime($path, &$w = null, &$h = null) {
	$sz = @getImageSize($path);
	if (is_array($sz) && count($sz)) {
		$w = $sz[0];
		$h = $sz[1];
		return $sz["mime"];
	}
}

function utils_translite_url ($string)  {
	$string = @ereg_replace("�","e",$string);
	$string = @ereg_replace("�","i",$string);
	$string = @ereg_replace("�","yu",$string);
	$string = @ereg_replace("�","",$string);
	$string = @ereg_replace("�","ch",$string);
	$string = @ereg_replace("�","sh",$string);
	$string = @ereg_replace("�","c",$string);
	$string = @ereg_replace("�","u",$string);
	$string = @ereg_replace("�","k",$string);
	$string = @ereg_replace("�","e",$string);
	$string = @ereg_replace("�","n",$string);
	$string = @ereg_replace("�","g",$string);
	$string = @ereg_replace("�","sh",$string);
	$string = @ereg_replace("�","z",$string);
	$string = @ereg_replace("�","h",$string);
	$string = @ereg_replace("�","",$string);
	$string = @ereg_replace("�","f",$string);
	$string = @ereg_replace("�","i",$string);
	$string = @ereg_replace("�","v",$string);
	$string = @ereg_replace("�","a",$string);
	$string = @ereg_replace("�","p",$string);
	$string = @ereg_replace("�","r",$string);
	$string = @ereg_replace("�","o",$string);
	$string = @ereg_replace("�","l",$string);
	$string = @ereg_replace("�","d",$string);
	$string = @ereg_replace("�","j",$string);
	$string = @ereg_replace("�","�",$string);
	$string = @ereg_replace("�","ya",$string);
	$string = @ereg_replace("�","s",$string);
	$string = @ereg_replace("�","m",$string);
	$string = @ereg_replace("�","i",$string);
	$string = @ereg_replace("�","t",$string);
	$string = @ereg_replace("�","b",$string);
	$string = @ereg_replace("�","E",$string);
	$string = @ereg_replace("�","I",$string);
	$string = @ereg_replace("�","YU",$string);
	$string = @ereg_replace("�","CH",$string);
	$string = @ereg_replace("�","",$string);
	$string = @ereg_replace("�","SH",$string);
	$string = @ereg_replace("�","C",$string);
	$string = @ereg_replace("�","U",$string);
	$string = @ereg_replace("�","K",$string);
	$string = @ereg_replace("�","E",$string);
	$string = @ereg_replace("�","N",$string);
	$string = @ereg_replace("�","G",$string);
	$string = @ereg_replace("�","SH",$string);
	$string = @ereg_replace("�","Z",$string);
	$string = @ereg_replace("�","H",$string);
	$string = @ereg_replace("�","",$string);
	$string = @ereg_replace("�","F",$string);
	$string = @ereg_replace("�","I",$string);
	$string = @ereg_replace("�","V",$string);
	$string = @ereg_replace("�","A",$string);
	$string = @ereg_replace("�","P",$string);
	$string = @ereg_replace("�","R",$string);
	$string = @ereg_replace("�","O",$string);
	$string = @ereg_replace("�","L",$string);
	$string = @ereg_replace("�","D",$string);
	$string = @ereg_replace("�","J",$string);
	$string = @ereg_replace("�","E",$string);
	$string = @ereg_replace("�","YA",$string);
	$string = @ereg_replace("�","S",$string);
	$string = @ereg_replace("�","M",$string);
	$string = @ereg_replace("�","I",$string);
	$string = @ereg_replace("�","T",$string);
	$string = @ereg_replace("�","B",$string);
	$string = str_replace(" ","_",$string);
	$string = str_replace('"',"",$string);
	$string = str_replace('.',"",$string);
	$string = str_replace("'","",$string);
	$string = str_replace(",","",$string);
	$string = str_replace('\\', "", $string);
	$string = str_replace('?', "", $string);
	
	return strtolower($string);
}


function utils_addScript($script, $code = '', $enc = '') {
	if ($script == "global" && strlen($code)) {
		$GLOBALS["javascriptglobal"][] = $code;
        return '';
	}
	if (strpos($script, "/") !== 0) {
	    $script = DBFR_HROOT . "/$script";
	}
	if ($enc) {
		$enc = 'charset="'.$enc.'"';
	}
    $s = '<script type="text/javascript" src="'.$script.'" '.$enc.'></script>'."\n";
    return $s;
}

function utils_javascript() {
	$s = '<script type="text/javascript">'.join("\n", @$GLOBALS["javascriptglobal"]).'</script>'."\n";
	$s .= @$GLOBALS["javascript"];
	return  $s;
}

function a($v, $k) {
	if ( (is_array($v) || is_string($v) ) && isset($v[$k])) {
		return $v[$k];
	}
	return null;
}
function o($v, $k) {
	if (is_object($v) && isset($v->$k)) {
		return $v->$k;
	}
	return null;
}
