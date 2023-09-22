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

	public function loadMealPlanEntry(Dinner_Time $when,User $owner,?string $date = null){
		
		$date = get_date_by_str($date,date("Y/m/d"));


		$meal = $this->getStorage()->load_meal_plan_entry($owner->getId(),$when->getId(),$date);
		

		return $meal;
	}

	public function loadMealPlanEntriesForUser(User $user, string $date = null) : array{
		$date = get_date_by_str($date,date("Y/m/d"));
		

		

		return $this->getStorage()->load_meal_plan_entries($user->getId(),$date);
	}

	public function generateMealPlanEntriesForTheDay(User $user, string $date = null){
		$date = get_date_by_str($date,date("Y/m/d"));
		foreach($this->getDinners() as $dinner){
			$meal = $this->generateMealPlanEntry($dinner,$user);
			$meal->setDay($date);
			$this->saveMealPlanEntry($meal);
		}

	}
}

?>