// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract WhileLoop {

    uint public num = 0;

    function whileloop() public returns (uint) {
        while (num < 10) {
            num += 1;
        }
        return num;
    }
}
