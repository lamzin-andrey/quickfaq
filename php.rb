module Date
    class date
        def numberDayOfWeek
            date('N'); #1 - Monday, 7 - Sunday
            date('w'); #0 - Sunday, 6 - Saturday
        end
    end
end

module File
	def pathinfo
		['extension' => 'png', 'basename' => '0.png', 'filename' => '0', 'dirname' => '/home/user']
	end
end

module Curl
	def GetHeaders
	#~ public function getResponseHeadersOnly(string $url) : array
    #~ {
        #~ $curl = curl_init();
        #~ curl_setopt($curl, CURLOPT_URL, $url);
        #~ curl_setopt($curl, CURLOPT_NOBODY, true);
        #~ curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        #~ curl_setopt($curl, CURLOPT_HEADER, true);
        #~ $headers = curl_exec($curl);
        #~ $info = curl_getinfo($curl);
        #~ curl_close($curl);

        #~ var_dump($headers);
        #~ var_dump($info);
    #~ }
	end
end
