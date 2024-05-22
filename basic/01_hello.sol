// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HelloWorld {
    // string public name = "swapnil";
    // uint public age = 23;

    string public name;
    uint public age;

    constructor(string memory _name, uint _age) {
        name = _name;
        age = _age;
    }

    function myData(string memory _name, uint _age) public {
        name = _name;
        age = _age;
    }
}
