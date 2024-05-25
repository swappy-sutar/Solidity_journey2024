// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MappingKeyword {
    mapping(uint => address) private myMapp;

    function getVal(uint _index) public view returns (address) {
        return myMapp[_index];
    }

    function setVal(uint _index, address _addr) public {
        myMapp[_index] = _addr;
    }

    function removeMappi(uint _index) public returns (string memory, address) {
        address value = myMapp[_index];
        require(value != address(0), "Index number not found");
        delete myMapp[_index];
        return ("Deleted successfully", value);
    }
}
