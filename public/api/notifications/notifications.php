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

    public function getMinutesPast(Dinner_Time $dinner_Time){
        $date = new DateTimeImmutable("now",new DateTimeZone(get_cfg_val("time_zone")));
        $time = $dinner_Time->getMinutesSinceShouldBeEaten($date);
        if($time < 0)
            $time = $time+24*60;
        
        return $time;
    }

    public function getDateToRequest(Dinner_Time $dinner){
        $date = new DateTimeImmutable("now",new DateTimeZone(get_cfg_val("time_zone")));
        $time = $dinner->getMinutesSinceShouldBeEaten($date);
        $datetorequest = new DateTimeImmutable($date->format("Y/m/d"),$date->getTimezone());
        if($time < 0){
            $datetorequest = $datetorequest->sub(new DateInterval("P1D"));
        }
        $datetorequest = get_date_by_str($datetorequest->format("Y/m/d"),null);
        return $datetorequest;
    }

    public function isEaten(User $user, Dinner_Time $dinner_Time){
        $entry = $this->getDinner()->loadMealPlanEntry($dinner_Time,$user,$this->getDateToRequest($dinner_Time));
        if($entry != null){
            return $entry->getHas_eaten();
        }
        return true;
    }

    public function getIdForEntryDinner(User $user, Dinner_Time $dinner_Time): ?String{
        $entry = $this->getDinner()->loadMealPlanEntry($dinner_Time,$user,$this->getDateToRequest($dinner_Time));
        if($entry != null)
        return $entry->getId();
        return null;
    }

    public function createNotification(User $user,Dinner_Time $dinner) : Notification{

        
        $notification = new Notification();
        $notification->setSwedish_message("time_".$this->getMinutesPast($dinner)."_date_".$this->getDateToRequest($dinner)."_eaten_".$this->isEaten($user,$dinner));
        $notification->setEnglish_message("time_".$this->getMinutesPast($dinner));
        $notification->setCriticality(NOTIFICATION_CRITICALITY_NONE);
        
        $past = $this->getMinutesPast($dinner);
        if(!$this->isEaten($user,$dinner)){
        if($past > get_cfg_val("TIME_NOW"))
            $notification->setCriticality(NOTIFICATION_CRITICALITY_NOW);
        if($past > get_cfg_val("TIME_LOW"))
            $notification->setCriticality(NOTIFICATION_CRITICALITY_LOW);
        if($past > get_cfg_val("TIME_MEDIUM"))
            $notification->setCriticality(NOTIFICATION_CRITICALITY_MEDIUM);
        if($past > get_cfg_val("TIME_HIGH"))
            $notification->setCriticality(NOTIFICATION_CRITICALITY_HIGH);
        if($past > get_cfg_val("TIME_FATAL"))
            $notification->setCriticality(NOTIFICATION_CRITICALITY_FATAL);
        }
        $notification->setId($user->getId()."_".$dinner->getId()."_".$this->getIdForEntryDinner($user,$dinner)."_".$notification->getCriticality());

        
        return $notification;
    }

    public function getNotification(User $user) : ?Notification{
        $notification = new Notification();
        if($user->getType() == TYPE_PATIENT){
            foreach($this->getDinner()->getDinners() as $dinner){
                $possiblenotification = $this->createNotification($user,$dinner);
                if($possiblenotification->isMoreCritical($notification) && !$this->isEaten($user,$dinner)){
                    $notification = $possiblenotification;
                    
                }
            }
        }
        if($user->getType() == TYPE_CAREGIVER){
            foreach($user->get_children() as $child){
                $notifications_critical = 0;
                $child = $this->getStorage()->load_user($child);
                if($child != null){
                    if($child->getType() == TYPE_PATIENT){
                        
                        foreach($this->getDinner()->getDinners() as $dinner){
                            $possiblenotification = $this->createNotification($child,$dinner);
                            if($possiblenotification->isMoreCriticalThan(NOTIFICATION_CRITICALITY_MEDIUM)){
                                $notifications_critical++;
                                if($notifications_critical >= 3){
                                    $notification->setId($possiblenotification->getId()."_".$user->getId()."_".$child->getId());
                                    break;
                                }
                            }
                        }

                    }
                }
                if($notifications_critical >= 3){
                    $notification->setCriticality(NOTIFICATION_CRITICALITY_NOW);
                    break;
                }
            }
        }

        $this->updateNotificationMessage($user,$notification);
        return $notification;
    }

    public function updateNotificationMessage(User $user,Notification &$notification){
        if($user->getType() == TYPE_PATIENT){
            if($notification->getCriticality() == NOTIFICATION_CRITICALITY_NOW){
                $notification->setSwedish_message(get_cfg_val("NOW_MESSAGE_PATIENT_SWEDISH"));
                $notification->setEnglish_message(get_cfg_val("NOW_MESSAGE_PATIENT_ENGLISH"));

            }
            if($notification->getCriticality() == NOTIFICATION_CRITICALITY_LOW){
                $notification->setSwedish_message(get_cfg_val("LOW_MESSAGE_PATIENT_SWEDISH"));
                $notification->setEnglish_message(get_cfg_val("LOW_MESSAGE_PATIENT_ENGLISH"));

            }
            if($notification->getCriticality() == NOTIFICATION_CRITICALITY_MEDIUM){
                $notification->setSwedish_message(get_cfg_val("MEDIUM_MESSAGE_PATIENT_SWEDISH"));
                $notification->setEnglish_message(get_cfg_val("MEDIUM_MESSAGE_PATIENT_ENGLISH"));

            }
            if($notification->getCriticality() == NOTIFICATION_CRITICALITY_HIGH){
                $notification->setSwedish_message(get_cfg_val("HIGH_MESSAGE_PATIENT_SWEDISH"));
                $notification->setEnglish_message(get_cfg_val("HIGH_MESSAGE_PATIENT_ENGLISH"));
            }
            if($notification->getCriticality() == NOTIFICATION_CRITICALITY_FATAL){
                $notification->setSwedish_message(get_cfg_val("FATAL_MESSAGE_PATIENT_SWEDISH"));
                $notification->setEnglish_message(get_cfg_val("FATAL_MESSAGE_PATIENT_ENGLISH"));
            }
            
        }
        if($user->getType() == TYPE_CAREGIVER){
            if($notification->getCriticality() == NOTIFICATION_CRITICALITY_NOW){
                $notification->setSwedish_message(get_cfg_val("NOW_MESSAGE_CAREGIVER_SWEDISH"));
                $notification->setEnglish_message(get_cfg_val("NOW_MESSAGE_CAREGIVER_ENGLISH"));
            }
            if($notification->getCriticality() == NOTIFICATION_CRITICALITY_FATAL){
                $notification->setSwedish_message(get_cfg_val("FATAL_MESSAGE_CAREGIVER_SWEDISH"));
                $notification->setEnglish_message(get_cfg_val("FATAL_MESSAGE_CAREGIVER_ENGLISH"));
            }
        }
    }

}
?>