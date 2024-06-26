// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MinMaxRange{

    int public minInt = type(int).min;
    int public maxInt = type(int).max;

    uint public minUint = type(uint).min;
    uint public maxUint = type(uint).max;

}