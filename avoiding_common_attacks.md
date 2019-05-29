## Avoding Common Attacks

### Integer Arithmetic Overflow
We learned in the course that integers in solidity will unknowingly wrap around if they become too small or large. This could cause unexpected behavior in the smart contract, particularly in the case that the contract accepts user input as parameters as my contract does. One solution to this is to use the SafeMath library, available from OpenZeppelin. 

### Cautiously Accept User Input
As my smart contract accept user paramters, it is important to validate these fields before proceeding. The solution is to check and sanitize input and to throw an error if it is not acceptable. This is done by using require statements to check that the amount of ether specified in the function is of a valid amount or that the petId passed in is within the valid range.

### Exposed Functions
It is easy to accidentally expose functions to the public that should really be private to the contract. 

