<?php
require 'Your/Class.php';
class TestYourClass extends  PHPUnit_Framework_TestCase{
	public function testYourPublicMethod() {
		$a = 1;
		$b = 2;
		$this->assertTrue($a == $b);
	}
	/**
	 * @param string $methodName
	 * @param $argument
	*/
	private function _call($methodName, $argument) {
		$className = 'YourClassName';
		$class = new ReflectionClass($className);
        $method = $class->getMethod($methodName);
        $method->setAccessible(true);
        $obj = new $className();
        $data = $method->invoke($obj, $argument);
        return $data;
	}
	/**
	 * @usage $method->invoke($obj, $argument_1, ...);
	 * @param string $methodName
	 * @param $className,
	 * @param &$method,
	 * @param &$obj,
	*/
	private function _open($methodName, $className, &$method, &$obj) {
		$class = new ReflectionClass($className);
        $method = $class->getMethod($methodName);
        $method->setAccessible(true);
        $obj = new $className();
	}
}
