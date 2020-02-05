#Для тестирования angular приложений требуется angular-mocks.js
#все функции "keywords" определены в нем если не указано иное
module jasmineAngular
  def controllerTest
	  describe('PhoneCat controllers', function() {
		  describe('PhoneListCtrl', function(){
				beforeEach(module('phonecatApp')); #module перед каждым вызовом it инициализует приложение angular phonecatApp
				
				it('should create "phones" model with 3 phones', inject(function($controller) {
				  #$controller - метод angular приложения позволяющий выполнить здесь код контроллера
				  var scope = {},
				  #первый аргумент - имя контроллера,
				  #второй аргумент - объект для инициализации переменных, которые нужны контроллеру
				  # в данном случае контролеру необходима переменная $scope
				  ctrl = $controller('PhoneListCtrl', {$scope:scope});
				  #тут наконец проверяем, как контроллер выполнил свою работу
				  expect(scope.phones.length).toBe(3);
			}));
		  });
	});
  end;
  class keywords
	  def module(sAngAppName)
		 #инициализует angular приложение которое собираемся тестировать
		 #также обеспечивает легкий доступ к переменным angular приложения
		 #@see inject
	  end
	  def inject
		#inject Позволяет получать в коде теста доступ к переменным приложения, определенным через value()
		#		также можно выполнить код контроллера или получить какой-нибудь из сервисов angular,
		#       например http
		
		#что касается value()
		#рассмотрим пример из комментария в файле angular-mocks.js
		#часть кода anguular - приложения
		#angular.module('myApplicationModule', [])
		#       .value('mode', 'app')
		#       .value('version', 'v1.0.1');
		
		#а потом тестируем
		describe('MyApp', function() {
		  #// You need to load modules that you want to test,
		  #// it loads only the "ng" module by default.
		  #Подгрузили наш модуль приложения перед каждым вызовом it
		  
		  beforeEach(module('myApplicationModule'));
		  #// inject() is used to inject arguments of all given functions
		  it('should provide a version', inject(function(mode, version) {
		   expect(version).toEqual('v1.0.1');
		   expect(mode).toEqual('app');
		  }));
		  #Благодаря тому, что мы завернули callback в inject 
		  #мы получили (легкий) доступ к переменным angular приложения mode и version
			
		  #// The inject and module method can also be used inside of the it or beforeEach
		  
		  it('should override a version and test the new version is injected', function() {
			#// module() takes functions or strings (module aliases)
			#вот так легко можно изменить значение переменной тестируемого модуля
			#(а оно будет восстановлено перед запуском след. в beforeEach)
			module(function($provide) { #здесь $provide is 'myApplicationModule' плотому что в beforeEach мы инициализуем этот модуль
			  $provide.value('version', 'overridden'); #// override version here
			});
			#для проверки значения version снова используем inject
			inject(function(version) {
				expect(version).toEqual('overridden');
			  });
			});
		  });
		  #Конец рассмотрения примера из комментария
		  
		  #Что касается выполнения кода контроллера @see controllerTest
		  
		  #Что касается получения сервисов angular, например $http
		  #представим, что контроллер PhoneListCtrl использует не только $scope но и $http
		  
		  angular.module('phonecatApp', [])
		  .controller('PhoneListCtrl', 
			function ($scope, $http) {
				/* ... */
			});
			
		  #тогда в тесте мы можем сделать так
		  describe('PhoneCat controllers', function() {
			  describe('PhoneListCtrl', function(){
					beforeEach(module('phonecatApp')); #module перед каждым вызовом it инициализует приложение angular phonecatApp
					
					it('should create "phones" model with 3 phones', inject(function($controller, $injector) {
					  #$injector   - метод angular приложения позволяющий получать здесь различные сервисы приложения
					  var scope = {},
						#получили в переменную http сервис $http
						http = $injector.get('$http'),
					  #$controller - метод angular приложения позволяющий выполнить здесь код контроллера
					  #первый аргумент - имя контроллера,
					  #второй аргумент - объект для инициализации переменных, которые нужны контроллеру
					  # в данном случае контролеру необходимы переменные $scope и $http.
					  #причем если для scope часто вполне подойдет пустой объект
					  #для $http нужен имено он сам - сервис, позволяющий выполнять ajax запросы из аngular приложения.
					  #поэтому мы его получили выше используя $injector
					  ctrl = $controller('PhoneListCtrl', {$scope:scope, $http:http});
					  #тут наконец проверяем, как контроллер выполнил свою работу
					  expect(scope.phones.length).toBe(3);
				}));
			  });
		});
		  
	  end
	  def httpBackend
		$httpBackend #(на самом деле так называется)
		# это инструмент, определенный в angular-mock.js
		# используется для имитации ответов на ajax запросы 
		@see ajaxTest.example
	  end
  end
  class ajaxTest
	def example
		#для имитации ответов на запросы используется сервис $httpBackend  - инструмент, определенный в angular-mock.js
		describe('Get Cnf', function() {
			//первые три переменные - это будущие ссылки на полученные в процессе теста сервисы
			/** @var httpBackend  - инструмент, определенный в angular-mock.js позводяющий имитировать ответ от сервера */
			var httpBackend,
			/** @var controller метод angular приложения позволяющий выполнить здесь код контроллера */
			controller, 
			/** @var сервис angular, позволяющий выполнять http запросы */
			http,
			
			/** @var Это просто данные которые пришлет наш имитатор сервера */
			response = {"graphs":["Regdate"]};
	 
		//перед каждым it
		beforeEach(function() {
			//module перед каждым вызовом it инициализует приложение angular phonecatApp
			module('StatisticApp');
			
			/** @param $injector инструмент, позволяющий получать различные angular сервисы, такие как $http. Он же позволить получить $httpBackend из angular-mock */
			/** @param controller метод angular приложения позволяющий выполнить здесь код контроллера */
			inject(function($injector, $controller) {
				controller = $controller;				//он нам понадобится, сохраним на него ссылку
				//$httpBackend  - инструмент, определенный в angular-mock.js позводяющий имитировать ответ от сервера
				//мы можем получить его с помощью $injector - за этим $injector нам и нужен
				httpBackend = $injector.get('$httpBackend');
				//http - сервис angular, позволяющий выполнять http запросы
				//мы можем получить его с помощью $injector - за этим $injector нам и нужен
				http = $injector.get('$http');
				
				//!! а вот тут мы пишем "когда приложение сделает POST запрос на адрес /stats, вернуть ему response"
				httpBackend.when('POST', '/stats').respond(response);
			});
		});
	 
		//После каждого it
		afterEach(function() {
			//отменяем $httpBackend.expectPOST, то есть перестаем ожидать что приложение должно его отправить
			//	это надо чтобы остальные тесты выполнились если наш так и не дождался выполнения отправить
			httpBackend.verifyNoOutstandingExpectation();
			//перестаем ожидать что "сервер" ответит на запрос
			//	это надо чтобы остальные тесты выполнились если наш так и не дождался ответа
			httpBackend.verifyNoOutstandingRequest();
		});
	 
		//собственно, тест
		it('calls stats', function() {
			//мы ждем, что приложение наше должно отправить POST запрос на адрес  /stats
			httpBackend.expectPOST('/stats');
			var scope = {},
			//первый аргумент - имя контроллера,
			//второй аргумент - объект для инициализации переменных, которые нужны контроллеру
			//в данном случае контролеру необходимы переменные $scope и $http
			
			//Наш контроллер должен выполнить POST запрос на адрес  /stats (потому что так в контроллере написано!)
			ctrl = controller('AppController', {$scope:scope, $http:http});
			//После вызова flush() должны прийти гответы на запросы
			httpBackend.flush();
			//ну и наклонец посмотрим, что получилось и получилось ли???
			expect(scope.Cfg.graphs[0]).toBe('Regdate');
		});
	 
	  
	});
	end
  end
end
