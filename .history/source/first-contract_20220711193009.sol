// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

/* Intro to some types and keywords

1. Contract -> Similiar to a class in OOP, persistant data and functions.
               Calling a function on different contract (instance) will perform
               an EVM function call and thus switch the context such that the state
               variables in the callin contract are inaccessible.

2. address -> defines a variable of address type. A "user"/node can have an address,
              so can a contract. The address is the address on the blockchain.

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
}



