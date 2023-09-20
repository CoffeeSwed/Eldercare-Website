<?php
include_once("./essentials.php");
include_once("dinner_time/dinner_time.php");

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
        //
    }

	public function addMealType(Meal_Type $type){
		array_push($this->getMeal_types(),$type);
	}

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
        $this->getStorage()->open();

		$this->setDinners($this->getStorage()->load_dinners());
		
        $this->getStorage()->close();
    }

	public function reload_Meal_Types(){
		$this->getStorage()->cache_flush();
        $this->getStorage()->open();

		$this->setMeal_types($this->getStorage()->load_meal_types());
		
        $this->getStorage()->close();
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
}

?>