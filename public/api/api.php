<?php
    include_once("essentials.php");
    include_once("response.php");
    include_once("unit_test.php");
    include_once("./user/user.php");
    include_once("./user/mysql.php");
    include_once("./user/session.php");


    class API{
        private Session $session;

        private Storage $storage;
    
	/**
	 * @return Session
	 */
	public function getSession(): Session {
		return $this->session;
	}
	
	/**
	 * @param Session $session 
	 * @return self
	 */
	public function setSession(Session $session): self {
		$this->session = $session;
		return $this;
	}

    public function __construct(Storage $storage, Session $session){
        $this->setStorage($storage);
        $this->setSession($session);
    }

	/**
	 * @return Storage
	 */
	public function getStorage(): Storage {
		return $this->storage;
	}
	
	/**
	 * @param Storage $storage 
	 * @return self
	 */
	public function setStorage(Storage $storage): self {
		$this->storage = $storage;
		return $this;
	}


    public function create_user(User $user){
        $creator = $this->getStorage()->get_user_from_session($this->getSession());
        if(!$this->getStorage()->exist_user($user)){
            if($this->getStorage()->get_permission("allow_type_".($creator != null ? $creator->getType() : "Unsigned")."_create_".$user->getType())->getAllowed()){
                $this->getStorage()->save_user($user);
                return push_response(STATUS_OK,CREATED_USER);
            }else{
                return push_response(STATUS_ERROR,PERMISSION_DENIED);
            }
        }else{
            return push_response(STATUS_ERROR,USER_ALREADY_EXIST);

        }
    }

    public function delete_user(User $user){
        $creator = $this->getStorage()->get_user_from_session($this->getSession());
        $user = $this->getStorage()->load_user($user->getId(),$user->getUsername());
        if($user != null){
            if($this->getStorage()->get_permission("allow_type_".$creator->getType()."_delete_".$user->getType())->getAllowed()){
                $this->getStorage()->delete_user($user);
                return push_response(STATUS_OK,DELETED_USER);
            }else{
                return push_response(STATUS_ERROR,PERMISSION_DENIED);
            }
        }else{
            return push_response(STATUS_ERROR,USER_NOT_FOUND);

        }
    }
    
    public function add_parent(User $user,User $user2){
        $creator = $this->getStorage()->get_user_from_session($this->getSession());
        $user = $this->getStorage()->load_user($user->getId(),$user->getUsername());
		$user2 = $this->getStorage()->load_user($user2->getId(),$user2->getUsername());
        if($user != null && $user2 != null && $creator != null){
            if($this->getStorage()->get_permission("allow_type_".$creator->getType()."_add_parent_to_".$user->getType())->getAllowed()){
                $user->add_parent($user2->getId());
				$this->getStorage()->save_user($user);
				return push_response(STATUS_OK,PARENT_UPDATED);
            }else{
                return push_response(STATUS_ERROR,PERMISSION_DENIED);
            }
        }else{
            return push_response(STATUS_ERROR,USER_NOT_FOUND);

        }
    }

    public function delete_parent(User $user,User $user2){
        $creator = $this->getStorage()->get_user_from_session($this->getSession());
        $user = $this->getStorage()->load_user($user->getId(),$user->getUsername());
		$user2 = $this->getStorage()->load_user($user2->getId(),$user2->getUsername());
        if($user != null && $user2 != null && $creator != null){
            if($this->getStorage()->get_permission("allow_type_".$creator->getType()."_delete_parent_to_".$user->getType())->getAllowed()){
                $user->delete_parent($user2->getId());
				$this->getStorage()->save_user($user);
				return push_response(STATUS_OK,PARENT_UPDATED);
            }

            return push_response(STATUS_ERROR,PERMISSION_DENIED);
        }else{
            return push_response(STATUS_ERROR,USER_NOT_FOUND);

        }
    }

    public function create_session(User $user){
        $user2 = $this->getStorage()->load_user(null,$user->getUsername());
		if($user2 != null){
			if($user2->is_password($user->getPassword())){
				$session = new Session($user2->getId());
				$this->getStorage()->save_session($session);
                
                $sessions = $this->getStorage()->get_sessions_for_user($user2);
                for($i = 0; $i < count($sessions);$i++){
                    if($i >= get_cfg_val("max_sessions")){
                        $this->getStorage()->delete_session($sessions[$i]);
                    }
                }

				return push_response(STATUS_OK,array("session" => $session->getId(), "key" => $session->getKey()));
			}
			return push_response(STATUS_ERROR,PERMISSION_DENIED);
		}
		return push_response(STATUS_ERROR,USER_NOT_FOUND);
    }

    public function get_session_user_info(){
        $user = $this->getStorage()->get_user_from_session($this->getSession());
        if($user != null){
            return push_response(STATUS_OK,$user->to_json());
        }

        return push_response(STATUS_ERROR,USER_NOT_FOUND);
    }

    public function browse_user_info(User $user){
        $user = $this->getStorage()->load_user($user->getId(),$user->getUsername());
       
        $requester = $this->getStorage()->get_user_from_session($this->getSession());
        
        if($requester != null && $user != null){
            if($this->getStorage()->get_permission("allow_type_".$requester->getType()."_get_info_of_".$user->getType())->getAllowed()){
                return push_response(STATUS_OK,$user->to_json());
            }else{
                return push_response(STATUS_ERROR,PERMISSION_DENIED);
            }
        }
        return push_response(STATUS_ERROR,USER_NOT_FOUND);
    }

    private function is_handled(User $user, array $checked = array()) : bool{
        $requester = $this->getStorage()->get_user_from_session($this->getSession());
        $user = $this->getStorage()->load_user($user->getId(),$user->getUsername());

        if($requester != null && $user != null){
            foreach($checked as $checked_id){
                if($checked_id == $user->getId()){
                    return false;
                }
            }
            array_push($checked,$user->getId());
            foreach($user->get_parents() as $parent_id){
                if($parent_id == $requester->getId()){
                    return true;
                }
                if($this->is_handled($this->getStorage()->load_user($parent_id),$checked)){
                    return true;
                }
            }
        }

        return false;
    }
}
?>