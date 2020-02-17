<?php

public function setConnection() {
	//2020
	$manager = new MongoDB\Driver\Manager("mongodb://127.0.0.1:27017");
	$filter = ['id' => 2];
	$options = [];
	/*$options = [
		'projection' => ['_id' => 0],
		'sort' => ['x' => -1],
	];*/
	$query = new MongoDB\Driver\Query($filter, $options);
	$cursor = $manager->executeQuery('hello2020.goods', $query);
	

	foreach ($cursor as $entry) {
		var_dump($entry);
	}
	die
	
	//old
    $config = array(
    'test' => array(
        'ip'   => '192.168.0.247',
        'port' => '27017',
        'name' => 'basename',
    ),
    'dev' => array(
        'ip'   => '192.168.0.253',
        'name' => 'basename',
        'port' => '27017'
    )
    $is_test = true;
    $server = $is_test ? 'test' : 'dev';
    $host = $config[$server]['ip'];
    $port = $config[$server]['port'];
    $dbname   = $config[$server]['name'];
    
    $conn = new Mongo($host);
     // access database
    $db = $conn->$dbname;
     // access collection
    $collection = $db->smsloger;//smsloger - collection name
    $cursor = $collection->find(array('phone' => $this->phone));
    //@see remove example
}

public function remove_example()
{
    $mongo = \Yii::app()->mongodb->getDbInstance();
    //как получить коллекцию не используя yii @see setConnection
    $mongoCollection = $mongo->selectCollection('push_messages_loger');
    
    $cursor = $mongoCollection->find();


    $quantityRemoved = 0;
    foreach ($cursor as $obj) {
        if ($obj && isset($obj['msg'])) {
            if (strpos($obj['msg'], 'Certificate') === 0) {
                echo "remove object with msg '" . substr($obj['msg'], 0, 50) . "'...\n";
                echo "try remove object with id '" . $obj['_id'] . "'...\n";
                $criteria = array(
                    '_id' => new MongoId($obj['_id']),//for example $obj['_id'] == '4bea96b400f4784c0a070000'
                );
                $report = $mongoCollection->remove($criteria, ['safe' => true]);
                echo 'Removed document with ID: ' . $criteria['_id'];
                echo '<pre>';
                print_r($report);
                echo '</pre>';
                if (!$report['err']) {
                    $quantityRemoved++;
                }
            }
        }
    }
    return true;
}
