// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MappingKeyword {

    mapping(string => mapping(uint => address)) private mymapp;

    function setVal(string memory _name, uint _age, address _wallet) public {
        mymapp[_name][_age] = _wallet;
    }

    function getVal(string memory _name, uint _age) public view returns (address) {
        address storedAddress = mymapp[_name][_age];
        require(storedAddress != address(0), "Details not found");
        return storedAddress;
    }
}
