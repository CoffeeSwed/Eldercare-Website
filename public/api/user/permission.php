<?php
class Permission{
    private $name;
    private $allowed;

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
	public function getAllowed() {
		return $this->allowed;
	}
	
	/**
	 * @param mixed $allowed 
	 * @return self
	 */
	public function setAllowed($allowed): self {
		$this->allowed = $allowed;
		return $this;
	}

    public function __construct(string $name, bool $allowed){
        $this->setAllowed($allowed);
        $this->setName($name);
    }
}
?>