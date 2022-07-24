// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

/* Intro to some types and keywords

1. Contract -> Similiar to a class in OOP, persistant data and functions.
               Calling a function on different contract (instance) will perform
               an EVM function call and thus switch the context such that the state
               variables in the callin contract are inaccessible.

2. address -> defines a variable of address type. 
              The address type is a 160-bit value that
              does not allow any arithmetic operations. 
              It is suitable for storing addresses of contracts, 
              or a hash of the public half of a keypair belonging 
              to external accounts.

3. public -> makes variable accessible from other contracts (like in C#)

*/
contract Coin{

    address public minter;
    // mapping is a type that's kinda like a hash map.
    // here we have a hash map called balances that maps addrs 
    // to uints i.e. a list of accounts and their balances. 
    mapping (address => uint) public balances;

    // clients can listen to events
    event Sent(address from, address to, uint amount);

    // constructors code is only executed when the contract is created
    constructor() {
        minter = msg.sender;
    }

    function mint(address reciever, uint amount) public {
        require(msg.sender == minter);
        balances[reciever] += amount;
    }
}



