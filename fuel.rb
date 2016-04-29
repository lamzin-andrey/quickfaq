module Console
	class Migration					
		def create
			/php oil generate migration/
		end
		def execute
			/php oil refine migrate/
		end
	end
end

module Www
	class Model
		def find(id)
			
		end
		def find('all', ['where' => [ ['field', '=><', value] ] )
			
		end
	end
	class Observer_Custom
		def example
			/*
			Сначала создаем класс 
			namespace Orm;
			extend Observer
			
			Поместить класс можно по слухам куда угодно, назвав его в нижнем регистре
				(если класс называется Observer_MySuperClass, то файл называется  mysuperclass.php)
				
			Если не сработает, то поместить в */
			"fuel/app/classes/orm/observer"
			/*
			В классе модели создать если его нет 
			protected static $_observers = array();
			
			и поместить туда
			'Orm\Observer_MySuperClass' => array(
				'events' => array('after_update', 'after_insert'), #before_* , *_save
			),*/
		end
	end
end
