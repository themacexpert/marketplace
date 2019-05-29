pragma solidity ^0.5.0;
contract Adoption {

	address[16] private adopters;
	address payable private breeder = 0xEe4549980CfFD3834ddFa97FC043fcc8fFB20CEe;
	address owner = 0x6D93B6918123De7fD09588722e36eA138a01FB6B;

	bool public isActive = true; 
	uint8 public num = 1;

	//Fallback function to allow the contract to accept ether.
	constructor () public payable {
	    //Receive(msg.value);
	    //balance += msg.value;
	}
	
	event bribeEvent (
	    address indexed _from,
	    uint _value
	);
	
	event donationEvent(
	    address indexed _from,
	    uint _value
	);

	event circuitBreakerEvent(
		address _admin
	);

	//Adopt a pet
	function adopt (uint petId) public payable returns (uint){
		require(petId >= 0 && petId <= 15); //only going to have 15 pets or fewer for sale.
		adopters[petId] = msg.sender;
		return petId;
	}

	//Mark disabled (function for circuit breaker)
	function markDisabled (uint petId) public returns (uint){
		require(petId >= 0 && petId <= 15); //only going to have 15 pets or fewer for sale.
		adopters[petId] = 0x0000000000000000000000000000000000000001;
		return petId;
	}

	//Admin Only Function - Circuit Breaker
	function disable() private returns (bool) {
		isActive = false;
		//require(msg.sender == owner); //allow only owners to initiate a circuit breaker
		return true;
	}

	function getStatus() external view returns (bool)
	{
		return isActive;
	}

	//Admin Only Function - Circuit Breaker
	function circuitBreak(uint petId) public payable returns (uint) {
		//require(msg.sender == owner); //allow only owners to initiate a circuit breaker
		return petId;
	}
	
	//Bribe the breeder to give you the dog you really want
	function bribe (uint256 amount) public payable returns  (string memory){
	    //A bribe of 1 ether or less is not considered sufficient.
	    require (amount >= 1 ether);
	    breeder.transfer(amount);
	    emit bribeEvent(msg.sender, amount);
	    return "Bribe accepted";
	}
	
    //Make a tax deductible donation to the shelter. Note, no goods or services will be provided in exchange for the donation.
	function donate (uint256 amount) public payable returns  (string memory){
	    //A donation of 1 gwei or less is not considered sufficient.
	    require (amount >= 1000000000);
	    breeder.transfer(amount);
	    return "Thank you so much for your donation!";
	}
	

	//Retrieve a list of the adopters.
	//View keyword in the contract means that the function will not modify the state of the contract.
	function getAdopters() public view returns (address[16] memory){
		return adopters;
	}

}