<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

    include_once("./index.php");
    include_once("./user/user.php");
    include_once("./user/mysql.php");
    include_once("./user/session.php");
    

    function unit_test_try_out_create(){
        $user = new User("Kristoffer","password",TYPE_GUEST);
        if($user->is_password("password")){
            if($user->getUsername() == "Kristoffer"){
                if($user->getType() == TYPE_GUEST){
                    if($user->getId() == null){
                        return "Works like expected!";
                    }
                    return "Was asigned id before mysql call!";
                }
                return "getType failed!";
            }
            return "Get username failed!";
        }else{
            return "is_password failed!";
        }

    }

    function unit_test_try_out_create_mysql(){
        $database = new Mysql();
        if($database != null){
            return "Could use constructor!";
        }
        return "Could not use constructor!";
    }

    function unit_test_try_out_give_id_user(){
        $database = new Mysql();
        $database->delete_user($database->load_user(null,"Kristoffer"));

        $user = new User("Kristoffer","Kristoffer",TYPE_GUEST);
        $database->save_user($user);
        if($user->getId() != null){
            if($database->exist_user($user)){
                $database->delete_user($user);
                return "Could give id to user and save in database!";
            }
            return "Could give id to user but not find user in database!";

        }
        return "Could not give id to user!";
    }

    function unit_test_try_out_save_user(){
        $database = new Mysql();
        $database->delete_user($database->load_user(null,"Kristoffer"));

        $user = new User("Kristoffer","Kristoffer",TYPE_GUEST);
        $database->save_user($user);
        if($user->getId() != null){
            if($database->exist_user($user)){
                $user->setUsername("Sprinkle");
                $database->save_user($user);
                $user = $database->load_user($user->getId());
                if($user->getUsername() == "Sprinkle"){
                    $database->delete_user($user);
                    return "Could create and save!";
                }
                $database->delete_user($user);
                return "Could give id to user but not call save!";
            }
            return "Could give id to user but not find user in database!";

        }
        return "Could not give id to user!";
    }

    function unit_test_try_out_add_parent_user(){

        $database = new Mysql();
        $database->delete_user($database->load_user(null,"Kristoffer"));
        $database->delete_user($database->load_user(null,"Kristoffer_Parent"));

        $user = new User("Kristoffer","Kristoffer",TYPE_GUEST);
        $database->save_user($user);
        $user2 = new User("Kristoffer_Parent","Kristoffer_Parent",TYPE_GUEST);
        $database->save_user($user2);
        if($user->getId() == $user2->getId() && $user->getId() == NULL){
            return "Could not give id to user!";
        }else{
            if(!$user->is_parent($user2->getId())){
                $user->add_parent($user2->getId());
                if($user->is_parent($user2->getId())){
                    $database->save_user($user);
                    $user = $database->load_user($user->getId());
                    if($user->is_parent($user2->getId())){
                        $database->delete_user($user2);
                        $user = $database->load_user($user->getId());
                        if(!$user->is_parent($user2->getId())){
                            
                            $database->delete_user($user);
                            return "Could create and add parent and save to database and no dead parent remained!"; 

                        }
                        return "Could create and add parent and save to database but once deleted, dead parent was still given!"; 
                    }
                    return "Could create and add parent but NOT save to database!";
                    
                }
                return "Could create but not add parent!";
            }

            return "Could create user but user was deemed as a parent for some reason!";
        }

    }

    function unit_test_try_out_session(){
        $database = new Mysql();

        $database->delete_user($database->load_user(null,"Kristoffer"));
        $user = new User("Kristoffer","password",TYPE_GUEST);
        $database->save_user($user);
        $session = new Session($user->getId());
        $database->save_session($session);

        if($session != null){
            $user = $database->get_user_from_session($session);
            if($user != null){
                return "All good!";
            }
            return "Could create session but not load it from the database";
        }
        return "Could not create session!";
    }

    function unit_test_try_out_session_delete(){
        $database = new Mysql();

        $database->delete_user($database->load_user(null,"Kristoffer"));
        $user = new User("Kristoffer","password",TYPE_GUEST);
        $database->save_user($user);


        $session = new Session($user->getId());
        $database->save_session($session);
        
        if($session->getId() != null){
            $user = $database->get_user_from_session($session);
            if($user != null){
                $database->delete_session($session);
                $user = $database->get_user_from_session($session);
                if($user == null){
                    return "All good!";
                }
                return "Could create session but not delete it from the database!";
            }
            return "Could create session but not load it from the database";
        }
        return "Could not create session!";
    }

    function unit_test_try_out_session_get(){
        $database = new Mysql();

        $database->delete_user($database->load_user(null,"Kristoffer"));
        $user = new User("Kristoffer","password",TYPE_GUEST);
        $database->save_user($user);

        for($i = 0; $i < 10; $i++){
            $session = new Session($user->getId());
            $database->save_session($session);
        }
        
        if(count($database->get_sessions_for_user($user)) == 10){
            foreach($database->get_sessions_for_user($user) as $session){
                $database->delete_session($session);
                if($database->get_user_from_session($session) == null){

                }else{
                    return "Could create, get them BUT not delete the sessions!";
                }
            }
            return "Could create, get them and then delete them!";
        }else{
            return "Could create or not get sessions!";
        }
        
        
        
    }

    function unit_test_try_out_save_permission(){
        $database = new Mysql();

        $permission = $database->get_permission("test_permission");

        if($permission != null){
            $permission->setAllowed(!$permission->getAllowed());
            $database->save_permission($permission);
            if($database->get_permission($permission->getName())->getAllowed() == $permission->getAllowed()){
                return "All good!";
            }

            return "Could load permission but not save it!";
        }

        return "Could not load permission!";
    }

    function unit_test_try_out_mysql(){
        $returning = array();
        $returning["Construct MYSQL connection"] = unit_test_try_out_create_mysql();
        $returning["Receive ID for user"]=unit_test_try_out_give_id_user();
        $returning["Create session"]=unit_test_try_out_session();
        $returning["Delete session"]=unit_test_try_out_session_delete();
        $returning["Get sessions"]=unit_test_try_out_session_get();
        $returning["Save user"]=unit_test_try_out_save_user();

        $returning["Save permission"]=unit_test_try_out_save_permission();


        return $returning;
    }

    function unit_test_try_out_users(){
        $returning = array();
        $returning["Construct user"] = unit_test_try_out_create();
        $returning["Add parent"]=unit_test_try_out_add_parent_user();

        return $returning;
    }



    function unit_test_try_out_dinners(){
        $returning = array();
        $returning["Construct dinner time"] = unit_test_try_out_create();
        $returning["Add parent"]=unit_test_try_out_add_parent_user();

        return $returning;
    }
    

    
?>