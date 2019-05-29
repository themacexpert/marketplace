# Overview of Design Patterns Used 

### Restricting Access
Having private state variables to prevent other contracts from accessing this state information. In the case of my contract, the array of adopters is marked as private and so is the address of the breeder.

### Circuit Breaker
This is a one-click button that allows the owner to temporarily suspend all pet adoptions. This will not impact the pets that have already been adopted - their owners will remain the same.