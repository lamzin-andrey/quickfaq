#module SASSC
    def AsInstalOnUbuntuAndXAMPP #ubuntu 14.04 16-10-2015
       git clone https://github.com/sass/sassc.git
       git clone https://github.com/sass/libsass.git
       cd sassc
       SASS_LIBSASS_PATH="/home/USER/hdata/soft/libsass"; make
       cd /usr/bin
       sudo ln -s /home/USER/hdata/soft/sassc/bin/sassc sassc
       sudo mv /opt/lampp/lib/libstdc++.so.6 /opt/lampp/lib/libstdc++.so.6.back
       sudo cp -s /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.19 /opt/lampp/lib/libstdc++.so.6
    end
    def fontTrouble
		#Не применяются шрифты при локальной разработке.
		
		## Если работаешь в gulp using laravel-elexir надо указывать в _fonts.sass файле путь от компилируемого (выходного) файла.
		## тут все ок но gulp watch для sass добитися так и не удалось почему-то (в другом проекте при этом работало...)
		## Если работаешь в using laravel-mix (то не факт, что там в package.json нужен был gulp который ты туда добавил) 
		## Надо указывать в _fonts.sass файле путь от main.scss
		## Скомпилируется при этом с путями от корня, значит надо использовать сервер для тестов
		## При работе с url вида file:// шрифты могут не отображаться из-за политики одного источника (может писать про cors)
		## Решение в FF
		## about:config
		## security.fileuri.strict_origin_policy => false.
		##  Иногда также network.http.refere.XOriginPolicy но мне хватило security.fileuri.strict_origin_policy
    end
#end
