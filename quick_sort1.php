<? //start 23 17
//23 22 не смог вспомнить, лезу в шпору
//23 29 дописал по памяти, не работает, смотрю опять в шпору
//23 30 - complete

function qs(&$data, $left = 0, $right = null) {
	if ($right == null) {
		$right = count($data) - 1;
	}
	$i = $left;
	$j = $right;
	$t = $data[ round( $i + $j ) / 2 ];
	do {
		while ($data[$i] < $t) $i++;
		while ($data[$j] > $t) $j--;
		if ($i <= $j) {
			if ($i < $j) {
				$b = $data[$i];
				$data[$i] = $data[$j];
				$data[$j] = $b;
			}
			$i++;
			$j--;
		}
	}while ($i < $j);
	
	if ($i < $right) {
		qs($data, $i, $right);
	}
	
	if ($left < $j) {
		qs($data, $left, $j);
	}
	return $data;
}

$data = array(5, 1, 15, 25, -1, 0);
qs($data);
var_dump($data);
