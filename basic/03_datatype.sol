// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DataTypesExample {
    // Boolean
    bool public isReady = true;

    // Integer Types
    uint256 public balance = 1000;
    int256 public count = -10;

    // Address
    address public owner =msg.sender;

    // String
    string public message = "Hello, world!";

    // Static Array
    uint256[3] public staticArray = [1, 2, 3];

    // Dynamic Array
    uint256[] public dynamicArray;

    // Mapping
    mapping(address => uint256) public balances;

    // Struct
    struct Person {
        string name;
        uint256 age;
    }
    Person public myPerson;

    // Enum
    enum State { Created, Locked, Inactive }
    State public currentState = State.Created;

    // Bytes
    bytes32 public hash = keccak256(abi.encodePacked("Hello"));

    constructor() {
        // Initialize dynamicArray
        dynamicArray.push(4);
        dynamicArray.push(5);
        dynamicArray.push(6);

        // Initialize mapping
        balances[owner] = 10000;

        // Initialize struct
        myPerson.name = "Alice";
        myPerson.age = 30;
    }
}
