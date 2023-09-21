<?php
	include_once("essentials.php");
	include_once("response.php");
	include_once("./user/user.php");
	include_once("./storage/mysql.php");
	include_once("./api/api.php");
	include_once("./unit_tests/tests/mysql.php");
	include_once("./unit_tests/tests/meals.php");


	// Start the session
	session_start();
	
	


	
	
	function do_unit_test(Session $session=null){
		//Test Create_User!
		
			
		
		if(get_cfg_val("debug_mode")){
		

			$results = array();
			


			$mysql = new Unit_Test_Mysql();
			$results[$mysql->getName()] = $mysql->to_array();
			$meals = new Unit_Test_Meals();
			$results[$meals->getName()] = $meals->to_array();


			
			return push_response(STATUS_OK,$results);

		}
		else{
			return push_response(STATUS_ERROR,"PERMISSION DENIED!");
		}
	}

	function request_create_user(Session $session=null,User $to_create){
		$database = new Mysql();
		$user = $database->get_user_from_session($session);
		
		if(!$database->exist_user($to_create)){
			if(($user->getType() == TYPE_CAREGIVER && $to_create->getType() != TYPE_ADMIN) || $user->getType() == TYPE_ADMIN){
				$database->save_user($to_create);
				return push_response(STATUS_OK,CREATED_USER);
			}

			return push_response(STATUS_ERROR, PERMISSION_DENIED);
		}
		
		return push_response(STATUS_ERROR,USER_ALREADY_EXIST);
	}

	function request_create_session(User $user){
		$database = new Mysql();
		$user2 = $database->load_user(null,$user->getUsername());
		if($user2 != null){
			if($user2->is_password($user->getPassword())){
				$session = new Session($user2->getId());
				$database->save_session($session);


				return push_response(STATUS_OK,array("session" => $session->getId(), "key" => $session->getKey()));
			}
			return push_response(STATUS_ERROR,PERMISSION_DENIED);
		}
		return push_response(STATUS_ERROR,USER_NOT_FOUND);
	}
	
	function request_get_session_user_info($session = null){
		$database = new Mysql();
		if($session != null){
			$user = $database->get_user_from_session($session);
			if($user != null){

				return push_response(STATUS_OK,$user->to_json());
			}
		}
		push_response(STATUS_ERROR,USER_NOT_FOUND);
	}

	function request_add_parent(Session $session,User $user,User $user2){
		$database = new Mysql();
		$creator = $database->get_user_from_session($session);
		$user = $database->load_user($user->getId(),$user->getUsername());
		$user2 = $database->load_user($user2->getId(),$user2->getUsername());
		if($creator != null && $user != null && $user2 != null){
			if($creator->getType() == TYPE_ADMIN || $creator->getType() == TYPE_CAREGIVER){
				$user->add_parent($user2->getId());
				$database->save_user($user);
				return push_response(STATUS_OK,PARENT_UPDATED);
			}
			push_response(STATUS_ERROR,PERMISSION_DENIED);
		}
		push_response(STATUS_ERROR,USER_NOT_FOUND);
	}

	function request_remove_parent(Session $session,User $user,User $user2){
		$database = new Mysql();
		$creator = $database->get_user_from_session($session);
		$user = $database->load_user($user->getId(),$user->getUsername());
		$user2 = $database->load_user($user2->getId(),$user2->getUsername());
		if($creator != null && $user != null && $user2 != null){
			if($creator->getType() == TYPE_ADMIN || $creator->getType() == TYPE_CAREGIVER){
				$user->delete_parent($user2->getId());
				$database->save_user($user);
				return push_response(STATUS_OK,PARENT_UPDATED);
			}
			push_response(STATUS_ERROR,PERMISSION_DENIED);
		}
		push_response(STATUS_ERROR,USER_NOT_FOUND);
	}
	
	function request_get_user_info(Session $session,User $user){
		$database = new Mysql();
		$creator = $database->get_user_from_session($session);
		$user = $database->load_user($user->getId(),$user->getUsername());
		if($creator != null && $user != null){
			if($creator->getType() == TYPE_ADMIN || $creator->getType() == TYPE_CAREGIVER){
				
				return push_response(STATUS_OK,$user->to_json());
			}
			push_response(STATUS_ERROR,PERMISSION_DENIED);
		}
		push_response(STATUS_ERROR,USER_NOT_FOUND);
	}

	function request_delete_user(Session $session,User $user){
		$database = new Mysql();
		$creator = $database->get_user_from_session($session);
		$user = $database->load_user($user->getId(),$user->getUsername());
		if($creator != null && $user != null){
			if($creator->getType() == TYPE_ADMIN || $creator->getType() == TYPE_CAREGIVER){
				$database->delete_user($user);
				return push_response(STATUS_OK,DELETED_USER);
			}
			push_response(STATUS_ERROR,PERMISSION_DENIED);
		}
		push_response(STATUS_ERROR,USER_NOT_FOUND);
	}
	
	function answer_requests(){
		
		

		$session = new Session(null);
		$session->setKey(get_argument("key"));
		$session->setId(get_argument("session"));
		
		$user = new User(get_argument("username"),get_argument("password"),((get_argument("type") == "null" ||get_argument("type") == null) ? null : get_argument("type")),true);
		$user->setFirst_name(get_argument("first_name"));
		$user->setLast_name(get_argument("last_name"));
		$user->setContact_number(get_argument("contact_number"));
		$user->setId(get_argument("id") == "" ? null : get_argument("id"));
		$user->setDate_of_birth(get_argument(("date_of_birth")));
		if(!isset($_SESSION["api"])){
			$api = new API(new Mysql(),$session);
			$_SESSION["api"] = $api;
		}else{
			$api = $_SESSION["api"];
			$api->setSession($session);
			$api->getStorage()->open();
		}
		


		if(get_argument(ACTION) == UNIT_TEST){
			echo(do_unit_test($session));
		}
		if(get_argument(ACTION) == CREATE_USER){
			echo($api->create_user($user));
		}
		if(get_argument(ACTION) == CREATE_SESSION){
			$user->setPassword(get_argument("password"),false);
			echo($api->create_session($user));

		}
		if(get_argument(ACTION) == GET_SESSION_USER_INFO){
			echo($api->get_session_user_info());
		}

		if(get_argument(ACTION) == ADD_PARENT){
			$user2 = new User(get_argument("parent_username"),get_argument("parent_id"),TYPE_GUEST);
			$user2->setId(get_argument("parent_id"));
			echo($api->add_parent($user,$user2));
		}

		if(get_argument(ACTION) == DELETE_PARENT){
			$user2 = new User(get_argument("parent_username"),get_argument("parent_id"),TYPE_GUEST);
			echo($api->delete_parent($user,$user2));
		}

		if(get_argument(ACTION) == GET_USER_INFO){
			echo($api->browse_user_info($user));
		}

		if(get_argument(ACTION) == DELETE_USER){
			echo($api->delete_user($user));

		}

		if(get_argument(ACTION) == GET_MEAL_PLAN){
			echo($api->get_meal_plan($user,get_argument("date")));
		}

		if(get_argument(ACTION) == GET_MEAL_DATABASE){
			echo($api->get_meal_database());
		}

		if(get_argument(ACTION) == GET_DINNER_TIMES_DATABASE){
			echo($api->get_dinner_time_database());
		}

		if(get_argument(ACTION) == GET_MATCHING_USERS){
			echo($api->get_matching_users($user));
		}

		if(get_argument(ACTION) == ""){
			echo(push_response(STATUS_ERROR,MISSING_INPUT));
		}
		

		$api->getStorage()->close();
	}
	answer_requests();
	
?>