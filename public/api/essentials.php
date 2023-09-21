<?php
	define("config_file","../../config.ini");
	
	//db return statuses!
	define("CREATED_USER","CREATED_USER");
	define("DELETED_USER","DELETED_USER");
	define("USER_EXISTS","USER_EXISTS");
	define("CONNECTION_ERROR","CONNECTION_ERROR");
	define("USER_NOT_FOUND","USER_NOT_FOUND");
	define("UNKNOWN_ERROR","UNKNOWN_ERROR");
	define("PERMISSION_DENIED","PERMISSION_DENIED");
	define("MISSING_INPUT","MISSING_INPUT");
	define("PARENT_UPDATED","PARENT_UPDATED");
	define("USER_UPDATED","USER_UPDATED");
	define("ALREADY_CHILD","ALREADY_CHILD");
	define("NOT_A_CHILD","NOT_A_CHILD");
	define("UNIT_TEST_PASSED","UNIT_TEST_PASSED");
	define("NO_DATA_FOUND_FOR_DATE","NO_DATA_FOUND_FOR_DATE");
	
	/*Different statuses */
	define("STATUS_OK","OK");
	define("STATUS_WARNING","WARNING");
	define("STATUS_ERROR","ERROR");
	
	/*Names used for response */
	define ("DATA","Data");
	define ("STATUS","Status");
	

	/*ACTIONS*/
	define("CREATE_USER","create_user");
	define("DELETE_USER","delete_user");
	define("CREATE_SESSION","create_session");
	define("ADD_PARENT","add_parent");
	define("DELETE_PARENT","delete_parent");
	define("GET_MEAL_PLAN","get_meal_plan");
	define("GET_MEAL_DATABASE","get_meal_database");
	define("GET_DINNER_TIMES_DATABASE","get_dinner_times_database");
	define("GET_MATCHING_USERS","get_matching_users");

	define("IS_VALID_SESSION","is_valid_session");
	define("GET_SESSION_USER_INFO","get_session_user_info");
	define("GET_USER_INFO","get_user_info");
	define("GET_WEBSITE_CFG","get_website_config");
	define("GET_CHILDREN","get_children");
	define("UNIT_TEST","unit_test");

	define("ACTION","action");

	/*Different user types! */
	define("TYPE_ADMIN","Administrator");
	define("TYPE_CAREGIVER","Caregiver");
	define("TYPE_PATIENT","Patient");
	define("TYPE_GUEST","Guest");

	define("BASETIME","1800-1-1");

	
	function get_cfg_val($name){
		$arr = get_cfg();
		if(key_exists($name,$arr)){
        	return $arr[$name];	
		}
		else{
			return null;
		}
    }

    function get_cfg(){
        return parse_ini_file(config_file);
    }
	
	function get_arguments(){
		if(get_cfg_val("method") == "GET"){
			return ($_GET);
		}
		if(get_cfg_val("method") == "POST"){
			return ($_POST);
		}
	}
	
	function get_argument($str){
		$args = get_arguments();
		if(isset($args)){
			if(isset($args[$str])){
				if($args[$str] != ''){
					return $args[$str];
				}return null;
			}
		}
		return null; 
	}
	function set_argument($str,$val){
		if(get_cfg_val("method") == "GET"){
			$_GET[$str] = $val;
		}else{
			$_POST[$str] = $val;
		}
	}
	
	function generateRandomString($length = 10) {
		$characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
		$charactersLength = strlen($characters);
		$randomString = '';
		for ($i = 0; $i < $length; $i++) {
			$randomString .= $characters[random_int(0, $charactersLength - 1)];
		}
		return $randomString;
	}

	function get_date_by_str($str,$basetime){
		if($str != null){
			if(strtotime($str)){
				if($date = getDate(strtotime($str))){
					if(is_array($date)){
						return $date["year"]."-".$date["mon"]."-".$date["mday"];
					}
				}
			}
		}

		return get_date_by_str($basetime,$basetime);
	}

	function get_date_today(){
		return get_date_by_str(date("Y/m/d"),date("Y/m/d"));

	}
		
		

	
?>