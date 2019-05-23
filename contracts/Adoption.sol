pragma solidity ^0.5.0;
contract Adoption {

	address[16] public adopters;
	address payable breeder = 0xBec1d24E7aB6e2419c6C777504502De1E147dD16;
	uint priceOfDog = 100000000000000000; 

	//Fallback function to allow the contract to accept ether.
	constructor () public payable {
	    //Receive(msg.value);
	    //balance += msg.value;
	}

	//Adopt a pet
	function adopt (uint petId) public payable returns (uint){
		require(petId >= 0 && petId <= 15); //only going to have 15 pets or fewer for sale.
		//require(msg.value >= priceOfDog); //require the message to 
		adopters[petId] = msg.sender;
		return petId;
	}
	
	//Bribe the breeder to give you the dog you really want
	function bribe (uint amount) public payable returns  (string memory){
	    //require (amount <= msg.value);
	    //A bribe of 1 ether or less is not considered sufficient.
	    require (amount >= 1 ether);
	    breeder.transfer(1000000000000000000);
	    return "Bribe accepted";
	}
	
    //Make a tax deductible donation to the shelter. Note, no goods or services will be provided in exchange for the donation.
	function donate (uint amount) public payable returns  (string memory){
	    //Make sure that the user doesn't try to donate more money than they have.
	    breeder.transfer(amount);
	    return "Thank you so much for your donation!";
	}
	

	//Retrieve a list of the adopters.
	//View keyword in the contract means that the function will not modify the state of the contract.
	function getAdopters() public view returns (address[16] memory){
		return adopters;
	}


}