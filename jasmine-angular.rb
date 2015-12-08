#Для тестирования angular приложений требуется angular-mocks.js
#все функции  определены в нем если не указано иное
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
				  # в данном случае контролеру необхадима переменная $scope
				  ctrl = $controller('PhoneListCtrl', {$scope:scope});
				  #тут наконец проверяем, как контроллер выполнил свою работу
				  expect(scope.phones.length).toBe(3);
			}));
		  });
	});
  end;
  def module(sAngAppName)
     #инициализует angular приложение которое собираемся тестировать
     #также обеспечивает легкий доступ к переменным angular приложения
     #@see inject
  end
  def inject
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
  end
end
