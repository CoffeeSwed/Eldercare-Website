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
        $user = new User("Kristoffer","Norman",TYPE_GUEST);
        
        $database->delete_user($user);
        $database->save_user($user);
        $user = $database->load_user($user->getId(),$user->getUsername());

        $this->addEntry(new Unit_Test_Entry("Create_Dinners",STATUS_OK,"Could create dinners instance"));

        if(count($dinner->getDinners()) == 0){
            $this->addEntry(new Unit_Test_Entry("Load_Dinners",STATUS_ERROR,"Could not load dinners"));
            $this->setStatus(STATUS_ERROR);
            return;
        }
        $this->addEntry(new Unit_Test_Entry("Load_Dinners",STATUS_OK,"Could load dinner times"));

        if(count($dinner->getMeal_types()) == 0){
            $this->addEntry(new Unit_Test_Entry("Load_Meal_Types",STATUS_ERROR,"Could not load meal types"));
            $this->setStatus(STATUS_ERROR);
            return;
        }
        $this->addEntry(new Unit_Test_Entry("Load_Meal_Types",STATUS_OK,"Could load meal types"));




        $meal_entry = $dinner->generateMealPlanEntry($dinner->getDinners()[0],$user);
        if($meal_entry == null){
            $this->addEntry(new Unit_Test_Entry("generate_meal_plan_entry",STATUS_ERROR,"Could not generate meal plan entry"));
            $this->setStatus(STATUS_ERROR);
            return;
        }
        if(count($meal_entry->getMeal_types()) < 1){
            $this->addEntry(new Unit_Test_Entry("generate_meal_plan_entry",STATUS_ERROR,"Could not generate meal plan entry"));
            $this->setStatus(STATUS_ERROR);
            return;
        }
        $this->addEntry(new Unit_Test_Entry("generate_meal_plan_entry",STATUS_OK,"Could generate meal plan!"));
        
        $meal_entry->setHas_eaten(true);
        
        $dinner->saveMealPlanEntry($meal_entry);
        $this->addEntry(new Unit_Test_Entry("save_meal_plan_entry",STATUS_OK,"Could save meal plan entry without error, now trying to load!"));

        $meal_entry_loaded = $dinner->loadMealPlanEntry($dinner->getDinners()[0],$user,$meal_entry->getDay());




        if($meal_entry_loaded == null){
            $this->addEntry(new Unit_Test_Entry("load_meal_plan_entry",STATUS_ERROR,"Could not load meal plan entry"));
            $this->setStatus(STATUS_ERROR);
            return;
        }




        if($meal_entry_loaded->getDay() != $meal_entry->getDay() || $meal_entry_loaded->getDimmer_time() != $meal_entry->getDimmer_time() || $meal_entry->getHas_eaten() != $meal_entry_loaded->getHas_eaten() || $meal_entry->getOwnerID() != $meal_entry_loaded->getOwnerID()){
            $this->addEntry(new Unit_Test_Entry("load_meal_plan_entry",STATUS_ERROR,"Could not load meal plan entry"));
            $this->setStatus(STATUS_ERROR);
            return;
        }
        $this->addEntry(new Unit_Test_Entry("load_meal_plan_entry",STATUS_OK,"Could load meal plan."));



        $dinner->generateMealPlanEntriesForTheDay($user);
        if(count($dinner->loadMealPlanEntriesForUser($user)) != count($dinner->getDinners())){
            $this->addEntry(new Unit_Test_Entry("generate_meal_plan_entry_for_the_day",STATUS_ERROR,"Could not generate a meal plan for the day!"));
            $this->setStatus(STATUS_ERROR);
            return;

        }
            $this->addEntry(new Unit_Test_Entry("generate_meal_plan_entry_for_the_day",STATUS_OK,"Could generate a meal plan for the day!"));
        
    }
}


?>