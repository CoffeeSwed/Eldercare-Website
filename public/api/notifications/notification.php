<?php
include_once(__DIR__."/../user/user.php");
    class Notification{

        
        private ?String $swedish_message = null;
        private ?String $english_message = null;

		private ?String $criticality = NOTIFICATION_CRITICALITY_NONE;
		private ?String $id = null;
    


	public function getSwedish_message(): ?String {
		return $this->swedish_message;
	}
	
	/**
	 * @param string $swedish_message 
	 * @return self
	 */
	public function setSwedish_message(string $swedish_message): self {
		$this->swedish_message = $swedish_message;
		return $this;
	}

	
	public function getEnglish_message(): ?String {
		return $this->english_message;
	}
	
	/**
	 * @param string $english_message 
	 * @return self
	 */
	public function setEnglish_message(string $english_message): self {
		$this->english_message = $english_message;
		return $this;
	}

	public function to_array(){
		$arr = array();
		$arr["swedish_message"] = $this->getSwedish_message();
		$arr["english_message"] = $this->getEnglish_message();
		$arr["uuid"] = $this->getId();
		$arr["criticality"] = $this->getCriticality();

		return $arr;
	}

	/**
	 * @return string
	 */
	public function getId(): ?String {
		return $this->id;
	}
	
	
	public function setId(string $id): self {
		$this->id = $id;
		return $this;
	}

	
	public function getCriticality(): ?String {
		return $this->criticality;
	}
	
	/**
	 * @param string $criticality 
	 * @return self
	 */
	public function setCriticality(string $criticality): self {
		$this->criticality = $criticality;
		
		return $this;
	}

	public function __construct(){
	}

	public function getCriticalityInteger():int {
		if($this->getCriticality() == NOTIFICATION_CRITICALITY_FATAL)
		return 5;
		if($this->getCriticality() == NOTIFICATION_CRITICALITY_HIGH)
		return 4;
		if($this->getCriticality() == NOTIFICATION_CRITICALITY_MEDIUM)
		return 3;
		if($this->getCriticality() == NOTIFICATION_CRITICALITY_LOW)
		return 2;
		if($this->getCriticality() == NOTIFICATION_CRITICALITY_NOW)
		return 1;
		return 0;
	}

	public function isMoreCriticalThan(?String $str) : bool{
		if($str == null)
			return true;
		$noti = new Notification();
		$noti->setCriticality($str);
		return $this->isMoreCritical($noti);
	}

	public function isMoreCritical(?Notification $notification) : bool{
		if($notification == null)
			return true;
		return $this->getCriticalityInteger() > $notification->getCriticalityInteger();
	}

	
}
?>