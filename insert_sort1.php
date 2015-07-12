<? //start 23 01
//end 23 14
class Node {
	public $left = 0;
	public $right = 0;
	public $data;
	
	public function __construct($n) {
		$this->data = $n;
	}
}

class InsertSort {
	private $root = null;
	private $sorted = array();
	
	public function __construct($aList) {
		for ($i = 0; $i < count($aList); $i++) {
			if ($i == 0) {
				$this->first($aList[$i]);
			} else {
				$this->searchInsert($aList[$i]);
			}
		}
	}
	
	public function searchInsert($n) {
		$p = $this->root;
		$prev;
		
		while ($p) {
			$prev = $p;
			if ($p->data == $n) {
				return $p;
			}
			if ($p->data > $n) {
				$p = $p->left;
			} else {
				$p = $p->right;
			}
		}
		
		$node = new Node();
		$node->data = $n;
		$p = $prev;
		if ($p->data > $n) {
			$p->left = $node;
		} else {
			$p->right = $node;
		}
		return $node;
	}
	
	public function sort($p = null) {
		if ($p === null) {
			$this->sorted = array();
			$p = $this->root;
		}
		
		if ($p) {
			$this->sort($p->left);
			$this->sorted[] = $p->data;
			$this->sort($p->right);
		}
		return $this->sorted;
	}
	
	public function first($n) {
		$this->root = new Node($n);
	}
}


$data = array(5, 1, 15, 25, -1, 0);
$srt = new InsertSort($data);
var_dump($srt->sort());
