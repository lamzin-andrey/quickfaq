<?
//!!
function foreign_key() {
	//mysql
	ALTER TABLE photo_image ADD CONSTRAINT fk_cname  FOREIGN KEY (g_id) REFERENCES photo_gallery(id);
	//pgsql
	ALTER TABLE photo_image  ADD CONSTRAINT fk_cname FOREIGN KEY (g_id) REFERENCES photo_gallery (id);
}
function store_proc() {
	//pgsql
	CREATE OR REPLACE FUNCTION Foo
	(
		_int INTEGER,
		_chr VARCAHAR(255)
	)
	RETURNS void AS 
	$BODY$
	DECLARE rec RECORD;
	DECLARE int INTEGER;
	BEGIN
		-- INSERT ...
		-- IF ... THEN ...
		-- END IF ...
	END
	$BODY$
	LANGUAGE 'plpgsql'
	
	//mysql - quick
	DROP IF EXISTS PROCEDURE `Foo`;
	DELIMITER //
	CREATE PROCEDURE `Foo` (IN a INTEGER, IN b INTEGER, OUT c INTEGER)  
	LANGUAGE SQL  
	COMMENT 'The procedure'  
	BEGIN  
		DECLARE variable INTEGER DEFAULT 0;
		-- INSERT
	END//
	
	//mysql - description
	DELIMITER //  
	DROP IF EXISTS PROCEDURE `Foo`
	CREATE PROCEDURE `Foo` (IN a INTEGER, IN b INTEGER, OUT c INTEGER)  
	LANGUAGE SQL  
	DETERMINISTIC  -- Если все время принимает и возвращает одни и те же параметры. По умолчанию  NOT DETERMINISTIC
	SQL SECURITY DEFINER  --(По умолчанию), доступна для вызова создателю, может быть INVOKER (invoker - пользователь, вызывающий хп)
	COMMENT 'The procedure'  
	BEGIN  
		DECLARE variable INTEGER DEFAULT 0;
		-- INSERT
	END//
}

function cursor_example() {
	// -- pgsql
	CREATE OR REPLACE FUNCTION FSelect()
	RETURNS void AS 
	$BODY$
	DECLARE rec RECORD;
	DECLARE int INTEGER;
	BEGIN
		FOR rec IN (SELECT * FROM table_1) LOOP
			-- TODO ;
		END LOOP;
	END
	$BODY$
	LANGUAGE 'plpgsql'
	
	
	// -- mysql
	DROP IF EXISTS PROCEDURE curdem;
	DELIMITER //
	CREATE PROCEDURE curdem()
	LANGUAGE SQL
	BEGIN
		DECLARE intvar, exitflag INTEGER DEFAULT 0;
		DECLARE charvar VARCHAR(12) DEFAULT '';
		DECLARE curr CURSOR FOR SELECT int_field, char_field FROM table_1;
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET exitflag = 1;
		OPEN curr;
		WHILE exitflag = 0 DO
			FETCH curr INTO intvar, charvar;
		END WHILE;
		CLOSE curr;
	END//
}
/**
 * Например, передаем целые числа как строку вида 'a,b,c...'
 * */
function array_param_example() {
	//pgsql
	CREATE OR REPLACE FUNCTION update_products (ids1 TEXT)
	RETURNS void AS 
	$BODY$
		DECLARE my_array int[];
		DECLARE current_id INTEGER;
		DECLARE i INTEGER;
		BEGIN
		  -- my_array = regexp_split_to_array(ids1, E','); /*так тоже можно*/
		  my_array = string_to_array(ids1, ',');
		  i = 1; 
		  WHILE i <= array_length(my_array, 1) LOOP /*к чему тут однерка вторым аргументом я не знаю, но работает ) */
			cur_id_1 = new_records_ids[i];
			INSERT INTO lalog (strval) VALUES (cur_id_1);
			i = i + 1;
		  END LOOP;
		END
	$BODY$
	LANGUAGE 'plpgsql';
}


function trigger() {
	//pgsql
	CREATE OR REPLACE FUNCTION ai_trigger()
	RETURNS TRIGGER
	AS $$
	DECLARE a INTEGER;
	BEGIN
		IF TG_OP = 'INSERT' THEN -- DELETE | UPDATE
		 RETURN NEW;
	    ELSIF TG_OP = 'DELETE' THEN
	     RETURN OLD;
	    END IF;
	END;
	$$ LANGUAGE 'plpgsql';
	
	CREATE TRIGGER t_name
	AFTER INSERT OR UPDATE OR DELETE ON table_name FOR EACH ROW EXECUTE PROCEDURE ai_trigger();
	
	//mysql
	DELIMITER //
	CREATE TRIGGER  `trigger_name` BEFORE INSERT ON `table_1`
	FOR EACH ROW BEGIN
	  -- SET NEW.field...;
	 
	END//
	DELIMITER ;
}

function group_concat (){
	//mysql
	SELECT predmet.id, GROUP_CONCAT(prop.name)
	FROM prop_binder
	LEFT JOIN predmet ON predmet.id = prop_binder.predmet_id
	LEFT JOIN prop ON prop.id = prop_binder.prop_id
	GROUP BY (predmet.id)
	
	//postgresql
	SELECT predmet.id, string_agg(prop.name, ', ')
	FROM prop_binder
	LEFT JOIN predmet ON predmet.id = prop_binder.predmet_id
	LEFT JOIN prop ON prop.id = prop_binder.prop_id
	GROUP BY (predmet.id)
}

function unique_key_example() {
	ALTER TABLE table ADD CONSTRAINT constr_ID UNIQUE (user_id, subj_id, date, time)
}

function random_example() {
	$mysql = 'SELECT * FROM `recipient` ORDER BY RAND() LIMIT 1000';
}

function alter_column_default_value() {
    //postgresql
    -- ALTER TABLE test  ALTER  COLUMN intcol SET DEFAULT 0;
}

function alter_column_drop_if_exists() {
    //postgresql
    -- ALTER TABLE table_name DROP COLUMN IF EXISTS column_name;
}

function comment_column() {
    //postgresql
    "COMMENT ON COLUMN user_profile.push_notification_messages IS 'Подписка пользователя на Push уведомления 0 - отключено, 1 - каждый день, 2 - каждую неделю';"
}

function alter_table_change_primary_key() {
    //ALTER TABLE test ADD CONSTRAINT c_name PRIMARY key (txt,agaga);
    //ALTER TABLE test DROP CONSTRAINT IF EXISTS c_name;
}

function alter_table_change_column_type() {
    //ALTER TABLE products ALTER COLUMN price TYPE numeric(10,2);

}
