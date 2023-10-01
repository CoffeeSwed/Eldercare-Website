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
        $user2 = $database->load_user($user->getId(),$user->getUsername());
        if($user2 != null){
            $database->delete_user($user2);

        }
        $database->save_user($user);
        $user = $database->load_user($user->getId(),$user->getUsername());
        if($user == null){
            return;
        }



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
        
        $meal_plan_entry = $dinner->loadMealPlanEntry(null,null,null,$dinner->loadMealPlanEntriesForUser($user)[0]->getId());
        if($meal_plan_entry == null){
            $this->addEntry(new Unit_Test_Entry("LoadMealPLantEntry",STATUS_ERROR,"Could not load a meal plan!"));
            $this->setStatus(STATUS_ERROR);
            return;
        }
        $this->addEntry(new Unit_Test_Entry("LoadMealPLantEntry",STATUS_OK,"Could load a meal plan!"));

        $note = $meal_plan_entry->getNote();
        if($note != ""){
            $this->addEntry(new Unit_Test_Entry("LoadNote",STATUS_ERROR,"Note was not empty when it should be!"));
            $this->setStatus(STATUS_ERROR);
            return;
        }
        $this->addEntry(new Unit_Test_Entry("LoadNote",STATUS_OK,"Note was empty when it should be!"));
        $dinner_time = $dinner->get_dinner_time_by_id($meal_entry_loaded->getDimmer_time());
        $dinner->setNote($dinner_time,$user,"Hejsan där!");

        $meal_plan_entry = $dinner->loadMealPlanEntry(null,null,null,$dinner->loadMealPlanEntriesForUser($user)[0]->getId());
        $note = $meal_plan_entry->getNote();
        if($note == ""){
            $this->addEntry(new Unit_Test_Entry("SetNote",STATUS_ERROR,"Note was empty when it should be!"));
            $this->setStatus(STATUS_ERROR);
            return;
        }
        $this->addEntry(new Unit_Test_Entry("SetNote",STATUS_OK,"Note was not empty when it shouldn't be!"));
        $dinner->setNote($dinner_time,$user,"");

        $meal_plan_entry = $dinner->loadMealPlanEntry(null,null,null,$dinner->loadMealPlanEntriesForUser($user)[0]->getId());
        $note = $meal_plan_entry->getNote();
        if($note != ""){
            $this->addEntry(new Unit_Test_Entry("SetNote",STATUS_ERROR,"Note was not empty when it should be!"));
            $this->setStatus(STATUS_ERROR);
            return;
        }
        $this->addEntry(new Unit_Test_Entry("SetNote",STATUS_OK,"Note was empty when it should be!"));

        $settings = $dinner->getSettings($dinner_time,$user);
        
        if($settings["show_note"] != $meal_plan_entry->getShow_note() || $settings["enabled"] != $meal_plan_entry->getEnabled()
        || $settings["show_meal_types"] != $meal_plan_entry->getShow_meal_types()){
            $this->addEntry(new Unit_Test_Entry("GetSettings",STATUS_ERROR,"Settings was not equal to given settings!
            show_meal_types_good = ".($meal_plan_entry->getShow_meal_types() == $settings["show_meal_types"])." 
            show_note_good = ".($meal_plan_entry->getShow_note() == $settings["show_note"])." 
            enabled_good = ".($meal_plan_entry->getEnabled() == $settings["enabled"])." "));
            $this->setStatus(STATUS_ERROR);

            return;
        }
        $this->addEntry(new Unit_Test_Entry("GetSettings",STATUS_OK,"Settings for meal entry was equal to given settings!"));

        $dinner->setSetting($dinner_time,$user,"show_note",!$settings["show_note"]);
        $dinner->setSetting($dinner_time,$user,"enabled",!$settings["enabled"]);
        $dinner->setSetting($dinner_time,$user,"show_meal_types",!$settings["show_meal_types"]);

        $settings2 = $dinner->getSettings($dinner_time,$user);

        foreach(array_keys($settings2) as $key){
            if($settings2[$key] == $settings[$key]){
                $this->addEntry(new Unit_Test_Entry("SetSettings",STATUS_ERROR,"Settings for meal entry was NOT equal to given ".$key." setting!"));
                return;
            }
        }
        
        $this->addEntry(new Unit_Test_Entry("SetSettings",STATUS_OK,"Settings for meal entry was equal to given settings!"));

        $meal_entry->setHas_eaten(true);
        $dinner->saveMealPlanEntry($meal_entry);
        $meal_entry = $dinner->loadMealPlanEntry($dinner_time,null,null,$meal_entry->getId());
        if($meal_entry == null){
            $this->addEntry(new Unit_Test_Entry("setEaten",STATUS_ERROR,"Meal was not eaten when it should be!"));
            $this->setStatus(STATUS_ERROR);
            return;
        }
        $this->addEntry(new Unit_Test_Entry("setEaten",STATUS_OK,"Meal was eaten when it should be!"));
        
        $stats = $dinner->getStats($dinner_time,$user,"1800-01-01",get_date_today());
        if($stats["eaten"] == 0){
            $this->addEntry(new Unit_Test_Entry("getTotalEaten",STATUS_ERROR,"Get stats returned wrong value!"));
            $this->setStatus(STATUS_ERROR);
            return;
        }
        $this->addEntry(new Unit_Test_Entry("getTotalEaten",STATUS_OK,"Get stats returned correct value!"));
        //print_r($stats);
    }
}


?>