module gulp
  class Console
    def install
		#Сейчас работаю с 
		#node --version v8.6.0
		#npm  --version 5.6.0
		#gulp -v 3.9.1


		#Установка с нуля на ubuntu 14.04 amd64
		#Если у вас установлены пакеты heroku или cordova смотрите внимательно, они устанавливают node v7 в нестандартноые места  и её не удалишь по нормальному, пока не найдешь

		#После удаления этого мусора в итоге помогло

		sudo apt-get update
		sudo apt-get install nodejs
		sudo apt-get install npm
		sudo npm cache clean -f
		sudo npm install -g n
		sudo n 8.6.0


		#в каталоге приложения 

		sudo npm install -g npm

		sudo npm install -g gulp
		#точно помню что на i386 пришлось также npm install gulp без sudo  и -g иначе не работало, но на amd64 пошло

		npm install laravel-elixir
		(
		https://askubuntu.com/questions/594656/how-to-install-the-latest-versions-of-nodejs-and-npm/635469

		v=8   # set to 4, 5, 6, ... as needed
		v=8; curl -sL https://deb.nodesource.com/setup_$v.x | sudo -E bash -
		 - не помогло, хотя помогло на i386)
		 

		#npm install laravel-elixir-webpack --save-de - на amd64 не ставил, но всё работает, скорее всего были не нужны на самом деле



		Сборка js css

		gulp --production

    end
  end
