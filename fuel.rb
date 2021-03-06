module Console
	class Migration					
		def create
			/php oil generate migration/
		end
		def execute
			/php oil refine migrate/
		end
	end
	class ModelGen
		"php oil g model post title:varchar[50] body:text user_id:int"
	end
end

module PrepareConsole
	class Migration
		def createIndexOnField
			\DBUtil::create_index('table', ['field_name'], 'index_name');
		end
		def createUniqueIndexOnField
			\DBUtil::create_index('table', ['field_name'], 'index_name', 'UNIQUE');
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
		def change_field_type
			\DBUtil::modify_fields('agregate_city_user_balance', [
				'created_at' => [
					'comment'       => 'Время создания',
					'null'          => true,
					'type' => 'timestamp',
					'default'=> new \Fuel\Core\Database_Expression('CURRENT_TIMESTAMP')
				]
			]);
		end
		def add_field
		  \DBUtil::add_fields('agregate_info_pages', 
			['agregate_users_id' => array('constraint' => 11, 'type' => 'int', 'unsigned' => true)]
			);
			\DBUtil::create_index('agregate_info_pages', ['agregate_users_id'], 'agregate_users_id_idx');
			$key = ['constraint' => 'fk_agregate_info_pages', 'key' => 'agregate_users_id',
				'reference'	=> [
					'table'	=> 'agregate_users',
					'column'	=> 'id',
				],
				'on_update'	=> 'no action',
				'on_delete'	=> 'no action'
			];
			\DbUtil::add_foreign_key('agregate_info_pages', $key);
		end
		def add_decimal_field
			\DBUtil::add_fields('cities', [
				'lat' => [
					'type' => 'decimal',
					'null' => true,
					'constraint' => [10, 6],
					'default' => 0.00,
					'comment' => 'Широта страна моя родная'
				]
			]);
		end
		def delete_field
			\DBUtil::drop_fields('publications', array(
				'playmarket_name',
				'playmarket_description',
			));
		end
	end
end

module Www
	class Model
		def findWithRelations(id)
			find('all', ['where' => [ ['field', '=><', value]], 'related' => ['status'] ] )
		end
		def find('all', ['where' => [ ['field', '=><', value]] ] )
			# owner = N AND push_allow = 1 AND (push_token <> '' OR platform = 'AndroidV4')
			aClientOwner = Model_Client::find('all', array(
                    'where' => array(
                        array('owner', '=', $oAgregator->owner),
                        array('push_allow', '=', 1),
                        array(
							array('push_token', '<>', ''),
							'or' =>array('platform', '=', 'AndroidV4')
						),
                    ),
                ));
            # owner = N OR push_allow = 1
            aClientOwner = Model_Client::find('all', array(
				'where' => array(
					array('owner', '=', $oAgregator->owner),
					'or' => array('push_allow', '=', 1)
					
				),
			));
            # select only some fields
            aClientOwner = Model_Client::find('all', array(
                    'where' => array(/** .. */),
                    'select' => ['id', 'name']
                ));
            # no use previous cache (No make cache now????....)
            aClientOwner = Model_Client::find('all', array(
                    'where' => array(/** .. */),
                    'select' => ['id', 'name'],
                    `from_cache` => false,
                    'order_by'	=>	['field_name' => 'DESC']
                ));
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
	
	class Validate
	    def usage
			#$oValidation = Model_X::validate('uniquekey');
			#if ($oValidation->run($aData)) {#aData  массив с полями как в модели
				$oX->set($oValidation->validated());
				$oX->save();
			#}
	    end
	    
	    def exampleValidateInModel
			#class Model_X
			public static function validate($factory)
			{
				$val = Validation::forge($factory);
				$val->add_callable('myvalidation');
				$val->add_field('title', 'Тайтл', 'trim|strip_tags|max_length[255]');
				$val->add_field('description', 'META тег description', 'trim|strip_tags|max_length[255]');
				$val->add_field('keywords', 'META тег keywords', 'trim|strip_tags|max_length[255]');
				$val->add_field('heading', 'Заголовок SEO текста', 'trim|strip_tags|max_length[255]');
				$val->add_field('body', 'SEO текст', 'trim|strip_tags|max_length[255]');
				$val->add_field('user_id', '', 'trim|intval');
				return $val;
			}
	    end
	end
	class Cahce end
	class Storage
		def get_storage_path
			return APPPATH.'cache/';
		end
	end
end


module DB
	class Pure
		def singlevalue
			$data = \DB::query('SELECT id FROM t LIMIT 1')->execute();
			#if result exists $data[0]['id']
			#if no exists $data[0] is null
		end
	end
	class Builder
		def insert
			$a = \DB::insert('company_order_statuses')->set(['name' => $s])->execute();
			#if result, insertId will in $a[0]
		end
		def update
			$aIdList = \Arr::pluck($aCategories, 'id');
				\DB::update($sModelClassName::getTableName())->
				set(['city_id' => $nCityId])->
				where('city_id', 'in', $aIdList)->
				execute();
		end
	end
end
