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
            $dinners = new Dinners($database);
            $notifications = new Notifications($dinners,$database);
            
            $user = $database->load_user(null,"Kristoffer");
            $database->delete_user($user);
                      
            $user = new User("Kristoffer","Kristoffer",TYPE_PATIENT,false);
            $database->save_user($user);
            $user = $database->load_user($user->getId(),$user->getUsername());
            $dinners->generateMealPlanEntriesForTheDay($user);
            if($user != null){
                foreach($dinners->getDinners() as $dinner){
                    $notification = $notifications->createNotification($user,$dinner);
                    $this->addEntry(new Unit_Test_Entry($dinner->getEnglish_name()."_notification_create",STATUS_OK,$notification->to_array()));
                }
            }else{
                $this->addEntry(new Unit_Test_Entry("USER NOT LOADED",STATUS_ERROR,"COULD NOT LOAD USER!"));
                $this->setStatus(STATUS_ERROR);
            }
            $this->setStatus(STATUS_OK);
            $notification = $notifications->getNotification($user);
            if($notification != null){
                $this->addEntry(new Unit_Test_Entry("getNotification",STATUS_OK,$notification->to_array()));
            }else{
                $this->addEntry(new Unit_Test_Entry("COULD NOT GET NOTIFICATION",STATUS_ERROR,"COULD NOT GET NOTIFICATION!"));
                $this->setStatus(STATUS_ERROR);
            }
            
            
        }
    }
?>