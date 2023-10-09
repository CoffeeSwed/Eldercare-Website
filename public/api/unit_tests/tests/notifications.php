<?php include_once("./storage/mysql.php");
    include_once("./meals/dinners.php");
    include_once("./notifications/notifications.php");

    class Unit_Test_Notifications extends Unit_Test{
        public function __construct(){
            parent::__construct();
            $this->setName("Notifications");
        }

        public function assert(){
            $database = new Mysql();
            $dinner = new Dinners($database);
            $notifications = new Notifications($dinner,$database);

            $user = new User("Kristoffer","Kristoffer",TYPE_PATIENT,false);
            $database->save_user($user);
            $user = $database->load_user($user->getId(),$user->getUsername());
            if($user != null){
                $this->addEntry(new Unit_Test_Entry("ShouldWriteNotification",STATUS_OK,$notifications->shouldCreateNotification($user)));
            }else{
                $this->setStatus(STATUS_ERROR);
            }
            $this->setStatus(STATUS_OK);
        }
    }
?>