module XamppSsl
  class Config
    def Alg
		#1 Create /home/User/tmp/04/cert.conf
		certDotConf
		#2 Put /home/User/tmp/04/genCert.sh
		genCertDotSh
		#3 ./genCert.sh

		
		# Must generated files .key and .crt
		
		#4 Copy files in the /opt/lampp/etc/ssl.crt/test.loc
		
		#5 addVirtualSslHost
		addVirtualSslHost
		
		#6 Open /opt/lampp/etc/httpd.conf and uncomment line Include etc/extra/httpd-ssl.conf (519 line area)
		
		#7
		# cp /opt/lampp/etc/ssl.crt/test.loc/test.locserver.crt /usr/local/share/ca-certificates/test_dot_locserver.crt
		
		#8 sudo update-ca-certificates
		
		# Далее всякие танцы с бубнами для того, чтобы мозилла решила, что всё ок https://losst.pro/ustanovka-sertifikatov-v-ubuntu#toc-3-ustanovka-v-firefox
		# Внезапное БИНГО - 11 пункт! (9 and 10 скорее всего можно будет скипнуть)
		
		#9 cp  cert8.db, key3.db, secmod.db
		
		#10 certutil -A -n test_dot_locserver -t "u,u,u" -d /home/andrey/tmp/04/cert/ -i /opt/lampp/etc/ssl.crt/test.loc/test.locserver.crt
		
		#11 certutil -d /home/andrey/.mozilla/firefox/81f5m178.personalAndrey/ -A -t "TC,," -n "test_dot_locserver" -i /opt/lampp/etc/ssl.crt/test.loc/test.locserver.crt
    end
    
    def addVirtualSslHost
		#~ <VirtualHost *:80> - It not changed (all as FastXampp). And it not delete!
			#~ ServerAdmin webmaster@test.loc
			#~ ServerName test.loc
			#~ DocumentRoot "/opt/lampp/htdocs/test.loc/www"
			#~ ScriptAlias /cgi/ "/opt/lampp/htdocs/test.loc/cgi/
			#~ ErrorLog /opt/lampp/htdocs/test.loc/error.log
			#~ CustomLog /opt/lampp/htdocs/test.loc/access.log common
		#~ </VirtualHost>

		#~ <VirtualHost *:443> - It almost not changed (almost all as FastXampp, 80 -> 443)
			#~ ServerAdmin webmaster@test.loc
			#~ ServerName test.loc
			#~ DocumentRoot "/opt/lampp/htdocs/test.loc/www"
			#~ ScriptAlias /cgi/ "/opt/lampp/htdocs/test.loc/cgi/
			#~ ErrorLog /opt/lampp/htdocs/test.loc/error.log
			#~ CustomLog /opt/lampp/htdocs/test.loc/access.log common
			
			## Start Magick
			#~ SSLEngine on
			#~ SSLCertificateFile "/opt/lampp/etc/ssl.crt/test.loc/test.locserver.crt"
			#~ SSLCertificateKeyFile "/opt/lampp/etc/ssl.crt/test.loc/test.locserver.key"
			## End Magick
			
		#~ </VirtualHost>
    end
    
    def genCertDotSh
		# Attention! It for domain test.loc
		
		#!/bin/bash
		
		#domain=test.loc

		#openssl req -config cert.conf -new -sha256 -newkey rsa:2048 -nodes -keyout $domain\server.key -x509 -days 3650 -out $domain\server.crt

		#echo.
		#echo -----
		#echo The certificate was provided.
		#echo.
		#pause
    end
    
    def certDotConf
		# Attention! It for domain test.loc (two place!) (Ctrt+E in Geany)
		#~ [ req ]

		#~ default_bits        = 2048
		#~ default_keyfile     = server-key.pem
		#~ distinguished_name  = subject
		#~ req_extensions      = req_ext
		#~ x509_extensions     = x509_ext
		#~ string_mask         = utf8only

		#~ [ subject ]

		#~ countryName                 = Russia
		#~ countryName_default         = RU

		#~ stateOrProvinceName         = Dagestan
		#~ stateOrProvinceName_default = DA

		#~ localityName                = Kochoobey
		#~ localityName_default        = Kochoobey

		#~ organizationName            = Phisical Person
		#~ organizationName_default    = NoName

		#~ commonName                  = Phisical Person
		#~ commonName_default          = test.loc

		#~ emailAddress                = lamzin80@mail.ru
		#~ emailAddress_default        = lamzin80@mail.ru

		#~ [ x509_ext ]

		#~ subjectKeyIdentifier   = hash
		#~ authorityKeyIdentifier = keyid,issuer

		#~ basicConstraints       = CA:FALSE
		#~ keyUsage               = digitalSignature, keyEncipherment
		#~ subjectAltName         = @alternate_names
		#~ nsComment              = "OpenSSL Generated Certificate"

		#~ [ req_ext ]

		#~ subjectKeyIdentifier = hash

		#~ basicConstraints     = CA:FALSE
		#~ keyUsage             = digitalSignature, keyEncipherment
		#~ subjectAltName       = @alternate_names
		#~ nsComment            = "OpenSSL Generated Certificate"

		#~ [ alternate_names ]

		#~ DNS.1       = test.loc

    end
  end

