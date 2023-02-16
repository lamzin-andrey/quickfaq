def select_offset
	# SELECT *  FROM `analytics-376010.test_dataset.payments` 
	# WHERE payment_type = 'fine'
	# ORDER BY `payment_time` ASC 
	# LIMIT 10 OFFSET 10
end

def alter
/*
ALTER TABLE analytics-376010.test_dataset.user_channels
ADD COLUMN company_id STRING;

ALTER TABLE analytics-376010.test_dataset.user_channels
DROP COLUMN chanel;

	ALTER TABLE analytics-376010.test_dataset.user_channels
	RENAME COLUMN old_name TO new_name;

ALTER TABLE mydataset.mytable
ALTER COLUMN mycolumn SET DATA TYPE NUMERIC;

ALTER TABLE mydataset.mytable
ALTER COLUMN mycolumn
DROP NOT NULL;

ALTER TABLE analytics-376010.test_dataset.osago_event_extend_data
ALTER COLUMN event_communication_type
SET DEFAULT NULL;

DELETE FROM test_dataset.osago_event_extend_data WHERE true;
*/
end
