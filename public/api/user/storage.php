<?php
include_once("user.php");
include_once("permission.php");

define("USER_ALREADY_EXIST","USER_ALREADY_EXIST");
define("USER_ID_ASSIGNED","USER_ID_ASSIGNED");

    interface Storage{
        public function __construct();
        public function save_user(User $user);
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
    }
?>