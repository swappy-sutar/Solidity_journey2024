// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Q.Simple Storage.

// Create a contract called SimpleStorage that allows users to store and retrieve an unsigned integer. Implement the following functions:
// store(uint256 _number): Stores the given number.
// retrieve() view returns (uint256): Returns the stored number.

contract SimpleStorage  {
    uint private number;

    function store(uint256 _number) public  {
        number = _number;
    }

    function retrive() public view returns (uint) {
        return number;
    }
}