module Index
 #https://ruhighload.com/%D0%98%D1%81%D0%BF%D0%BE%D0%BB%D1%8C%D0%B7%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5+%D0%B8%D0%BD%D0%B4%D0%B5%D0%BA%D1%81%D0%BE%D0%B2+%D0%B2+clickhouse
 #~ CREATE TABLE products_views (
    #~ date Date,
    #~ product_id UInt32,
    #~ product_name String,
    #~ product_category UInt8
#~ ) ENGINE = MergeTree(date, (product_id), 8192)


#~ Конструкция MergeTree объявляет индекс:

    #~ date — название колонки, в которой находится дата. В clickhouse это обязательно, т.к. все данные всегда распределены по значениям этой колонки.
    #~ product_id — название колонки, по которой строится индекс.
    #~ 8192 — гранулированность индекса (используйте значение из примера). 

#~ С такой структурой индекса, запросы будут эффективными:

#~ SELECT count(*) FROM products_views WHERE product_id = 751

#~ # в таком запросе будет использован индекс

#~ Индекс может состоять из нескольких колонок (составной индекс):

#~ CREATE TABLE products_views (
    #~ date Date,
    #~ product_id UInt32,
    #~ product_name String,
    #~ product_category UInt8
#~ ) ENGINE = MergeTree(date, (product_id, url), 8192)

#~ # Составной индекс

#~ Однако в этом случае, в выборке могут использоваться колонки слева-направо
 #~ (фильтр по одной только колонке url не использует индекс).
 #~ Как и в других базах данных индекс будет использован в случае не только равенства, а и неравенства и операции IN. 


#~ CREATE TABLE IF NOT EXISTS `mytable` (
            #~ `date` Date,
            #~ `_timestamp` INTEGER DEFAULT 0,
            #~ `is_banned` INTEGER DEFAULT 0,
            #~ `is_success` INTEGER DEFAULT 0,
            #~ fee_amount DECIMAL(10,2)
            #~ `proxy_name` String,
            #~ `error_code` String,
            #~ `created_time` DateTime(\'Europe/Moscow\')
#~ )ENGINE=MergeTree(date, (`_timestamp`, `proxy_name`), 8192);
 
end

def drop
  # DROP TABLE foo
end


def update
	#$sql = 'ALTER TABLE `active_android_users_daily_aggregate_data`
				#UPDATE 
					#`n` = :n
				#WHERE 
					#`date` = :date';
end

def delete
  # ALTER TABLE `foo` DELETE WHERE vehicle_plate IN (:plates)
end

def config
	clickhouse:
		driver_class: FOD\DBALClickHouse\Driver
		wrapper_class: FOD\DBALClickHouse\Connection
		options:
			enable_http_compression: 1
			max_execution_time: 60
		url: '%env(DB_CLICKHOUSE_URL)%' # .env: DB_CLICKHOUSE_URL=//default:798420Wd@host.ru:8123/default
end

def replicationMergeTree

#CREATE TABLE default.foo ON CLUSTER '{cluster}' (
    #date Date,
    #quantity_pushed_with_policies UInt32,
    #quantity_prolongated UInt32
#) 
#ENGINE = ReplicatedMergeTree('/clickhouse/tables/{cluster}/{shard}/default/foo', '{replica}')
#PARTITION BY `date`
#ORDER BY `date`
#SETTINGS index_granularity = 8192;

 #CREATE TABLE IF NOT EXISTS ins_partner_offer_statistic ON CLUSTER '{cluster}'
#(
#`user_id` UInt32,
#`policy_form_id` Int32,
#`offer_id` Int32,
#`created_on` DateTime,
#`action_time` DateTime,
#`insurance_company_id` Int32,
#`price` Decimal(10, 2),
#`is_final` Int32,
#`phone` String,
#`full_user_name` String,
#`vehicle_plate` String,
#`car_mark` String,
#`car_model` String,
#`policy_date_end` DateTime,
#`date` Date
#)
#ENGINE = ReplicatedMergeTree('/clickhouse/tables/{cluster}/{shard}/default/ins_partner_offer_statistic', '{replica}')
#CREATE TABLE IF NOT EXISTS ins_partner_offer_statistic_old ON CLUSTER '{cluster}'
#(
#`user_id` Int32 DEFAULT 0,
#`policy_form_id` Int32 DEFAULT 0,
#`offer_id` Int32 DEFAULT 0,
#`created_on` DateTime,
#`action_time` DateTime,
#`insurance_company_id` Int32,
#`price` Decimal(10, 2),
#`is_final` Int32,
#`date` Date
#)
#ENGINE = ReplicatedMergeTree('/clickhouse/tables/{cluster}/{shard}/default/ins_partner_offer_statistic_old', '{replica}')
#CREATE TABLE IF NOT EXISTS ins_test_alter_table ON CLUSTER '{cluster}'
#(
#`date` Date,
#`product_id` UInt32,
#`user_id` UInt32,
#`product_name` String,
#`product_category` UInt8
#)
#ENGINE = ReplicatedMergeTree('/clickhouse/tables/{cluster}/{shard}/default/ins_test_alter_table', '{replica}')
#CREATE TABLE IF NOT EXISTS insurance_captcha_proxy_usage_log ON CLUSTER '{cluster}'
#(
#`date` Date,
#`_timestamp` Int32 DEFAULT 0,
#`is_banned` Int32 DEFAULT 0,
#`is_success` Int32 DEFAULT 0,
#`proxy_name` String,
#`error_code` String,
#`created_time` DateTime('Europe/Moscow')
#)
#ENGINE = ReplicatedMergeTree('/clickhouse/tables/{cluster}/{shard}/default/insurance_captcha_proxy_usage_log', '{replica}')
#CREATE TABLE IF NOT EXISTS insurance_export_vehicle_plates ON CLUSTER '{cluster}'
#(
#`date` Date,
#`vehicle_plate` String,
#`_timestamp` Int32 DEFAULT 0
#)
#ENGINE = ReplicatedMergeTree('/clickhouse/tables/{cluster}/{shard}/default/insurance_export_vehicle_plates', '{replica}')
#CREATE TABLE IF NOT EXISTS insurance_osago_pushes_from_step_queue ON CLUSTER '{cluster}'
#(
#`date` Date,
#`user_id` Int32 DEFAULT 0,
#`planing_send_time` Int32 DEFAULT 0,
#`text` String,
#`step_id` Int32,
#`step_str_id` String,
#`osago_inner_push_type_id` Int32,
#`url` String,
#`double_index` Int32,
#`created_time` DateTime('Europe/Moscow'),
#`af_insurance_policy_request_id` Int32 DEFAULT 0
#)
#ENGINE = ReplicatedMergeTree('/clickhouse/tables/{cluster}/{shard}/default/insurance_osago_pushes_from_step_queue', '{replica}')
#CREATE TABLE IF NOT EXISTS insurance_osago_pushes_service_log ON CLUSTER '{cluster}'
#(
#`date` Date,
#`user_id` Int32 DEFAULT 0,
#`osago_inner_push_type_id` Int32 DEFAULT 0,
#`osago_inner_push_subtype_id` Int32 DEFAULT 0,
#`created_time` DateTime('Europe/Moscow'),
#`af_insurance_policy_request_id` Int32 DEFAULT 0
#)
#ENGINE = ReplicatedMergeTree('/clickhouse/tables/{cluster}/{shard}/default/insurance_osago_pushes_service_log', '{replica}')
#CREATE TABLE IF NOT EXISTS insurance_osago_pushes_service_log2 ON CLUSTER '{cluster}'
#(
#`date` Date,
#`user_id` Int32 DEFAULT 0,
#`osago_inner_push_type_id` Int32 DEFAULT 0,
#`osago_inner_push_subtype_id` Int32 DEFAULT 0,
#`af_insurance_policy_request_id` Int32 DEFAULT 0,
#`created_time` DateTime('Europe/Moscow')
#)
#ENGINE = ReplicatedMergeTree('/clickhouse/tables/{cluster}/{shard}/default/insurance_osago_pushes_service_log2', '{replica}')
#CREATE TABLE IF NOT EXISTS insurance_osago_stat_service_log ON CLUSTER '{cluster}'
#(
#`date` Date,
#`event_name` String,
#`user_id` Int32 DEFAULT 0,
#`osago_inner_stat_event_id` String,
#`osago_inner_stat_experiment_id` String,
#`created_time` DateTime('Europe/Moscow')
#)
#ENGINE = ReplicatedMergeTree('/clickhouse/tables/{cluster}/{shard}/default/insurance_osago_stat_service_log', '{replica}')
#CREATE TABLE IF NOT EXISTS insurance_osago_stat_service_log2 ON CLUSTER '{cluster}'
#(
#`date` Date,
#`event_name` String,
#`user_id` Int32 DEFAULT 0,
#`osago_inner_stat_event_id` String,
#`osago_inner_stat_experiment_id` String,
#`created_time` DateTime('Europe/Moscow')
#)
#ENGINE = ReplicatedMergeTree('/clickhouse/tables/{cluster}/{shard}/default/insurance_osago_stat_service_log2', '{replica}')
#CREATE TABLE IF NOT EXISTS migration_versions ON CLUSTER '{cluster}'
#(
#`EventDate` Date DEFAULT today(),
#`version` String,
#`executed_at` DateTime
#)
#ENGINE = ReplicatedMergeTree('/clickhouse/tables/{cluster}/{shard}/default/migration_versions', '{replica}')
#CREATE TABLE IF NOT EXISTS migration_versions_olap_main ON CLUSTER '{cluster}'
#(
#`EventDate` Date DEFAULT today(),
#`version` String,
#`executed_at` DateTime
#)
#ENGINE = ReplicatedMergeTree('/clickhouse/tables/{cluster}/{shard}/default/migration_versions_olap_main', '{replica}')
#CREATE TABLE IF NOT EXISTS payments_agregate_info_2021_2022_01_02 ON CLUSTER '{cluster}'
#(
#`user_id` Int32,
#`payment_time` DateTime('Europe/Moscow'),
#`registration_date` DateTime('Europe/Moscow'),
#`quantity_items_in_payment` Int32 DEFAULT 0,
#`payment_type` String,
#`fee_amount` Decimal(10, 2),
#`source_pk` Int32,
#`dt` Date
#)
#ENGINE = ReplicatedMergeTree('/clickhouse/tables/{cluster}/{shard}/default/payments_agregate_info_2021_2022_01_02', '{replica}')
#CREATE TABLE IF NOT EXISTS payments_insurance_history ON CLUSTER '{cluster}'
#(
#`source_pk` Int32,
#`payment_type` String,
#`created_time` DateTime('Europe/Moscow'),
#`fee_amount` Decimal(10, 2),
#`dt` Date
#)
#ENGINE = ReplicatedMergeTree('/clickhouse/tables/{cluster}/{shard}/default/payments_insurance_history', '{replica}')
#CREATE TABLE IF NOT EXISTS payments_insurance_info ON CLUSTER '{cluster}'
#(
#`user_id` Int32,
#`payment_time` DateTime('Europe/Moscow'),
#`registration_date` DateTime('Europe/Moscow'),
#`quantity_items_in_payment` Int32 DEFAULT 0,
#`payment_type` String,
#`fee_amount` Decimal(10, 2),
#`source_pk` Int32,
#`dt` Date
#)
#ENGINE = ReplicatedMergeTree('/clickhouse/tables/{cluster}/{shard}/default/payments_insurance_info', '{replica}')
#CREATE TABLE IF NOT EXISTS payments_insurance_info_2 ON CLUSTER '{cluster}'
#(
#`user_id` Int32,
#`payment_time` DateTime('Europe/Moscow'),
#`registration_date` DateTime('Europe/Moscow'),
#`quantity_items_in_payment` Int32 DEFAULT 0,
#`payment_type` String,
#`fee_amount` Decimal(10, 2),
#`fee_amount2` Float64,
#`source_pk` Int32,
#`dt` Date
#)
#ENGINE = ReplicatedMergeTree('/clickhouse/tables/{cluster}/{shard}/default/payments_insurance_info_2', '{replica}')
#CREATE TABLE IF NOT EXISTS products_views ON CLUSTER '{cluster}'
#(
#`date` Date,
#`product_id` UInt32,
#`user_id` UInt32,
#`product_name` String,
#`product_category` UInt8
#)
#ENGINE = ReplicatedMergeTree('/clickhouse/tables/{cluster}/{shard}/default/products_views', '{replica}')
end

def addColumn
 # ALTER TABLE marketing_push_osago_expired_month_concrete_stat ADD COLUMN unsubscribed_osago_users UInt32 LAST
end

def over
  #Вот пример оконной функции в ClickHouse:

	#SELECT
	  #date,
	  #product_id,
	  #sales,
	  #SUM(sales) OVER (PARTITION BY product_id ORDER BY date) AS running_total
	#FROM sales_data;

  #Здесь оконной функцией SUM вычисляется нарастающий итог продаж по каждому продукту, 
   #сгруппированный по столбцу product_id.
   #Фрейм окна задается с PARTITION BY product_id для разделения результирующего набора на партиции по product_id 
    #и с ORDER BY date для указания, в каком порядке оконной функцией обрабатываются строки.
   #Выводу оконной функции присваивается псевдоним running_total.

   #В ClickHouse оконные функции используются не в WHERE и HAVING, а только в предложении SELECT запроса,
     #а также с другими функциями, например агрегатными, для более сложного анализа данных.
end
