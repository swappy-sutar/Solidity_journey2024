// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract structArray {

    uint public difficulty;

    struct myInfo {
        string name;
        uint256 age;
        uint256 phNumber;
    }

    myInfo[] private info;
    uint public count ;  // Start indexing from 1

    function setInfo(string memory _name, uint _age, uint256 _phNumber) public returns (string memory, uint, uint256, uint) {
        myInfo memory Info = myInfo(_name, _age, _phNumber);
        info.push(Info);

        uint currentIndex = count;
        count = count + 1;
        difficulty = block.difficulty;

        return (Info.name, Info.age, Info.phNumber, currentIndex);
    }

    function getInfo(uint index) public view returns (string memory, uint, uint256) {
        require(index > 0 && index <= info.length, "Index out of bounds");
        myInfo storage Info = info[index - 1];
        return (Info.name, Info.age, Info.phNumber);
    }
}
