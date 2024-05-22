// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

contract mappingKeyword {
    mapping(address => uint) myMapp;

    function getVal(address _address) public view returns (uint) {
        return myMapp[_address];
    }

    function setVal(uint _index, address _addr) public {
        myMapp[_addr] = _index;
    }

    function removeMappi(address _addr) public returns (string memory, uint) {
        uint value = myMapp[_addr];
        require(value != 0, "Address not found");
        delete myMapp[_addr];
        return ("Deleted successfully", value);
    }
}
