pragma solidity ^0.5.0;
//import library to prevent integer underflow / overflow.
//import "./SafeMath.sol";

/** @title Adoption contract for Kevin's Pet Shop. */
contract Adoption {

	//using SafeMath for uint;
	address[16] public adopters;
	//address payable private breeder = 0xEe4549980CfFD3834ddFa97FC043fcc8fFB20CEe; //Metamask breeder
	address payable private breeder = 0x14723A09ACff6D2A60DcdF7aA4AFf308FDDC160C; //Remix breeder
	//address owner = 0x6D93B6918123De7fD09588722e36eA138a01FB6B; //Metamask owner
	address owner = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c; //Remix owner
	
	uint256 private constant minimum_donation = 1000000000;
	bool private isActive = true; 

	//Fallback function to allow the contract to accept ether.
	constructor () public payable {
	    //Receive(msg.value);
	    //balance += msg.value;
	}
	
	event bribeEvent (
	    address indexed _from,
	    uint _value,
	    uint _petId
	);
	
	event donationEvent(
	    address indexed _from,
	    uint _value
	);

	event circuitBreakerEvent(
		uint256 _blockNumber
	);
	
	modifier onlyOwner(){
	    require(msg.sender == owner);
	    _;
	}

	/** @dev Marks a pet as adopted with the msg.sender as the new owner.
	  * @dev isActive circuitBreaker must be == true in order for function to execute. 
      * @param petId the id of the pet, a uint between 0 and 15 inclusive.
      * @return petId the id of the successfully adopted pet.
      */
	function adopt (uint petId) public payable returns (uint){
	    require (isActive == true);
		require(petId >= 0 && petId <= 15); //only going to have 15 pets or fewer for sale.
		adopters[petId] = msg.sender;
		return petId;
	}

	/** @dev Triggers circuit breaker and pauses all adoptions. Only admin can trigger. 
      * @return true bool if the circuitbreaker is successfully executed.
      */
	function disable() public onlyOwner returns (bool) {
		isActive = false;
		emit circuitBreakerEvent(block.number);
		return true;
	}

	/** @dev Re-enables all adoptions. Only admin can trigger. 
      * @return true bool if isActive is now true.
      */
	function enable() public onlyOwner returns (bool) {
		isActive = true;
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
      * @param petId the id of the pet, a uint between 0 and 15 inclusive.
      * @param amount the value attached to the bribe - anything less than 1 ether is refused.
      * @return string indicated the bribe was received successfully.
      */
	function bribe (uint256 amount, uint petId) public payable returns  (string memory){
	    //A bribe of 1 ether or less is not considered sufficient.
	    require (amount >= 1 ether);
	    require (petId >= 0 && petId <= 15); //only going to have 15 pets or fewer for sale.
	    breeder.transfer(amount);
	    emit bribeEvent(msg.sender, amount, petId);
	    return "Bribe accepted";
	}
	
    /** @dev Allows user to donate a specified amount.
      * @param amount the value attached to the bribe - anything less than 1 ether is refused.
      * @return string indicated the donation was received successfully.
      */
	function donate (uint256 amount) public payable returns  (string memory){
	    //A donation of 1 gwei or less is not considered sufficient.
	    require (amount >= minimum_donation);
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