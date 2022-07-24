// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

/* Intro to some types and keywords by implementing a Subcurrency.

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

    // clients can listen for events, this is emitted in the last 
    // line of the send function. This allows us to see who sent,
    // who received and how much was sent, all on the blockchain.
    event Sent(address from, address to, uint amount);

    // constructors code is only executed when the contract is created
    constructor() {
        minter = msg.sender;
    }

    // Sends a certain amount of newly minted coins to the specified addr.
    // Minter can only be called by the contract creator.
    function mint(address reciever, uint amount) public {
        // Will abort all changes if require is not true.
        require(msg.sender == minter);
        balances[reciever] += amount;
    }

    // Errors are used in conjunction with the revert statement.
    // Revert will abort and revert all changes, like require does,
    // but allows you to give an error name and some params to provide
    // more context to the caller.
    error InsufficientBalance(uint requested, uint available);


    // Anyone can use this function. Provided they have sufficient
    // funds!
    function send(address receiver, uint amount) public {
        if (amount > balances[msg.sender])
            revert InsufficientBalance({
                requested : amount,
                available : balances[msg.sender]
            });

        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
}



