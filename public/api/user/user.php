<?php
    class User{
        private $password;
        private $id;

        private $username;

		private $first_name;

		private $last_name;

		private $contact_number;

        private $parents;

		private $children;

        private $type;

        private $pin;

		private $date_of_birth;


        
        
    private function encrypt_password($password){
		if($password == null)
			return false;
        return password_hash($password,PASSWORD_DEFAULT);
    }
    public function is_password($password): bool{
        return password_verify($password,$this->getPassword());
    }

    public function is_pin($pin) : bool{
        return password_verify($pin,$this->getPin());
    }
    
	/**
	 * @return mixed
	 */
	public function getPassword() {
		return $this->password;
	}
	
	/**
	 * @param mixed $password 
	 * @return self
	 */
	public function setPassword($password,$encrypt_password = false): self {
		if($encrypt_password)
		$this->password = $this->encrypt_password($password);
		else
		$this->password = $password;
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

	/**
	 * @return mixed
	 */
	public function getUsername() {
		return $this->username;
	}
	
	/**
	 * @param mixed $username 
	 * @return self
	 */
	public function setUsername($username): self {
		$this->username = $username;
		return $this;
    }

	/**
	 * @return mixed
	 */
	public function getType() {
		return $this->type;
	}
	
	/**
	 * @param mixed $type 
	 * @return self
	 */
	public function setType($type): self {
		$this->type = $type;
		return $this;
	}

    //User("Kristoffer","password","Email",TYPE_GUEST);
    function __construct($username,$password,$type,$encrypt_password=true){
       
            $this->setPassword($password,$encrypt_password);
        

        $this->setType($type);
        $this->setUsername($username);
        $this->setId(null);
        $this->parents = array();
		$this->children = array();
		$this->setDate_of_birth("Hejsan!");
    }

    public function add_parent(string $user_id){
        $p = array();
        foreach($this->parents as $parent){
            if($parent == $user_id){
                return;
            }
            $p[count($p)] = $parent;
        }
        $p[count($p)] = $user_id;
        $this->parents = $p;

    }

	public function add_child(string $user_id){
        $p = array();
        foreach($this->children as $child){
            if($child == $user_id){
                return;
            }
            $p[count($p)] = $child;
        }
        $p[count($p)] = $user_id;
        $this->children = $p;

    }

    
    public function delete_parent(string $user_id){
        $p = array();
        foreach($this->parents as $parent){
            if($parent == $user_id){
                continue;
            }
            $p[count($p)] = $parent;
        }
        $this->parents = $p;
    }

	public function delete_child(string $user_id){
        $p = array();
        foreach($this->children as $child){
            if($child == $user_id){
                continue;
            }
            $p[count($p)] = $child;
        }
        $this->children = $p;
    }

    public function get_parents(){
        return $this->parents;
    }

    public function is_parent($user_id) : bool{
        foreach($this->parents as $parent){
            if($parent == $user_id){
                return true;
            }
        }
        return false;
    }

	/**
	 * @return mixed
	 */
	public function getPin() {
		return $this->pin;
	}
	
	/**
	 * @param mixed $pin 
	 * @return self
	 */
	public function setPin($pin,$encrypt_pin = true): self {
		$this->pin = $this->$encrypt_pin($pin);
        if(!$encrypt_pin){
            $this->pin = $pin;
        }
		return $this;
	}

	public function to_json(){
		return array("username" => $this->getUsername(), "type" => $this->getType(), "id" => $this->getId(), "pin" => $this->getPin(),
	"first_name" => $this->getFirst_name(), "last_name" => $this->getLast_name(), "contact_number" => $this->getContact_number(),
	"date_of_birth" => $this->getDate_of_birth(),
	"children" => $this->get_children(),
	 "parents" => $this->get_parents());
	}

	/**
	 * @return mixed
	 */
	public function getFirst_name() {
		return $this->first_name;
	}
	
	/**
	 * @param mixed $first_name 
	 * @return self
	 */
	public function setFirst_name($first_name): self {
		$this->first_name = $first_name;
		return $this;
	}

	/**
	 * @return mixed
	 */
	public function getLast_name() {
		return $this->last_name;
	}
	
	/**
	 * @param mixed $last_name 
	 * @return self
	 */
	public function setLast_name($last_name): self {
		$this->last_name = $last_name;
		return $this;
	}

	/**
	 * @return mixed
	 */
	public function getContact_number() {
		return $this->contact_number;
	}
	
	/**
	 * @param mixed $contact_number 
	 * @return self
	 */
	public function setContact_number($contact_number): self {
		$this->contact_number = $contact_number;
		return $this;
	}

	/**
	 * @return mixed
	 */
	public function get_children() {
		return $this->children;
	}
	
	

	/**
	 * @return mixed
	 */
	public function getDate_of_birth() {
		return $this->date_of_birth;
	}
	
	/**
	 * @param mixed $date_of_birth 
	 * @return self
	 */
	public function setDate_of_birth($date_of_birth): self {
		$this->date_of_birth = get_date_by_str($date_of_birth,"1800-01-01");
		return $this;
	}
}
?>