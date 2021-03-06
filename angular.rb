module HelloWorld
  def simpleapp
    #Подключаем angular.js
    #В атрибуте контейнера, (можно в том числе и всего html) пишем атрибут ng-app
    #Сразу замечаем, что становится доступен такой прием
    /<p>It work? - {{'Y' + 'e' + 's' + '!'}}</p>
    #Если в открывающемся файле видно надпись It work? - Yes! значит все сделали правильно
    
    #Для Symfony при использовании twig
    #html
    /<p ng-app="appName">It work? - [['Y' + 'e' + 's' + '!']]</p>
    #js
    var appName = angular.module('appName', [])
	.config(function ($interpolateProvider) {
		$interpolateProvider.startSymbol('[[');
		$interpolateProvider.endSymbol(']]');
	})
  end
  
  def hellloBinding
    #<input ng-model="varname">
    #<div>{{ varname }}</div>
    #после этого должно быть все здорово
  end
end
module Controller
  def firstController
    #Контроллеры пишем в файле controllers.js
    #Для начала надо создать приложение. По хорошему его надо поместить в файл app.js
    #  но в виде исключения можно добавить его непосредственно в файл controllers.js
    /var myFirstApp = angular.module('myFirstApp', []);/
    #Далее, для создания контроллера
    /myFirstApp.controller('UserListController', function($scope){
		$scope.users = [{name:'Andrey'}, ...]
		$scope.x = 101;
    })/
    #в данном случае мы не использовали модель, а просто определили массив данных
    
    #В html файле теперь пишем не просто аттрибут ng-app, а задаем ему значение,
    #такое же как и имя приложения, для нашего примера ng-app="myFirstApp"
    
    #Далее, в html создаем или находим блок, в котором надо вывести
    #данные нашего приложения, и добавляем ему атрибут ng-controller="UserListController"
    #После этого в блоке становятся доступны переменные x  и users
    
    #
	#	<div ng-controller="UserListController">
	#	  <p> x = {{ x }} </p> выведет <!-- x = 101 -->
	#	</div>
    #
    
    
    #<ul ng-repeat="user in users">
    #  <li>{{user.name}} </li>
    #</ul>
  end
end

#Вся работа с DOM должна быть в директивах
module Directive
  def example
    #существует краткая и полная форма описания директив
    @see Directive.exShort
    @see Directive.exLong
    #Директивы можно определять в отдельном файла, см. как сделано в JQPlugin2Dir.plugin
    #после этого в определении приложения пишем так:
    angular.module('myApp', ['helloDirective'])
  end
  def exShort
    #где-то в html используем нашу директиву ex-short-dir
    #<div ex-short-dir class="cssClass"></div>
    angular.module('myAppModule', [])
      .directive('exShortDir', function() {
        return function($scope, element, attrs) {
          #//здесь $scope  - это просто разделяемая с контроллером м представлением область видимости
          #//здесь element - наш div
          #//здесь attrs  - атрибуты дива
          
          #мы можем наблюдать за значением аттрибута и реагировать на это
          $scope.watch(attrs.class, function(value) {
            element.text('value was changed. new value: ' + value);
          });
        }
      });
  end
  def exLong
    .directive('exLongDir', function() {
		return {
			restrict : 'A', # или 'E' если ты хочешь использовать вместо стандартного html тега <myTag></myTag>
			link : F # F - это функция, возвращаемая exShort
		}
      });
    @see для большего http://habrahabr.ru/post/179755/
  end
  class JQPlugin2Dir
    def plugin
		#Пусть есть плагин, который в простом JS приложении используется так:
		#html <div id="F"></div>
		$('#F').make(data); #и контейнер с id="F" стал например диаграммой отображающей data
		#вместо этого делаем
		/angular.module('helloDirective', []).directive('make', function () {
		  return {
			restrict: 'A', # или 'E' если ты хочешь использовать вместо стандартного html тега <make><\/make>
			link: function ($scope, $elem, attrs) {
				$elem.make(data);
			}
		  }
		});/
    end
  end
end

module Angular
  class Mmodule
	#на самом деле просто module
	def example
	  angular.module('myAppDirectives', []);#Создали модуль директив приложения, удобно, когда лирективы вынесены в отдельный файл
	  var app = angular.module('myApp', ['myAppDirectives']);#Создали ангуляр - приложение
	end	
	#ниже доступные методы объекта app
	
	def value(name, value)
	  var app = angular('myApp', [])
		.value('myValue', 524)
	  #доступ в контроллере
	  .controller('myController', function(myValue){
		#myValue доступно тут повсюду
	  });
	end
	
	def controller
		@see Controller
	end
  end
  def scope
    $scope
    #В AngularJS $scope и $rootScope – это ключевые сущности для передачи данных между
    #моделью и отображением посредством контроллера.
    #При этом $rootScope – это корневой scope, к которому имеют доступ все, 
    #а  $scope – scope определенного контроллера. Т.е. если бы мы хотели, чтобы другие контроллеры 
    #тоже получили доступ, то нам необходимо было использовать $rootScope
  end
  
  def rootScope
    $rootScope
    @see Angular.scope
  end
  
  def factory
	angular.module('appName', ['appDirectives'])
		/** @param  String serviceName имя сервиса */
		/** @param  Array params 
					сначала перечисляются имена используемых сервисов или компонентову
					потом следует определение сервиса (функция)
		 */
		.factory('Places', ['$http', '$rootScope', function($http, $rootScope) {
			/** Тут на самом деле все основное, функции, пееременные и т п.  */
			var service = {};
			/** и возвращаем все что мы наопределяли */
			return service;
		}]);
  end
  
  class http
    #$http
    def get(sUrl)
      @return Promise
    end
  end
  
  class Promise
    def success(callback)
      #callback(JSONdata)
    end
    def error(callback)
      #callback(responseText, responseStatus, fn)
    end
  end
end

#Здесь перечислены атрибуты, которые начинаются с ng-
module AngularAttrNg
  def repeat
    #<ul ng-repeat="i in [{name:'Andrey'},{name:'Sasha'},{name:'Alexey'}]">
    #  <li>{{i.name}}</li>
	#</ul>
	@see also Controller.firstController
  end
  
  def app
    #Определяет блок на странице, который будет обрабатываться angular
    
    #<div ng-app>{{ 1  +  1}}</div>
    
    #Может иметь значение, равное значению имени приложения
    
    #<div ng-app="myFirstApp">{{ 1  +  1}}</div>
    
    #подробнее
    @see Controller.firstController
    
  end
  
  def controller
    #При добавлении  html блоку в нем становятся доступны переменные, 
    #присвоеные $scope или $rootScope в контроллере
    
    #Пусть в контроллере SimpleController переменной $scope добавляется переменная x
    #<div ng-controller="SImpleController"> SimpleController.x = {{ x }}</div>
  end
  
  def click
    #<div ng-controller="HWController">
      #<span>x = {{ x }}</span>
      #<button ng-click="setX5()">Set x = 5</button>
    #</div>
    
    angular.module('app', []).controller(
      'HWController',
      function($scope) {
        $scope.x = 'init value';
        $scope.setX5 = function() {
          $scope.x = 5;
        }
      }
    );
  end
end

module SPA
  #ng-view, $routeProvider, config(), 
  def example
    ngApp.config(
      function($routeProvider) {
        $routeProvider
          .when('/', {templateUrl: 'root.html', controller:rootController})
          .when('/game', {templateUrl: 'game.html', controller:gameController});
      }
    );
  end
end
module Service
	@see angular.factory
end
module JQPlugin2Dir
	def JQPlugin2Dir
		@see Directive.JQPlugin2Dir.plugin
	end
end
