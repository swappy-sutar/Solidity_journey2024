// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VariablesExample {
   
    string public name;  // State variables
    uint256 public age;
    uint256 public blockNum;

    address public owner = msg.sender;

    constructor() {
        name = "Alice";
        age = 30;
        blockNum = block.number;
    }

    function setData(string memory _name, uint256 _age) public {
        name = _name;
        age = _age;
        blockNum = block.number; 

        // Emit event for transparency
        emit DataChanged(blockNum, name, age);
    }

    // Event to log data changes
    event DataChanged(uint256 blockNumber, string name, uint256 age);
}
