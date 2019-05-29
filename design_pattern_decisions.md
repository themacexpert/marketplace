# Overview of Design Patterns Used 

### Restricting Access
Having private state variables to prevent other contracts from accessing this state information. In the case of my contract, the array of adopters is marked as private and so is the address of the breeder.

### Circuit Breaker
This is a one-click button that allows the owner to temporarily suspend all pet adoptions. This will not impact the pets that have already been adopted - their owners will remain the same.

### Function Modifiers
I have used modifiers to ensure appropriate access to the admin features of the account.

### Emitting Events
For relevant changes to the contract state I have set up events and included the pertinent details such as block number, ethereum address, and other details regarding the event.