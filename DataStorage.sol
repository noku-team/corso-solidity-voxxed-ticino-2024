// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DataStorage {
    uint private data;
    event DataSet(address setter, uint256 data);

    constructor() { }

    function setData(uint _data) public {
        data = _data;
        emit DataSet(msg.sender, data);
    }

    function getData() public view returns (uint) {
        return data;
    }
}