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
    /myFirstApp.controllers('UserListController', function($scope){
		$scope.users = [{name:'Andrey'}, ...]
    })/
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
end
