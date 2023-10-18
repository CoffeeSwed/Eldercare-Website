<?php
    include_once("./unit_tests/unit_test.php");
    include_once("./storage/mysql.php");

    class Unit_Test_Mysql extends Unit_Test{
       
        public function __construct(){
            parent::__construct();
            $this->setName("Mysql");
        }

        public function create_test_user(Storage $database){
            $user = new User("Kristoffer","Kritoffer",TYPE_PATIENT,true);
            if($database->load_user(null,$user->getUsername()) != null){
                //$this->addEntry(new Unit_Test_Entry("Creating_User",STATUS_WARNING,"Deleting user Kristoffer"));
                $user = $database->load_user(null,$user->getUsername());
                $database->delete_user($user);
                //$this->addEntry(new Unit_Test_Entry("Creating_User",STATUS_WARNING,"Deleted user!"));
            }
            $user = new User("Kristoffer","Kritoffer",TYPE_PATIENT,true);
            return $user;
        }
        

        public function test_save_user(Storage $database){
            $user = $this->create_test_user($database);
            $database->save_user($user);
            //$this->addEntryS("Creating_User","Could call save_user, now trying to load user!");
            $user = $database->load_user(null,$user->getUsername());
            if($user->getId() == null){
                $this->addEntryE("Create_User","User could not be loaded!");
                $this->setStatus(STATUS_ERROR);
                return;
            }
            //$this->addEntryS("Creating_User","Could load user, now trying to modify!");
            $user->setFirst_name("Cooler man");
            $database->save_user($user);
            $user = $database->load_user(null,$user->getUsername());
            if($user->getFirst_name() != "Cooler man"){
                $this->addEntryE("Create_User","Could not save modified user!");
                $this->setStatus(STATUS_ERROR);
            }
            $this->addEntryS("Create_User","Could create user, load user, and then save modified user!");
                
        }

        public function test_delete_user(Storage $database){
            $user = $this->create_test_user($database);
            $database->save_user($user);
            $user = $database->load_user(null,$user->getUsername());
            $name = $user->getUsername();
            $database->delete_user($user);
            $user = $database->load_user(null,$name);
            if($user == null){
                $this->addEntryS("Delete_User","User did not exist after delete_user call!");
                return;
            }
            $this->addEntryE("Delete_User","User did exist after delete_user call!");
            $this->setStatus(STATUS_ERROR);

        }

        public function test_user_exist(Storage $database){
            $user = $this->create_test_user($database);
            if($database->exist_user($user)){
                $this->addEntryE("User_Exist","User did exist even when it shouldn't!");
                $this->setStatus(STATUS_ERROR);
                return;
            }
            $database->save_user($user);
            if(!$database->exist_user($user)){
                $this->addEntryE("User_Exist","User did not exist even when it should!");
                $this->setStatus(STATUS_ERROR);
                return;
            }
            $this->addEntryS("User_Exist","User exist behaved as expected!");

        }

        public function test_session(Storage $database){
            $user = $this->create_test_user($database);
            $database->save_user($user);
            $session = new Session($user->getId());
            $database->save_session($session);
            if($session->getId() == null){
                $this->setStatus(STATUS_ERROR);
                $this->addEntryE("save_session","Could not create session!");
            }
            $this->addEntryS("save_session","Could create session!");
            
            $user = $database->get_user_from_session($session);
            if($user == null){
                $this->addEntryE("load_user","Could not load user from session!");
                $this->setStatus(STATUS_ERROR);
                return;
            }
            else{
                $this->addEntryS("load_user","Could load user form session!");
            }

            if(count($database->get_sessions_for_user($user)) == 0){
                $this->setStatus(STATUS_ERROR);
                $this->addEntryE("get_sessions","get sessions returned an empty array!");
                return;
            }
            $this->addEntryS("get_sessions","get_sessions returned an none empty array!");



            $database->delete_session($session);
            if($user != null){
                $this->addEntryS("delete_session","Could delete session!");
                return;
            }
            else{
                $this->addEntryE("delete_session","Could not delete session!");
                $this->setStatus(STATUS_ERROR);
            }


        }

        public function test_permissions(Storage $database){
            
        }


        public function assert(){
            $database = new Mysql();
            $this->addEntry(new Unit_Test_Entry("Create",STATUS_OK,"Could create instance"));
            $this->test_save_user($database);
            $this->test_delete_user($database);
            $this->test_user_exist($database);
            $this->test_session($database);
            $this->test_permissions($database);

        }
        

    }
?>