## Overview

This smart contract application is an extension of the Truffle petshop tutorial. I have added additional features and extended the capability of the original program with an eye towards incorporating typical smart contract best practices and robust design patterns. 

### How to Run
To run the program, you can use a locally running blockchain on Ganache. In your first terminal window, use command npm run dev to start the web interface. In a second terminal window you can run the commands "truffle develop" and then simply "migrate." I used localhost 127.0.0.1:9545. My application uses hard-coded Ethereum testnet addresses, which you can change to addresses running locally on your machine should you prefer. 

### LocalHost/Web Interface Functionality
The web interface allows you to select a dog to adopt and upon submitting a successful transaction the dog will be marked as adopted. The web interface displays the user's Ethereum address of the current Metamask wallet and the balance of that address. Users are now able to donate a custom amount to the breeder and a transaction will be proprosed with metamask. If a user does not specify an amount the default donation amount is 1 eth. The owner has the ability to pause and restart the adoption functionality (dogs that have already been adopted are not impacted). If a user that is not the owner attempts to hit the circuit breaker an error will be thrown and the contract will continue functioning as usual. 

### Interacting with the Smart Contract Through Remix
There are additional features that I have implemented and tested in remix but are not accessible through the web interface. I have demoed these features in the video. As there are some subtle changes with regards to the ethereum addresses in the contract and the import statements, please refer to the Adoption_FOR_REMIX.sol file in the top level of the project directory. You can copy and paste it directly into remix and interact with the contract there. 