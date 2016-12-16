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

module PrepareConsole
	class Migration
		def createIndexOnField
			\DBUtil::create_index('table', 'field_name');
		end
	
		#Пример создания внешних ключей
		def up
			$keys = [];
			$keys[] = ['constraint' => 'fk_clients', 'key' => 'clients_id', 
				'reference'	=> [
					'table'	=> 'clients',
					'column'	=> 'id',
				],
				'on_update'	=> 'no action',
				'on_delete'	=> 'no action'
			];
			$keys[] = ['constraint' => 'fk_agregate_users', 'key' => 'agregate_users_id', 
				'reference'	=> [
					'table'	=> 'agregate_users',
					'column'	=> 'id',
				],
				'on_update'	=> 'no action',
				'on_delete'	=> 'no action'
			];
			
			\DBUtil::create_table('web_users', array(
				'id' => array('constraint' => 11, 'type' => 'int', 'auto_increment' => true, 'unsigned' => true),
				'clients_id' => array('constraint' => 11, 'type' => 'int', 'unsigned' => true),
				'agregate_users_id' => array('constraint' => 11, 'type' => 'int', 'comment' => 'Числовой идентификатор локального агрегатора', 'unsigned' => true),
				'email' => array('constraint' => 96, 'type' => 'varchar'),
				'password' => array('constraint' => 255, 'type' => 'varchar'),
				'phone' => array('type' => 'bigint'),
				'is_verify' => array('constraint' => 1, 'type' => 'tinyint', 'default' => 0)

			), array('id'), true, false, null, $keys);
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
