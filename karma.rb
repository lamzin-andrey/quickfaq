#тут как запустить тесты jasmine используя карму в xubuntu
module install
  def console
    #sudo apt-get install npm
    #sudo npm install -g karma
    #sudo npm install -g node.js
    #if xubuntu
    #ln -s /usr/bin/nodejs /usr/bin/node
    
    #Для того, чтобы запустить тесты jasmine под управлением karma надо создать файл 
    #package.json в директории приложения
    ####################################################################
    #комментарии в файле недопустимы
    {
	  "version": "0.0.0",
	  "private": true,
	  "name": "hello-npm",
	  "devDependencies": { #версии используемых node приложений
		"karma": "^0.12.16",
		"karma-chrome-launcher": "^0.1.4",
		"karma-firefox-launcher": "^0.1.3",
		"karma-jasmine": "~0.1.0",
		"protractor": "^2.1.0",
		"http-server": "^0.6.1",
		"tmp": "0.0.23",
		"shelljs": "^0.2.6"
	  },
	  #консольные команды, доступные в каталоге приложения
	  #npm start, npm test, npm update-webdriver
	  "scripts": {
		"prestart": "npm install", #перед запуском установит зависимости devDependencies
		"start": "http-server -a 0.0.0.0 -p 8000", #запуск локального веб сервера

		"pretest": "npm install", #перед запуском установит зависимости devDependencies
		#команды запуска теста, тут путь к следующему конфигу
		"test": "node node_modules/karma/bin/karma start test/karma.conf.js",
		"test-single-run": "node node_modules/karma/bin/karma start test/karma.conf.js  --single-run",

		"preupdate-webdriver": "npm install",
		"update-webdriver": "webdriver-manager update"
	  }
	}
    ####################################################################
    #пример содержимого файла test/karma.conf.js
    ####################################################################
    #module.exports = function(config){
	  config.set({
		basePath : '../',  #каталог test вложен в каталог приложения
		#здесь перечисляем все js файлы, которые подключает наше веб-приложение
		# + файлы тестов
		files : [
		  'js/object.js',
		  'test/unit/**/*.js'
		],
		autoWatch : true,
		#тут видимо перечисляются только test фреймверки
		frameworks: ['jasmine'],
		#браузеры, которые будут запускаться
		browsers : ['Chrome', 'Firefox'],
		#плагины, которые будут использоваться
		plugins : [
				'karma-chrome-launcher',
				'karma-firefox-launcher',
				'karma-jasmine'
				],
		#TODO разобраться
		junitReporter : {
		  outputFile: 'test_out/unit.xml',
		  suite: 'unit'
		}

	  });
	};
    ####################################################################
    #cd your/project/folder
    #npm start
    #если никак, то один раз
    #sudo npm start
    #это соберет недостающее, например node-gyp
    # а потом можно 
    #sudo chmod -R 777 ./node_modules
    #rm -r ./node_modules
    #npm start
    #npm test
  end
end
