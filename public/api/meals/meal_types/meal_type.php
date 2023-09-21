<?php
    class Meal_Type{
        private $id;
        private $swedish_name;
        private $english_name;
        private $available_at;
    
	/**
	 * @return mixed
	 */

     public function __construct($swedish_name = null, $english_name = null, $available_at = array()){
        $this->setEnglish_name($english_name);
        $this->setSwedish_name($swedish_name);
        $this->setAvailable_at($available_at);
     }

	public function getAvailable_at() {
		return $this->available_at;
	}
	
	
	/**
	 * @param mixed $available_at 
	 * @return self
	 */
	public function setAvailable_at($available_at): self {
		$this->available_at = $available_at;
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

	public function to_array() : array{
		$arr = array();
		$arr["id"] = $this->getId();
		$arr["swedish_name"] = $this->getSwedish_name();
		$arr["english_name"] = $this->getEnglish_name();
		$arr["available_at"] = $this->getAvailable_at();
		return $arr;
	}
}
?>