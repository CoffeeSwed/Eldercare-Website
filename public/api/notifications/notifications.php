<?php
include_once(__DIR__."/../essentials.php");
include_once(__DIR__."/../meals/dinners.php");
include_once(__DIR__."/../storage/storage.php");
include_once(__DIR__."/../user/user.php");

include_once("notification.php");
class Notifications{
    private Storage $storage;

    private Dinners $dinner;

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

	/**
	 * @return Dinners
	 */
	public function getDinner(): Dinners {
		return $this->dinner;
	}
	
	/**
	 * @param Dinners $dinner 
	 * @return self
	 */
	public function setDinner(Dinners $dinner): self {
		$this->dinner = $dinner;
		return $this;
	}


    public function __construct(Dinners $dinners, Storage $storage){
        $this->setDinner($dinners);
        $this->setStorage($storage);
    }

    public function shouldCreateNotification(User $user) : bool{
        foreach($this->getDinner()->getDinners() as $dinner){
            $mins = $dinner->getMinutesSinceShouldBeEaten(new DateTimeImmutable("now",new DateTimeZone(get_cfg_val("time_zone"))));
            if($this->getDinner()->isDinnerTimeEnabled($user,$dinner) && $mins > 0){
                $meal_plan = $this->getDinner()->loadMealPlanEntry($dinner,$user,get_date_today());
                if($meal_plan != null){
                    if(!$meal_plan->getHas_eaten()){
                        return true;
                    }
                }

                
            }
        }

        return false;
    }
    
}
?>