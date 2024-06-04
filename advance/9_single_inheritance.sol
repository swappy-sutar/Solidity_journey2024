// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BaseContract {
    uint public baseValue;

    constructor(uint _baseValue) {
        baseValue = _baseValue;
    }

    function setBaseValue(uint _baseValue) public {
        baseValue = _baseValue;
    }

    function getBaseValue() public view returns (uint) {
        return baseValue;
    }
}

contract DerivedContract is BaseContract {
    uint public derivedValue;

    constructor(uint _baseValue, uint _derivedValue) BaseContract(_baseValue) {
        derivedValue = _derivedValue;
    }

    function setDerivedValue(uint _derivedValue) public {
        derivedValue = _derivedValue;
    }

    function getDerivedValue() public view returns (uint) {
        return derivedValue;
    }
}
