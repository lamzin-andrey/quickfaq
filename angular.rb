module HelloWorld
  def simpleapp
    #Подключаем angular.js
    #В атрибуте контейнера, (можно в том числе и всего html) пишем атрибут ng-app
    #Сразу замечаем, что становится доступен такой прием
    /<p>It work? - {{'Y' + 'e' + 's' + '!'}}</p>
    #Если в открывающемся файле видно надпись It work? - Yes! значит все сделали правильно
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

module Angular
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
end
