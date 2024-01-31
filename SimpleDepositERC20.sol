// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transfer(address recipient, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract ERC20Deposit {
    // Mappa ogni indirizzo all'ammontare depositato
    mapping(address => uint256) public deposits;

    // Referenza all'interfaccia ERC20 del token
    IERC20 public token;

    constructor(address _tokenAddress) {
        token = IERC20(_tokenAddress);
    }

    // Funzione per depositare token ERC20
    function deposit(uint256 _amount) public {
        require(_amount > 0, "Amount must be greater than 0");
        deposits[msg.sender] += _amount;
        require(token.transferFrom(msg.sender, address(this), _amount), "Transfer failed");
    }

    // Funzione per ritirare i propri token
    function withdraw(uint256 _amount) public {
        require(_amount <= deposits[msg.sender], "Insufficient balance");
        deposits[msg.sender] -= _amount;
        require(token.transfer(msg.sender, _amount), "Transfer failed");
    }

    // Funzione per visualizzare il saldo depositato
    function balance() public view returns (uint256) {
        return deposits[msg.sender];
    }
}
