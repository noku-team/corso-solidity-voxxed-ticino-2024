// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleDeposit {
    // Mappa per tenere traccia dei depositi per ciascun indirizzo
    mapping(address => uint256) public deposits;

    // Funzione per depositare Ether nel contratto
    function deposit() public payable {
        // Aggiorna la mappa dei depositi aggiungendo l'Ether inviato a quello già depositato dall'indirizzo sender
        deposits[msg.sender] += msg.value;
    }

    // Funzione per controllare il saldo depositato da un indirizzo specifico
    function getDeposit(address depositor) public view returns (uint256) {
        return deposits[depositor];
    }

    // Funzione per ritirare i propri depositi
    function withdraw() public {
        // Memorizza l'ammontare del deposito in una variabile locale
        uint256 amount = deposits[msg.sender];

        // Verifica che ci sia qualcosa da ritirare
        require(amount > 0, "Nessun deposito da ritirare");

        // Azzera il deposito prima di inviare per evitare attacchi di reentrancy
        deposits[msg.sender] = 0;

        // Trasferisce l'Ether all'indirizzo del sender
        payable(msg.sender).transfer(amount);
    }
}


