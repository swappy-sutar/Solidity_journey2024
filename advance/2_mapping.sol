// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

contract mappingKeyword {
    mapping(address => uint) myMapp;

    event ValueSet(address indexed addr, uint value);
    event ValueRemoved(address indexed addr, uint oldValue);

    function getVal(address _address) public view returns (uint) {
        return myMapp[_address];
    }

    function setVal(uint _index, address _addr) public {
        myMapp[_addr] = _index;
        emit ValueSet(_addr, _index);
    }

    function removeMappi(address _addr) public returns (string memory, uint) {
        uint value = myMapp[_addr];
        require(value != 0, "Address not found");
        delete myMapp[_addr];
        // emit ValueRemoved(_addr, value);
        return ("Deleted successfully", value);
    }
}
