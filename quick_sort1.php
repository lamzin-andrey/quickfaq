<? //start 23 17
//23 22 не смог вспомнить, лезу в шпору
//23 29 дописал по памяти, не работает, смотрю опять в шпору
//23 30 - complete

global $nQsExch;
$nQsExch = 0;

function qs(&$data, $left = 0, $right = null) {
	global $nQsExch;
	if ($right == null) {
		$right = count($data) - 1;
	}
	$i = $left;
	$j = $right;
	$t = $data[ round( $i + $j  / 2) ];
	do {
		while ($data[$i] < $t) $i++;
		while ($data[$j] > $t) $j--;
		if ($i <= $j) {
			if ($i < $j) {
				$b = $data[$i];
				$data[$i] = $data[$j];
				$data[$j] = $b;
				$nQsExch++;
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
echo "qs quantity exchanges = {$nQsExch}\n";

$data = array(5, 1, 15, 25, -1, 0);
$nSz = count($data);
$nBExch = 0;

for ($i = 0; $i < $nSz; $i++) {
	for ($j = 0; $j < $nSz; $j++) {
		if ($data[$i] < $data[$j]) {
			$b = $data[$i];
			$data[$i] = $data[$j];
			$data[$j] = $b;
			$nBExch++;
		}
	}
}
var_dump($data);
echo "boobble quantity exchanges = {$nBExch}\n";
