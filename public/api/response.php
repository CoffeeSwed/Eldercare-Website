<?php
	include_once("essentials.php");
	function push_response($status,$val){
		global $allow_push_echo;
		
		if(get_cfg_val("response_type") == "JSON"){
			
				$val = array(STATUS => $status,DATA => $val);
		
			
			$val[STATUS] = $status;
				return(json_encode($val));
		}else{
			return($val);
		}
	}

	
?>