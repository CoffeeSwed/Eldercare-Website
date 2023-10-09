<?php
include_once(__DIR__."/../user/user.php");
    class Notification{
        private User $user;

        private Dinner_Time $dinner_Time;
        
        private String $swedish_message;
        private String $english_message;
    
	/**
	 * @return User
	 */
	public function getUser(): User {
		return $this->user;
	}
	
	/**
	 * @param User $user 
	 * @return self
	 */
	public function setUser(User $user): self {
		$this->user = $user;
		return $this;
	}

	/**
	 * @return Dinner_Time
	 */
	public function getDinner_Time(): Dinner_Time {
		return $this->dinner_Time;
	}
	
	/**
	 * @param Dinner_Time $dinner_Time 
	 * @return self
	 */
	public function setDinner_Time(Dinner_Time $dinner_Time): self {
		$this->dinner_Time = $dinner_Time;
		return $this;
	}

	/**
	 * @return string
	 */
	public function getSwedish_message(): string {
		return $this->swedish_message;
	}
	
	/**
	 * @param string $swedish_message 
	 * @return self
	 */
	public function setSwedish_message(string $swedish_message): self {
		$this->swedish_message = $swedish_message;
		return $this;
	}

	/**
	 * @return string
	 */
	public function getEnglish_message(): string {
		return $this->english_message;
	}
	
	/**
	 * @param string $english_message 
	 * @return self
	 */
	public function setEnglish_message(string $english_message): self {
		$this->english_message = $english_message;
		return $this;
	}
}
?>