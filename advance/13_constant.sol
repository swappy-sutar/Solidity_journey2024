// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

    contract constantKeyword {
        address public constant owner = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
        uint public constant val = 20;
        uint public constant val1 ;  //Uninitialized "constant" variable.

    }