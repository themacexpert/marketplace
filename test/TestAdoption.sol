pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Adoption.sol";

contract TestAdoption {
	//The address of the adoption contract to be tested.
	Adoption adoption = Adoption(DeployedAddresses.Adoption());

	//The Id of the pet that will be used for testing.
	uint expectedPetId = 8;

	//The expted owner of adopted pet is this contract.
	address expectedAdopter = address(this);

	bool expectedStatus = true;
	bool expectedStatusAfterDisabled = false;

	//Test the adopt function
	function testUserCanAdoptPet() public {
		uint returnedId = adoption.adopt(expectedPetId);

		Assert.equal(returnedId, expectedPetId, "Adoption of the expected pet should match what is returned.");
	}

	//Testing retrieval of a single pet's owner.
	function testGetAdopterAddressByPetId() public {
		address adopter = adoption.adopters(expectedPetId);

		Assert.equal(adopter,expectedAdopter, "Owner of the expected pet should be this contract");
	}

	//Test retrieval of all pet owners.
	function testGetAdopterAddressByPetIdInArray() public {
		//Store adopters in memory rather than in contract's storage.
		address[16] memory adopters = adoption.getAdopters();

		Assert.equal(adopters[expectedPetId], expectedAdopter, "Owner of the expected pet should be this contract.");
	}

	//Test the getStatus Function - expecting a true boolean
	function testGetStatusFunctionality() public {
		bool returnedStatus = adoption.getStatus();

		Assert.equal(returnedStatus, expectedStatus, "Status returned should be true to indicate active contract.");
	}

	//Test the disable function - expecting a false boolean to be return by getStatus.
	function testGetStatusAfterDisabledFunctionality() public {
		adoption.disable();
		bool returnedStatus = adoption.getStatus();
		Assert.equal(returnedStatus, expectedStatusAfterDisabled, "Status returned should be false to indicate circuit breaker activated.");
	}

	//Test the enable function - expecting a false boolean to be return by getStatus.
	function testGetStatusAfterEnabledFunctionality() public {
		adoption.enable();
		bool returnedStatus = adoption.getStatus();
		Assert.equal(returnedStatus, expectedStatus, "Status returned should be true to indicate circuit breaker deactivated.");
	}

}