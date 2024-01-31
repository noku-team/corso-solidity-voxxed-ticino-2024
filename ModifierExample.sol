// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyContract {
    address public owner;
    uint public creationTime = block.timestamp;

    constructor() {
        owner = msg.sender;
    }

    // Un modifier che consente l'accesso solo all'owner del contratto.
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function.");
        _;
    }

    // Un modifier che consente l'accesso solo se sono passati più di 5 minuti dalla creazione del contratto.
    modifier minTimeElapsed() {
        require(block.timestamp >= creationTime + 5 minutes, "Function called too early.");
        _;
    }

    // Una funzione che può essere chiamata solo dall'owner.
    function ownerFunction() public onlyOwner {
        // Codice della funzione qui
    }

    // Una funzione che può essere chiamata solo dopo 5 minuti dalla creazione del contratto.
    function timeSensitiveFunction() public minTimeElapsed {
        // Codice della funzione qui
    }
}
