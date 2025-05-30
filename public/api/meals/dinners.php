<?php
include_once("./essentials.php");
include_once("dinner_time/dinner_time.php");
include_once("meal_plan/meal_plan.php");


class Dinners{
    private $dinners;

	private $meal_types;
    private Storage $storage;
    
    public function __construct(Storage $storage){
        $this->setDinners(array());
		$this->setMeal_types(array());
        $this->setStorage($storage);
        $this->reload_Dinners();
		$this->reload_Meal_Types();
    }
    

	/**
	 * @return mixed
	 */
	public function& getDinners() {
		return $this->dinners;
	}
	
	/**
	 * @param mixed $dinners 
	 * @return self
	 */
	public function setDinners($dinners): self {
		$this->dinners = $dinners;
		return $this;
	}

    public function addDinner(Dinner_Time $type){
        array_push($this->getDinners(),$type);
		throw new Exception('Not implemented');
        
    }

	public function addMealType(Meal_Type $type){
		
		array_push($this->getMeal_types(),$type);
		throw new Exception('Not implemented');	}

	/**
	 * @return Storage
	 */
	public function getStorage(): Storage {
		return $this->storage;
	}
	
	/**
	 * @param Storage $storage 
	 * @return self
	 */
	public function setStorage(Storage $storage): self {
		$this->storage = $storage;
		return $this;
	}

    public function reload_Dinners(){
        $this->getStorage()->cache_flush();

		$this->setDinners($this->getStorage()->load_dinners());

		$this->sortDinnerTimes();
		
    }

	public function reload_Meal_Types(){
		$this->getStorage()->cache_flush();

		$meal_types = $this->getStorage()->load_meal_types();
		

		$this->setMeal_types($this->getStorage()->load_meal_types());
		
	}

	public function getDinners_to_array(){
		$arr = array();
		foreach($this->getDinners() as $dinner){
			array_push($arr,$dinner->to_array());
		}
		return $arr;
	}

	public function getMeal_types_to_array(){
		$arr = array();
		foreach($this->getMeal_types() as $meal){
			array_push($arr,$meal->to_array());
		}
		return $arr;
	}
	

	/**
	 * @return mixed
	 */
	public function& getMeal_types() {
		return $this->meal_types;
	}
	
	/**
	 * @param mixed $meal_types 
	 * @return self
	 */
	public function setMeal_types($meal_types): self {
		$this->meal_types = $meal_types;
		return $this;
	}

	public function get_dinner_time_by_id($id) : ?Dinner_Time{
		foreach($this->getDinners() as $dinner){
			if($dinner->getId() == $id){
				return $dinner;
			}
		}
		return null;
	}

	public function get_meal_types_available_at(Dinner_Time $when) : array{
		$arr = array();
		
		foreach($this->getMeal_types() as $meal_type){
			foreach($meal_type->getAvailable_at() as $id){
				if($when->getId() == $id){
					array_push($arr,$meal_type);
					break;
				}
			}
		}

		return $arr;
	}

	

	public function generateMealPlanEntry(Dinner_Time $when, User $user) : ?Meal_Plan_Entry{
		if($when == null)
			return null;

		$meals_available = $this->get_meal_types_available_at($when);
		$meal_entry = new Meal_Plan_Entry($when->getId(),array());
		$meal_entry->addMeal_type($meals_available[random_int(0,count($meals_available)-1)]->getId());
		$meal_entry->setOwnerID($user == null ? null : $user->getId());

		return $meal_entry;
	}

	public function saveMealPlanEntry(Meal_Plan_Entry $entry){

		$this->getStorage()->save_meal_plan_entry($entry);
		

	}

	
	public function loadMealPlanEntry(?Dinner_Time $when,?User $owner,?string $date = null,$id = null){
		
		if($date != null){
			$date = get_date_by_str($date,date("Y/m/d"));
		}

		$meal = $this->getStorage()->load_meal_plan_entry(($owner != null) ? $owner->getId() : null,($when != null) ? $when->getId() : null,$date,$id);
			

		return $meal;
		
		
	}

	public function loadMealPlanEntriesForUser(User $user, string $date = null) : array{
		$date = get_date_by_str($date,date("Y/m/d"));
		

		

		return $this->getStorage()->load_meal_plan_entries($user->getId(),$date);
	}

	public function isDinnerTimeEnabled(User $user, Dinner_Time $dinner_Time){
		$setts = $this->getStorage()->get_settings_for_dinner_time($dinner_Time->getId(),$user->getId());
		return $setts["enabled"];
	}

	public function sortDinnerTimes(){
		usort($this->dinners,function($a,$b){
			$ad = new DateTime($a->getWhen());
			$bd = new DateTime($b->getWhen());
			if($ad == $bd)
				return 0;

			return $ad < $bd ? -1 : 1;
		});
	}

	public function generateMealPlanEntriesForTheDay(User $user, string $date = null){
		$date = get_date_by_str($date,date("Y/m/d"));
		
		foreach($this->getDinners() as $dinner){
			if($this->isDinnerTimeEnabled($user,$dinner)){
				$meal = $this->generateMealPlanEntry($dinner,$user);
				$meal->setDay($date);
				$this->saveMealPlanEntry($meal);
			}
		}

	}

	public function setNote(Dinner_Time $time, User $user,?string $note){
		if($note == null)
			$note = "";
		$this->getStorage()->set_note($time->getId(),$user->getId(),$note);
	}
	
	public function getSettings(Dinner_Time $time, User $user){
		$settings = $this->getStorage()->get_settings_for_dinner_time($time->getId(),$user->getId());
		$settings["note"] = $this->getStorage()->get_note($time->getId(),$user->getId());
		return $settings;
	}

	public function setSetting(Dinner_Time $time, User $user,string $setting, bool $val){
		$settings = $this->getStorage()->get_settings_for_dinner_time($time->getId(),$user->getId());
		$settings[$setting] = $val;
		
		$this->getStorage()->save_settings_for_dinner_time($time->getId(),$user->getId(),$settings);
	}

	public function getStats(Dinner_Time $time, User $user, String $start,String $end ){
		$arr = array();
		$arr["eaten"] = 0;
		$arr["not_eaten"] = 0;
		$start = get_date_by_str($start,date("Y/m/d"));
		$end = get_date_by_str($end,date("Y/m/d"));

		$arr["eaten"] = $this->getStorage()->get_eaten($time->getId(),$user->getId(),$start,$end);
		$arr["not_eaten"] = $this->getStorage()->get_not_eaten($time->getId(),$user->getId(),$start,$end);
		return $arr;
	}


	
	


}

?>