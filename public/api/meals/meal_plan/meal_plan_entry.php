<?php
    include_once(__DIR__ ."/../dinners.php");
	include_once(__DIR__ ."/../../essentials.php");


    class Meal_Plan_Entry{
        private int $dimmer_time;

        private array $meal_types;

        private bool $has_eaten;

		private $id;

		private ?string $owner;

		private $day;



	/**
	 * @return Dinner_Time
	 */
	public function getDimmer_time(): int {
		return $this->dimmer_time;
	}
	
	/**
	 * @param Dinner_Time $dimmer_time 
	 * @return self
	 */
	public function setDimmer_time(int $dimmer_time): self {
		$this->dimmer_time = $dimmer_time;
		return $this;
	}

	/**
	 * @return array
	 */
	public function &getMeal_types(): array {
		return $this->meal_types;
	}
	
	/**
	 * @param array $meal_types 
	 * @return self
	 */
	public function setMeal_types(array $meal_types): self {
		$this->meal_types = $meal_types;
		return $this;
	}

	public function addMeal_type($meal_type){
		array_push($this->getMeal_types(),$meal_type);
	}

	/**
	 * @return bool
	 */
	public function getHas_eaten(): bool {
		return $this->has_eaten;
	}
	
	/**
	 * @param bool $has_eaten 
	 * @return self
	 */
	public function setHas_eaten(bool $has_eaten): self {
		$this->has_eaten = $has_eaten;
		return $this;
	}

    public function __construct(string $dinner_time_id, array $to_eat, string $owner_id=null, $day=null){
        $this->setDimmer_time($dinner_time_id);
        $this->setMeal_types($to_eat);
        $this->setHas_eaten(false);
		$this->setId(null);
		$this->setOwnerID($owner_id);
		$this->setDay(get_date_by_str($day,date("Y/m/d")));
	}

	public function to_array() : array{
		$arr = array();
		$arr["id"] = $this->getId();

		$arr["owner"] = $this->getOwnerID() != null ? $this->getOwnerID() : null;

		$arr["when"] = $this->getDimmer_time();

		$arr["date"] = $this->getDay() != null ? $this->getDay() : null;

		$arr["has_eaten"] = $this->getHas_eaten() ? true : false;

		$arr["meal_types"] = array();
		foreach($this->getMeal_types() as $meal_type){
			array_push($arr["meal_types"],intval($meal_type));
		}
	
		

		

		return $arr;
	}

	

	/**
	 * @return mixed
	 */
	public function getId() {
		return $this->id;
	}
	
	/**
	 * @param mixed $id 
	 * @return self
	 */
	public function setId($id): self {
		$this->id = $id;
		return $this;
	}

	/**
	 * @return mixed
	 */
	public function getDay() {
		return $this->day;
	}
	
	/**
	 * @param mixed $day 
	 * @return self
	 */
	public function setDay($day): self {
		$this->day = $day;
		return $this;
	}

	/**
	 * @return mixed
	 */
	public function getOwnerID() : ?string {
		return $this->owner;
	}
	
	/**
	 * @param mixed $owner 
	 * @return self
	 */
	public function setOwnerID(?string $owner): self {
		$this->owner = $owner;
		return $this;
	}
}
?>