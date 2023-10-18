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
                $this->addEntry(new Unit_Test_Entry("Creating_User",STATUS_WARNING,"Deleting user Kristoffer"));
                $user = $database->load_user(null,$user->getUsername());
                $database->delete_user($user);
                $this->addEntry(new Unit_Test_Entry("Creating_User",STATUS_WARNING,"Deleted user!"));
            }
            $user = new User("Kristoffer","Kritoffer",TYPE_PATIENT,true);
            return $user;
        }
        

        public function test_save_user(Storage $database){
            $user = $this->create_test_user($database);
            $database->save_user($user);
            $this->addEntryS("Creating_User","Could call save_user, now trying to load user!");
            $user = $database->load_user(null,$user->getUsername());
            if($user->getId() == null){
                $this->addEntryE("Creating_User","User could not be loaded!");
                return;
            }
            $this->addEntryS("Creating_User","Could load user, now trying to modify!");
            $user->setFirst_name("Cooler man");
            $database->save_user($user);
            $user = $database->load_user(null,$user->getUsername());
            if($user->getFirst_name() != "Cooler man"){
                $this->addEntryE("Creating_User","Could not save modified user!");
            }
            $this->addEntryS("Creating_User","Could save modified user!");
                
        }

        public function assert(){
            $database = new Mysql();
            $this->addEntry(new Unit_Test_Entry("Create",STATUS_OK,"Could create instance"));
            $this->test_save_user($database);
        }
        

    }
?>