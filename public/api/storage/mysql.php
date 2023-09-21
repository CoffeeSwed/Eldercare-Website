<?php
include_once("storage.php");
include_once("./essentials.php");
define("PARENT_DATABASE_TYPE","Parent_of");

class Mysql implements Storage{

    //How many times we have locked, if we unlock and lock_count == 0, we unlock all!
    private $lock_count = 0;
    private array $user_cache;
    private array $permission_cache;

    
    private function lock(){
        $this->setLock_count($this->getLock_count() + 1);
        if($this->getLock_count() == 1){
            $exec = $this->getConn()->prepare("LOCK TABLES users WRITE, sessions WRITE, relations WRITE, meal_plan_entry WRITE");
            $exec->execute();
            $exec->close();
        }
        $this->cache_flush();

    }

    private function unlock(){
        $this->setLock_count($this->getLock_count() - 1);
        if($this->getLock_count() == 0){
            $exec = $this->getConn()->prepare("UNLOCK TABLES");
            $exec->execute();
            $exec->close();
        }
        if($this->getLock_count() < 0){
            $this->setLock_count(0);
        }
        $this->cache_flush();

    }

    private function send_query($str){
        //echo("Query!");
            return $this->getConn()->query($str);
       
    }




    private $conn;
    
    public function open(){
        $this->setConn(null);

    }

    public function close(){
        if($this->getConn(false) != null){
            $this->getConn()->close();
            $this->setConn(null);
        }
    }

    public function __construct(){
        $this->setConn(null);
        $this->cache_flush();
    }

    private function fetch_table($table_name,$to_return,$where,$end_tag = ""){
        $response = array();
        $query = "SELECT ";
        for($i = 0; $i < count($to_return); $i++){
            if($i == 0){
                $query=$query.$to_return[$i];
            }else{
                $query = $query.", ".$to_return[$i];
            }
        }
        $query = $query." FROM ".$table_name;
        for($i = 0; $i < count(array_keys($where)); $i++){
            if($i == 0){
                $query=$query." WHERE ".array_keys($where)[$i]."=".$this->encodetostr($where[array_keys($where)[$i]]);
            }else{
                $query=$query." AND ".array_keys($where)[$i]."=".$this->encodetostr($where[array_keys($where)[$i]]);

            }
        }
        if($end_tag != ""){
            $query = $query." ".$end_tag;
        }
        

        $res = $this->send_query($query);
        if($res->num_rows > 0){
            while($row = $res->fetch_assoc()){
                foreach(array_keys($row) as $key){
                    $row[$key] = $this->decodetostr($row[$key]);
                }
                array_push($response,$row);
            }
        }

        return $response;
    }

    private function insert_table($table_name,$values){
        $sql = "INSERT INTO ".$table_name." (";
        for($i = 0; $i < count(array_keys($values));$i++){
            if($i == 0){
                $sql=$sql.array_keys($values)[$i];

            }else{
                $sql=$sql.",".array_keys($values)[$i];
            }
        }
        $sql = $sql.") VALUES(";

        for($i = 0; $i < count(array_keys($values));$i++){
            if($i == 0){
                $sql=$sql.$this->encodetostr( $values[array_keys($values)[$i]] );

            }else{
                $sql=$sql.",".$this->encodetostr( $values[array_keys($values)[$i]] );
            }
        }

        $sql = $sql.")";
        $this->send_query($sql);

        
    }

    private function save_table($table_name,$values,$where){
        $sql = "UPDATE ".$table_name." SET";
        for($i = 0; $i < count(array_keys($values));$i++){
            if($i == 0){
                $sql=$sql." ".array_keys($values)[$i]."=".$this->encodetostr($values[array_keys($values)[$i]]);

            }else{
                $sql=$sql.", ".array_keys($values)[$i]."=".$this->encodetostr($values[array_keys($values)[$i]]);
            }
        }
        for($i = 0; $i < count(array_keys($where)); $i++){
            if($i == 0){
                $sql=$sql." WHERE ".array_keys($where)[$i]."=".$this->encodetostr($where[array_keys($where)[$i]]);
            }else{
                $sql=$sql." AND ".array_keys($where)[$i]."=".$this->encodetostr($where[array_keys($where)[$i]]);

            }
        }
        $this->send_query($sql);
    }

    /**
     * Summary of save_user
     * @param User $user
     * @return void
     * If id is missing, it will give the user an id! If not given an ID, then its because a user already exist with the username!
     */

     private function create_save_insert_array(User $user) : array{
        return array("username" => $user->getUsername(), "password" => $user->getPassword(), "type" => $user->getType(),
        "first_name" => $user->getFirst_name(), "last_name" => $user->getLast_name(), "contact_number" => $user->getContact_number(),
        "date_of_birth" => $user->getDate_of_birth()
     );
     }

    public function save_user(User& $user){
       
        $this->lock();
        if($user->getId() != null && $this->load_user($user->getId()) != null){
            

            $this->save_table("users",$this->create_save_insert_array($user),array("id" => $user->getId()));
            

            $this->delete_all_relations($user);
            foreach($user->get_parents() as $parent){
                if($this->load_user($parent) != null){
                    $this->insert_table("relations",array("person_1" => $parent, "person_2" => $user->getId(), "type" => PARENT_DATABASE_TYPE));
                }
            }
            foreach($user->get_children() as $child){
                if($this->load_user($child) != null){
                    $this->insert_table("relations",array("person_1" => $user->getId(), "person_2" => $child, "type" => PARENT_DATABASE_TYPE));
                }
            }


        }else{
            if($user->getId() == null){
                $this->insert_user($user);
            }
        }
        $this->unlock();
    }




    /**
     * Summary of save_session
     * @param Session $session
     * @return void
     * Will set the id of a session if its not already given an id(it will insert it)
     */
    public function save_session(Session $session) {
        if($session->getId() == null){
            $this->insert_session($session);
        }
    }

    //Deletes relations we have been set as the creator, hence the one who needs to take care of something! 
    private function delete_created_relations(User $user){
        $this->lock();
        

        $sql = "DELETE FROM relations WHERE person_2=".$this->encodetostr($user->getId());

        $this->send_query($sql);

        $this->unlock();
    }

    private function delete_all_relations(User $user){
        $this->lock();
        $sql = "DELETE FROM relations WHERE person_1=".$this->encodetostr($user->getId());

        $this->send_query($sql);

        $sql = "DELETE FROM relations WHERE person_2=".$this->encodetostr($user->getId());

        $this->send_query($sql);

        $this->unlock();
    }

    private function delete_all_sessions(User $user){
        $this->lock();

        $sql = "DELETE FROM sessions WHERE owner=".$this->encodetostr($user->getId());

        $this->send_query($sql);

        $this->unlock();
    }

    

    public function delete_user(?User $user){
        if($user != null){
            $sql = "DELETE FROM users WHERE id=".$this->encodetostr($user->getId());
            $this->lock();

            $this->send_query($sql);
            
            $this->delete_all_relations($user);

            $this->delete_all_sessions($user);    

            $this->unlock();
        }
    }

    private function load_parents_and_children(User &$user){
        $sql = "SELECT * FROM relations WHERE person_2=".$this->encodetostr($user->getId())." AND type='".PARENT_DATABASE_TYPE."'";
        foreach($this->fetch_table("relations",array("person_1","person_2","type"), array("person_2" => $user->getId(), "type" => PARENT_DATABASE_TYPE)) as $row){
            $user->add_parent(($row["person_1"]));
        }
        foreach($this->fetch_table("relations",array("person_1","person_2","type"), array("person_1" => $user->getId(), "type" => PARENT_DATABASE_TYPE)) as $row){
            $user->add_child($row["person_2"]);
        }
                
            

    }
    public function load_user($id=null,$username=null) : ?User{
        $res = null;
        if($id != null){

            if(isset($this->getUser_cache()["id"][$id])){
                return $this->getUser_cache()["id"][$id];
            }

            $res = $this->fetch_table("users",array("*"),array("id" => $id));

        }
        if($username != null && $res == null){
            if(isset($this->getUser_cache()["username"][$username])){
                return $this->getUser_cache()["username"][$username];
            }
            $res = $this->fetch_table("users",array("*"),array("username" => $username));
        }
        
        

        if($res != null){
            $row = $res[0];
            $user = new User($row["username"],$row["password"],$row["type"],false);
            $user->setLast_name($row["last_name"]);
            $user->setFirst_name($row["first_name"]);
            $user->setContact_number($row["contact_number"]);
            $user->setId($row["id"]);
            $user->setDate_of_birth($row["date_of_birth"]);
            $this->load_parents_and_children($user);
            
            $this->getUser_cache()["id"][$user->getId()] = $user;
            $this->getUser_cache()["username"][$user->getUsername()] = $user;
            
            //echo("Loaded : ".$user->getUsername() . " children : ");
            //print_r($user->get_children());
            return $user;
        }

        
       
        return null;
    }

    public function exist_user(User $user) : bool{
        if($this->load_user($user->getId(),$user->getUsername()) != null){
            return true;
        }
        return false;
    }

    private function insert_user(User& $user){
        if($user->getId() == null){
            $this->lock();
            if($this->exist_user($user)){

                $this->unlock();
                return USER_ALREADY_EXIST;
                
            }
            $this->insert_table("users",$this->create_save_insert_array($user));
           
            $user->setId($this->getConn()->insert_id);

            
            $this->unlock();
            
            
        }
        return USER_ID_ASSIGNED;
    }

	/**
	 * @return mixed
	 */
	private function getConn($create_if_null = true) : ?mysqli {
        if($this->conn == null && $create_if_null){
            $this->setConn(new mysqli("p:".get_cfg_val("db_ip"),get_cfg_val("db_user"),get_cfg_val("db_password"),get_cfg_val("db_name")));
        }
		return $this->conn;
	}
	
	/**
	 * @param mixed $conn 
	 * @return self
	 */
	private function setConn($conn): self {
		$this->conn = $conn;
		return $this;
	}

    private function encodetostr($val){
        if($val == NULL){
			return "NULL";
		}
		return "'".urlencode($val)."'";
    }

	
	function decodetostr($str){
		if($str == null){
			return null;
		}
		return urldecode($str);
	}

	/**
	 * @return mixed
	 */
	private function getLock_count() {
		return $this->lock_count;
	}
	
	/**
	 * @param mixed $lock_count 
	 * @return self
	 */
	private function setLock_count($lock_count): self {
		$this->lock_count = $lock_count;
		return $this;
	}

    public function insert_session(Session $session){
        $this->lock();
        $sql = "INSERT INTO sessions(session,pass,owner) VALUES(UuidToBin(UUID()), ".$this->encodetostr($session->getKey()).", ".$this->encodetostr($session->getOwner_id()).")";
        $this->send_query($sql);

        

        $sql = "SELECT UuidFromBin(session),pass FROM sessions WHERE id='".$this->getConn()->insert_id."'";
        $res = $this->send_query($sql);
				if($res->num_rows == 1){
					
					$row = $res->fetch_assoc();
					
					$session->setId( $row["UuidFromBin(session)"]);
				}

        $this->unlock();

    }

    public function get_user_from_session(Session $session) : ?User{
        if(isset($this->getUser_cache()["session"])){
            return $this->getUser_cache()["session"];
        }

        $id = null;
        $sql = "SELECT owner FROM sessions WHERE UuidFromBin(session)=".$this->encodetostr($session->getId())." AND pass=".$this->encodetostr($session->getKey())."";
        $res = $this->send_query($sql);
			if($res->num_rows > 0){
				$row = $res->fetch_assoc();
				$id = $this->decodetostr($row["owner"]);	
			}

        $user = $this->load_user($id);
        $this->getUser_cache()["session"] = $user;
        return $user;
    }

    public function delete_session(Session $session){
        $this->lock();
        $sql = "DELETE FROM sessions WHERE UuidFromBin(session)=".$this->encodetostr($session->getId())." AND pass=".$this->encodetostr($session->getKey())."";
        $this->send_query($sql);
        $this->unlock();
    }

    ///
    /**
     * Summary of get_sessions_for_user
     * @param User $user
     * @return array where first entry is the newest and last is the oldest! 
     */
    public function get_sessions_for_user(User $user){
        $sessions = array();
        $vals = $this->fetch_table("sessions",array("UuidFromBin(session)", "pass", "owner", "created"),array("owner" => $user->getId()), "ORDER BY created DESC");
        foreach($vals as $row){
               $session = new Session($row["owner"]);
               $session->setId($row["UuidFromBin(session)"]);
               $session->setKey($row["pass"]);
               array_push($sessions,$session);
        }   
        

        return $sessions;
    }


    public function get_permission($name) : Permission{
        if(isset($this->getPermission_cache()[$name])){
            return $this->getPermission_cache()[$name];
        }

        $vals = $this->fetch_table("permissions",array("*"),array("name" => $name));
        if(count($vals) == 0){
            $permission = new Permission($name,false);
            $this->save_permission($permission);

            $this->getPermission_cache()[$name] = $permission;
            return $permission;
        }else{
            $permission = new Permission($name,false);
            $permission->setAllowed($vals[0]["allowed"] == "1");

            $this->getPermission_cache()[$name] = $permission;
            
            return $permission;
        }
    }

    public function save_permission(Permission $permission){

        
        $vals = $this->fetch_table("permissions",array("*"),array("name" => $permission->getName()));
        if(count($vals) == 0){
            $this->insert_table("permissions", array("name" => $permission->getName(), "allowed" => $permission->getAllowed() ? "1" : "0"));

        }else{
            $this->save_table("permissions",array("allowed" => $permission->getAllowed() ? "1" : "0" ) ,array("name" => $permission->getName()));
        }
        $this->getPermission_cache()[$permission->getName()] = $permission;


    }

	/**
	 * @return array
	 */
	private function& getUser_cache(): array {
		return $this->user_cache;
	}

    private function& getPermission_cache(): array {
		return $this->permission_cache;
	}
	
	/**
	 * @param array $user_cache 
	 * @return self
	 */
	private function refreshUserCache(): self {
		$this->user_cache = array();
        $this->user_cache["username"] = array();
        $this->user_cache["id"] = array();

		return $this;
	}

    private function refreshPermissionCache(): self {
		$this->permission_cache = array();

		return $this;
	}

    public function cache_flush(){
        $this->refreshPermissionCache();
        $this->refreshUserCache();
    }

    public function load_dinners() : array{
        $arr = array();
        
        $res = $this->fetch_table("dinner_times",array("id", "swedish_name", "english_name","at"),array("*"));

        foreach($res as $row){
            $dinner = new Dinner_Time($row["swedish_name"],$row["english_name"],$row["at"]);
            $dinner->setId($row["id"]);
            array_push($arr,$dinner);
        }

        return $arr;
    }

    public function load_meal_types() : array{
        $arr = array();
        $res = $this->fetch_table("meal_types",array("id", "swedish_name", "english_name","available_at"),array("*"));
        foreach($res as $row){
            $meal = new Meal_Type($row["swedish_name"],$row["english_name"]);
            $meal->setId($row["id"]);
            $meal->setAvailable_at(json_decode($row["available_at"]));
            array_push($arr,$meal);
        }
        return $arr;
    }
    
    private function create_insert_array_for_meal_plan_entry(Meal_Plan_Entry $meal_plan_entry){
        return array("has_eaten" => ($meal_plan_entry->getHas_eaten() ? "1" : "0"), "owner" => $meal_plan_entry->getOwnerID(), "at" => $meal_plan_entry->getDimmer_time(), "date" => $meal_plan_entry->getDay(), "meal_types" => json_encode($meal_plan_entry->getMeal_types()));
    }

    public function save_meal_plan_entry(Meal_Plan_Entry& $meal_plan_entry){
        $this->lock();  
        
        if($meal_plan_entry->getId() == null){
            $p = $this->load_meal_plan_entry($meal_plan_entry->getOwnerID(),$meal_plan_entry->getDimmer_time(),$meal_plan_entry->getDay());
            if($p != null){
                $meal_plan_entry->setId($p->getId());
            }
        }

        if($meal_plan_entry->getId() == null){


            $this->insert_table("meal_plan_entry",$this->create_insert_array_for_meal_plan_entry($meal_plan_entry));
            $meal_plan_entry->setId($this->getConn()->insert_id);
        }else{
            $this->save_table("meal_plan_entry",$this->create_insert_array_for_meal_plan_entry($meal_plan_entry), array("id" => $meal_plan_entry->getId()));
            
        }

        $this->unlock();
    }

    public function load_meal_plan_entry($owner_id, $dinner_time_id,$date) : ?Meal_Plan_Entry{

        $meal_plan = null;
        $res = $this->fetch_table("meal_plan_entry",array("*"),array("owner" => $owner_id, "at" => $dinner_time_id, "date" => $date));
        if(count($res) != 0){
            $row = $res[0];
            $meal_plan = new Meal_Plan_Entry($row["at"],json_decode($row["meal_types"]),$row["owner"],$row["date"]);
            $meal_plan->setId($row["id"]);
            $meal_plan->setHas_eaten(intval($row["has_eaten"]));
        }
        return $meal_plan;
    }
}

?>