<?php
include_once("./essentials.php");
    class Session{
        private $id;
        private $key;

        private $owner_id;
    
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
	public function getKey() {
		return $this->key;
	}
	
	/**
	 * @param mixed $key 
	 * @return self
	 */
	public function setKey($key): self {
		$this->key = $key;
		return $this;
	}

	/**
	 * @return mixed
	 */
	public function getOwner_id() {
		return $this->owner_id;
	}
	
	/**
	 * @param mixed $owner_id 
	 * @return self
	 */
	public function setOwner_id($owner_id): self {
		$this->owner_id = $owner_id;
		return $this;
	}

    public function __construct($owner_id){
        $this->setId(null);
        $this->setOwner_id($owner_id);
        $this->setKey(generateRandomString(16));
    }


}
?>