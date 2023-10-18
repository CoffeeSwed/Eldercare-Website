<?php

class Unit_Test_Entry{
    private $name;
    private $status;
    private $message;


    public function __construct($name,$status,$message){
        $this->setMessage($message);
        $this->setName($name);
        $this->setStatus($status);

		ini_set('display_errors', 1);
		ini_set('display_startup_errors', 1);
		error_reporting(E_ALL);
    }


	/**
	 * @return mixed
	 */
	public function getName() {
		return $this->name;
	}
	
	/**
	 * @param mixed $name 
	 * @return self
	 */
	public function setName($name): self {
		$this->name = $name;
		return $this;
	}

	/**
	 * @return mixed
	 */
	public function getStatus() {
		return $this->status;
	}
	
	/**
	 * @param mixed $status 
	 * @return self
	 */
	public function setStatus($status): self {
		$this->status = $status;
		return $this;
	}

	/**
	 * @return mixed
	 */
	public function getMessage() {
		return $this->message;
	}
	
	/**
	 * @param mixed $message 
	 * @return self
	 */
	public function setMessage($message): self {
		$this->message = $message;
		return $this;
	}

	public function to_array(){
		$arr = array();
		$arr["name"] = $this->getName();
		$arr["status"] = $this->getStatus();
		$arr["message"] = $this->getMessage();
		return $arr;
	}
}

class Unit_Test{
    private $entries;
    private $name;
    private $status;


	public function assert(){

	}

	public function to_array(){
		$arr = array();
		$arr["name"] = $this->getName();
		$arr["status"] = $this->getStatus();
		$arr["entries"] = array();
		foreach($this->getEntries() as $entry){
			array_push($arr["entries"],$entry->to_array());
		}

		return $arr;
	}
    

	/**
	 * @return mixed
	 */
	public function &getEntries() : array {
		return $this->entries;
	}
	
	/**
	 * @param mixed $entries 
	 * @return self
	 */
	public function setEntries($entries): self {
		$this->entries = $entries;
		return $this;
	}

	public function addEntry($entry){
		array_push($this->getEntries(),$entry);
	}

	public function addEntryS($name,$message){
		$this->addEntry(new Unit_Test_Entry($name,STATUS_OK,$message));
	}


	public function addEntryW($name,$message){
		$this->addEntry(new Unit_Test_Entry($name,STATUS_WARNING,$message));
	}


	public function addEntryE($name,$message){
		$this->addEntry(new Unit_Test_Entry($name,STATUS_ERROR,$message));
	}

    public function __construct(){
        $this->setName("");
        $this->setEntries(array());
        $this->setStatus("OK");
		$this->assert();
    }

	/**
	 * @return mixed
	 */
	public function getName() {
		return $this->name;
	}
	
	/**
	 * @param mixed $name 
	 * @return self
	 */
	public function setName($name): self {
		$this->name = $name;
		return $this;
	}

	/**
	 * @return mixed
	 */
	public function getStatus() {
		return $this->status;
	}
	
	/**
	 * @param mixed $status 
	 * @return self
	 */
	public function setStatus($status): self {
		$this->status = $status;
		return $this;
	}

	/**
	 * @return mixed
	 */

	 

}

?>