<?php
    include_once("./unit_tests/unit_test.php");
    include_once("./storage/mysql.php");

    class Unit_Test_Mysql extends Unit_Test{
       
        public function __construct(){
            parent::__construct();
            $this->setName("Mysql");
        }

        public function assert(){
            $database = new Mysql();
            array_push($this->getEntries(),new Unit_Test_Entry("Create_Mysql","OK","Could create mysql class!"));

        }
        

    }
?>