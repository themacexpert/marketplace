## Avoiding Common Attacks

### Integer Arithmetic Overflow
We learned in the course that integers in solidity will unknowingly wrap around if they become too small or large. This could cause unexpected behavior in the smart contract, particularly in the case that the contract accepts user input as parameters as my contract does. One solution to this is to use the SafeMath library, available from OpenZeppelin. 

### Cautiously Accept User Input
As my smart contract accept user paramters, it is important to validate these fields before proceeding. The solution is to check and sanitize input and to throw an error if it is not acceptable. This is done by using require statements to check that the amount of ether specified in the function is of a valid amount or that the petId passed in is within the valid range.

### Exposed Functions
It is easy to accidentally expose functions to the public that should really be private to the contract. I have made sure that critical functions like the disable and enable functions are private and only accessible by the owner of the contract. Additionally, state variables like isActive are private. 

### Malicious Administrators
Another possible attack vector we covered in the course was a malicious actor with priviledged access. In general, a good rule of thumb is to limit priviledged access to the least necessary priviledges. In the case of my contract, there is just one administrator account. However, in a more complicated contract, there could be multiple administrators, and it would be important for them to each have their own access levels, and to keep them at the minimum level of admin rights to perform their required functions. e.g. There should never be a shared generic admin account that is passed around.