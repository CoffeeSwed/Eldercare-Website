<?php
include_once("./essentials.php");

class Dinner_Time{
    private $id;

    private $swedish_name;

    private $english_name;

    private $when;

    public function __construct($swedish_name = null, $english_name = null, $when = null){
        $this->setSwedish_name($swedish_name);
		$this->setEnglish_name($english_name);
		$this->setWhen($when);
    }
    

	/**
	 * @return mixed
	 */
	public function getId() {
		return $this->id;
	}
	
	/**
	 * @param mixed $id 
	 * @return self
	 */
	public function setId($id): self {
		$this->id = $id;
		return $this;
	}

	/**
	 * @return mixed
	 */
	public function getSwedish_name() {
		return $this->swedish_name;
	}
	
	/**
	 * @param mixed $swedish_name 
	 * @return self
	 */
	public function setSwedish_name($swedish_name): self {
		$this->swedish_name = $swedish_name;
		return $this;
	}

	/**
	 * @return mixed
	 */
	public function getEnglish_name() {
		return $this->english_name;
	}
	
	/**
	 * @param mixed $english_name 
	 * @return self
	 */
	public function setEnglish_name($english_name): self {
		$this->english_name = $english_name;
		return $this;
	}

	/**
	 * @return mixed
	 */
	public function getWhen() {
		return $this->when;
	}
	
	/**
	 * @param mixed $when 
	 * @return self
	 */
	public function setWhen($when): self {
		$this->when = $when;
		return $this;
	}

	public function to_array() : array{
		$arr = array();
		$arr["id"] = intval($this->getId());
		$arr["swedish_name"] = $this->getSwedish_name();
		$arr["english_name"] = $this->getEnglish_name();
		$arr["when"] = $this->getWhen();
		return $arr;
	}
	

}
?>