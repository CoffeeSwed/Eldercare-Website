<?php
    include_once("essentials.php");
    include_once("response.php");
    include_once("unit_test.php");
    include_once("./user/user.php");
    include_once("./storage/mysql.php");
    include_once("./user/session.php");
    include_once(__DIR__."/../meals/dinners.php");


    class API{
        private Session $session;

        private Storage $storage;

        private Dinners $dinner;
    
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
        $this->setDinnersInstance(new Dinners($storage));

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
        $this->getStorage()->cache_flush();
        if($user->getUsername() == null || $user->getUserName() == ""){
            return push_response(STATUS_ERROR,MISSING_INPUT);
        }
        if($user->getPassword() == null || $user->getPassword() == ""){
            return push_response(STATUS_ERROR,MISSING_INPUT);
        }
        if($user->getType() == null || $user->getType() == ""){
            return push_response(STATUS_ERROR,MISSING_INPUT);
        }
        $creator = $this->getStorage()->get_user_from_session($this->getSession());
        if(!$this->getStorage()->exist_user($user)){
            if($this->has_permission("create",$user)){
                

                    if($this->getStorage()->save_user($user)){
                        
                        $user = $this->getStorage()->load_user($user->getId(),$user->getUsername());

                        $user->add_parent($creator->getId());

                        $this->getStorage()->save_user($user);

                        $user = $this->getStorage()->load_user($user->getId(),$user->getUsername());


                        return push_response(STATUS_OK,array("User" => $user->to_json()));
                    }else{
                        return push_response(STATUS_ERROR,UNKNOWN_ERROR);
                    }

                
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
            if($this->has_permission("delete",$user)){
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
        $this->getStorage()->cache_flush();


        $creator = $this->getStorage()->get_user_from_session($this->getSession());
        $user = $this->getStorage()->load_user($user->getId(),$user->getUsername());
		$user2 = $this->getStorage()->load_user($user2->getId(),$user2->getUsername());
        if($user != null && $user2 != null && $creator != null){
                if(!$this->has_permission("add_parent_to",$user))
                     return push_response(STATUS_ERROR,PERMISSION_DENIED);
            
                 $user->add_parent($user2->getId());
                 $this->getStorage()->save_user($user);
                 return push_response(STATUS_OK,PARENT_UPDATED);

        }else{
            return push_response(STATUS_ERROR,USER_NOT_FOUND);

        }
    }

    public function delete_parent(User $user,User $user2){
        $this->getStorage()->cache_flush();

        $creator = $this->getStorage()->get_user_from_session($this->getSession());
        $user = $this->getStorage()->load_user($user->getId(),$user->getUsername());
		$user2 = $this->getStorage()->load_user($user2->getId(),$user2->getUsername());
        if($user != null && $user2 != null && $creator != null){

            
            if($this->has_permission("delete_parent_to",$user))
            return push_response(STATUS_ERROR,PERMISSION_DENIED);

            
            $user->delete_parent($user2->getId());
            $this->getStorage()->save_user($user);

            return push_response(STATUS_OK,PARENT_UPDATED);

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
            return push_response(STATUS_OK,array("User" => $user->to_json()));
        }

        return push_response(STATUS_ERROR,USER_NOT_FOUND);
    }

    public function browse_user_info(User $user){
        $user = $this->getStorage()->load_user($user->getId(),$user->getUsername());
       
        $requester = $this->getStorage()->get_user_from_session($this->getSession());
        
        if($requester != null && $user != null){
            if($this->has_permission("browse_info_of",$user)){
                $p = $user->to_json();
                $p["handled"] = $this->is_handled(($user)) ? "True" : False;
                return push_response(STATUS_OK,array("User" => $p));
            }else{
                return push_response(STATUS_ERROR,PERMISSION_DENIED);
            }
        }
        return push_response(STATUS_ERROR,USER_NOT_FOUND);
    }

    private function is_handled(User $user, array $checked = array()) : bool{
        $requester = $this->getStorage()->get_user_from_session($this->getSession());
        $user = $this->getStorage()->load_user($user->getId(),$user->getUsername());
        if($requester->getId() == $user->getId()){
            return false;
        }
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

    private function has_permission(string $name, ?User $user){
        $creator = $this->getStorage()->get_user_from_session($this->getSession());
        $creator_type = $creator == null ? "null" : $creator->getType();

        if($this->getStorage()->get_permission("allow_".$creator_type."_".$name."_all")->getAllowed()){
                
            return true;
        }

        if($this->getStorage()->get_permission("allow_".$creator_type."_".$name."_self")->getAllowed()){
            if($user->getId() == $creator->getId()){
                return true;
            }
        }
        if($user != null){

            if($this->getStorage()->get_permission("allow_".$creator_type."_".$name."_".$user->getType())->getAllowed()){
                
                return true;
            }

        

            if($this->getStorage()->get_permission("allow_".$creator_type."_".$name."_handled_all")->getAllowed()){
                if($this->is_handled($creator)){
                    return true;
                }
            }

            if($this->getStorage()->get_permission("allow_".$creator_type."_".$name."_handled_".$user->getType())->getAllowed()){
                if($this->is_handled($creator)){
                    return true;
                }
            }
        }

        return false;
    }

    public function get_meal_plan(User $user, ?string $date){
        if($date == "")
            $date = "now";
        $user = $this->getStorage()->load_user($user->getId(),$user->getUsername());
        if($user == null)
            return push_response(STATUS_ERROR,USER_NOT_FOUND);
        
        if(!$this->has_permission("get_meal_plan_of",$user))
            return push_response(STATUS_ERROR,PERMISSION_DENIED);

        $meal_plan = $this->getDinnersInstance()->loadMealPlanEntriesForUser($user,$date);
        if(count($meal_plan) != count($this->getDinnersInstance()->getDinners())){
            
            //strtotime returns time in seconds! 
            if(strtotime(get_date_today()) <= strtotime($date) && (strtotime($date) - strtotime(get_date_today()) <= get_cfg_val("max_pre_generating_days")*3600*24)){
                $this->getDinnersInstance()->generateMealPlanEntriesForTheDay($user,$date);
                $meal_plan = $this->getDinnersInstance()->loadMealPlanEntriesForUser($user,$date);
            }else{
                return push_response(STATUS_ERROR,NO_DATA_FOUND_FOR_DATE . "'".$date."'");
            }
        }
        $arr = array();
        foreach($meal_plan as $meal){
            array_push($arr,$meal->to_array());
        }
        
            return push_response(STATUS_OK,array("Meal_plan" => $arr));
        
        
    }

    public function get_matching_users(User $user){
        if($this->has_permission("list_matching_users",$user)){
            return push_response(STATUS_OK,$this->getStorage()->get_matching_users($user));
        }else{
            return push_response(STATUS_ERROR,PERMISSION_DENIED);
        }
    }

    public function get_meal_database(){
        return push_response(STATUS_OK,array("Meal_types" => $this->getDinnersInstance()->getMeal_types_to_array()));
    }

    public function get_dinner_time_database(){
        return push_response(STATUS_OK,array("Dinner_times" => $this->getDinnersInstance()->getDinners_to_array()));
    }

	/**
	 * @return Dinners
	 */
	public function getDinnersInstance(): Dinners {
		return $this->dinner;
	}
	
	/**
	 * @param Dinners $dinner 
	 * @return self
	 */
	public function setDinnersInstance(Dinners $dinner): self {
		$this->dinner = $dinner;
		return $this;
	}

    public function setStatusOfMealEntry($eaten,$id){
        $meal_plan_entry = $this->getDinnersInstance()->loadMealPlanEntry(null,null,null,$id);
        $user = $this->getStorage()->load_user($meal_plan_entry->getOwnerID());
        if($this->has_permission("edit_meal_state_of",$user)){
            $meal_plan_entry->setHas_eaten($eaten == "True" || $eaten == "true");
            $this->getDinnersInstance()->saveMealPlanEntry($meal_plan_entry);
            return push_response(STATUS_OK,array("entry" => $meal_plan_entry->to_array()) );
        }else{
            return push_response(STATUS_ERROR,PERMISSION_DENIED);
        }
    }

    public function setNote($dinner_time_id,User $owner,$note){
            $owner = $this->getStorage()->load_user($owner->GetID(),$owner->getUsername());
            if($owner != null){
                $dinner_time = $this->getDinnersInstance()->get_dinner_time_by_id($dinner_time_id);
                if($dinner_time != null){
                    if($this->has_permission("set_note",$owner)){
                        $this->getDinnersInstance()->setNote($dinner_time,$owner,$note);
                        return push_response(STATUS_OK,array("note" => ($note == null ? "" : $note)));
                    }
                    return push_response(STATUS_ERROR,PERMISSION_DENIED);
                }
                return push_response(STATUS_ERROR,NO_DINNER_TIME_FOUND);
            }
            return push_response(STATUS_ERROR,USER_NOT_FOUND);
    }

    public function setSetting($dinner_time_id,User $owner,$setting,$value){
        $owner = $this->getStorage()->load_user($owner->GetID(),$owner->getUsername());

        if($owner != null){
            $dinner_time = $this->getDinnersInstance()->get_dinner_time_by_id($dinner_time_id);
            if($dinner_time != null){
                if($this->has_permission("set_setting",$owner)){
                    $this->getDinnersInstance()->setSetting($dinner_time,$owner,$setting,$value);
                    return push_response(STATUS_OK,array("setting" => $value));
                }
                return push_response(STATUS_ERROR,PERMISSION_DENIED);
            }
            return push_response(STATUS_ERROR,NO_DINNER_TIME_FOUND);
        }
        return push_response(STATUS_ERROR,USER_NOT_FOUND);
    }

}
?>