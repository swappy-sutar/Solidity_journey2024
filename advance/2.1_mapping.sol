// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

    contract tryMapping{

        mapping(address => string) public balances;

    function setName(string memory _name, address _address) public returns (string memory) {
        balances[_address] = _name;
        return balances[_address];
    }
    }