pragma solidity ^0.5.0;
//import library to prevent integer underflow / overflow.
import "./SafeMath.sol";

contract Adoption {

	using SafeMath for uint;
	address[16] public adopters;
	address payable private breeder = 0xEe4549980CfFD3834ddFa97FC043fcc8fFB20CEe;
	address owner = 0x6D93B6918123De7fD09588722e36eA138a01FB6B;

	bool public isActive = true; 

	//Fallback function to allow the contract to accept ether.
	constructor () public payable {
	    //Receive(msg.value);
	    //balance += msg.value;
	}
	
	event donationEvent(
	    address indexed _from,
	    uint _value
	);

	event circuitBreakerEvent(
		address _admin
	);

	/** @dev Marks a pet as adopted with the msg.sender as the new owner.
	  * @dev isActive circuitBreaker must be == true in order for function to execute. 
      * @param petId the id of the pet, a uint between 0 and 15 inclusive.
      * @return petId the id of the successfully adopted pet.
      */
	function adopt (uint petId) public payable returns (uint){
		require(petId >= 0 && petId <= 15); //only going to have 15 pets or fewer for sale.
		adopters[petId] = msg.sender;
		return petId;
	}

	/** @dev Triggers circuit breaker and pauses all adoptions. Only admin can trigger. 
      * @return true bool if the circuitbreaker is successfully executed.
      */
	function disable() public returns (bool) {
		isActive = false;
		//require(msg.sender == owner); //allow only owners to initiate a circuit breaker
		return true;
	}

	/** @dev Re-enables all adoptions. Only admin can trigger. 
      * @return true bool if isActive is now true.
      */
	function enable() public returns (bool) {
		isActive = true;
		//require(msg.sender == owner); //allow only owners to initiate a circuit breaker
		return true;
	}

	/** @dev Gets the status of the isActive state variable. 
      * @return isActive bool
      */
	function getStatus() external view returns (bool)
	{
		return isActive;
	}
	
	/** @dev Allows user to send a bribe with a value specified and a petId of their desired pet.
      * @param amount the value attached to the bribe - anything less than 1 ether is refused.
      * @return string indicated the bribe was received successfully.
      */
	function bribe (uint256 amount) public payable returns  (string memory){
	    //A bribe of 1 ether or less is not considered sufficient.
	    require (amount >= 1 ether);
	    breeder.transfer(amount);
	    //emit bribeEvent(msg.sender, amount);
	    return "Bribe accepted";
	}
	
    /** @dev Allows user to donate a specified amount.
      * @param amount the value attached to the bribe - anything less than 1 ether is refused.
      * @return string indicated the donation was received successfully.
      */
	function donate (uint256 amount) public payable returns  (string memory){
	    //A donation of 1 gwei or less is not considered sufficient.
	    require (amount >= 1000000000);
	    breeder.transfer(amount);
	    return "Thank you so much for your donation!";
	}
	

	/** @dev Retrieve a list of the adopters.
      * @return adopters a list of the new owners of the pets.
      */
	function getAdopters() public view returns (address[16] memory){
		return adopters;
	}

}