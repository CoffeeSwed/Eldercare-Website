<?php
    include_once("./storage/mysql.php");
    include_once("./meals/dinners.php");

    class Unit_Test_Meals extends Unit_Test{
    public function __construct(){
        parent::__construct();
        $this->setName("Meals");
    }

    public function assert(){
        $database = new Mysql();
        $dinner = new Dinners($database);
        $this->addEntry(new Unit_Test_Entry("Create_Dinners",STATUS_OK,"Could create dinners instance"));

        if(count($dinner->getDinners()) == 0){
            $this->addEntry(new Unit_Test_Entry("Load_Dinners",STATUS_ERROR,"Could not load dinners"));
            $this->setStatus(STATUS_ERROR);
            return;
        }
        $this->addEntry(new Unit_Test_Entry("Load_Dinners",STATUS_OK,array("dinner_times" => $dinner->getDinners_to_array())));

        if(count($dinner->getMeal_types()) == 0){
            $this->addEntry(new Unit_Test_Entry("Load_Meal_Types",STATUS_ERROR,"Could not load meal types"));
            $this->setStatus(STATUS_ERROR);
            return;
        }
        $this->addEntry(new Unit_Test_Entry("Load_Meal_Types",STATUS_OK,array("meal_types" => $dinner->getMeal_types_to_array())));

       
    }
}


?>