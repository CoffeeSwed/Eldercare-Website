<?php
include_once("./user/user.php");
include_once("permission.php");
include_once("./meals/dinners.php");
include_once("./meals/meal_types/meal_type.php");

define("USER_ALREADY_EXIST","USER_ALREADY_EXIST");
define("USER_ID_ASSIGNED","USER_ID_ASSIGNED");

    interface Storage{
        public function __construct();
        public function save_user(User& $user);
        public function load_user($id=null,$name=null) : ?User;

        public function delete_user(?User $user);
        
        public function exist_user(User $user) : bool;

        public function save_session(Session $session);

        public function delete_session(Session $session);

        public function get_user_from_session(Session $session) : ?User;

        public function get_sessions_for_user(User $user);
        
        public function get_permission($name) : Permission;

        public function save_permission(Permission $permission);



        public function close();
        
        public function open();

        public function cache_flush();

        public function load_dinners() : array;

        public function load_meal_types() : array;

        //public function load_meal_plan_entrys(User $user, $date) : array;

        public function save_meal_plan_entry(Meal_Plan_Entry& $meal_plan_entry);

        public function load_meal_plan_entry(?String $owner_id,?String $dinner_time_id,?String $date,$id=null) : ?Meal_Plan_Entry;
        public function load_meal_plan_entries($owner_id,$date);

        public function get_matching_users(User $user) : array;

        public function set_note($dinner_time_id, $owner_id, $note);

        public function get_note($dinner_time_id, $owner_id);

        public function get_settings_for_dinner_time($dinner_time_id, $owner_id) : array;

        public function save_settings_for_dinner_time($dinner_time_id, $owner_id,?array $arr);

        public function get_eaten($dinner_time_id,$owner_id,string $start, string $end) : int;

        public function get_not_eaten($dinner_time_id,$owner_id,string $start, string $end) : int;
        
    }
?>