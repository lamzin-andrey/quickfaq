#тут как запустить тесты jasmine используя карму в xubuntu
module install
  def console
    #Для первого запуска
    #@see karma.rb после того как удалось добиться результата выполнения элементарного юнит-теста
    
    #создать файл your/project/folder/test/e2e/1.js
    #(его примерное содержимое есть ниже)
    
    #cd your/project/folder
    #nodejs ./node_modules/protractor/bin/webdriver-manager update
    #nodejs ./node_modules/protractor/bin/webdriver-manager start
    
    #в другом окне терминала
    #npm start
    
    #в другом окне терминала
    #nodejs ./node_modules/protractor/bin/protractor test/protractor.js
    #(его примерное содержимое есть ниже)
    
    #далее настраиваем так, чтобы все тесты запускались сразу, сначала e2e, потом unit
    #секция scripts из файла packejes.json (@see karma.rb)
    "scripts": {
		"prestart": "npm install",
		"start": "http-server -a 0.0.0.0 -p 8000",
		"pretest": "node node_modules/protractor/bin/webdriver-manager update; npm install; http-server -a 0.0.0.0 -p 8000 &",
		"test": "node node_modules/protractor/bin/protractor test/protractor.js; node node_modules/karma/bin/karma start test/karma.conf.js",
		"preupdate-webdriver": "npm install",
		"update-webdriver": "webdriver-manager update"
	  }
	#конец секции
	
	#файл protractor.js пример его содержимого
	
	exports.config = {
	#	//две следующих строки взаимозаменяемы со следующей после них, но при использовании seleniumAddress
	#		//требуется запустить селениум отдельной командой в терминале
	#		//nodejs ./node_modules/protractor/bin/webdriver-manager start
		chromeDriver: './../node_modules/protractor/selenium/chromedriver',
		directConnect: true,/**/
	#	//seleniumAddress: 'http://127.0.0.1:4444/wd/hub',
	#	// Capabilities to be passed to the webdriver instance.
		capabilities: {
		'browserName': 'chrome'
		},
#
#	  // Framework to use. Jasmine 2 is recommended.
	  framework: 'jasmine2',
#
#	  // Spec patterns are relative to the current working directly when
#	  // protractor is called.
	  specs: ['../test/e2e/*.js'],

#	  // Options to be passed to Jasmine.
	  jasmineNodeOpts: {
			showColors:true,
			defaultTimeoutInterval: 30000
	  }
	};


	#пример содержимого e2e/1.js
	
	#//проверяет, содержит ли твой html <div id="helloProtractor">TrakTOR</div>
	describe('First selenium test', function() {
		it('should containts #helloProtractor with text TrakTOR', function() {
			browser.get('http://0.0.0.0:8000/');
			#//element(by.id('helloProtractor')).sendKeys('Julie');
			expect(
				element(by.id('helloProtractor'))
					.getText()
			).toEqual('TrakTOR');
		});
	});

	
  end
end
