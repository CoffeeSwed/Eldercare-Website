<?php
include_once("./essentials.php");

class dinner_time{
    private $id;

    private $swedish_name;

    private $english_name;

    private $when;

    public function __construct(){
        
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
}
?>