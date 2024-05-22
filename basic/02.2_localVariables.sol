// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

    contract localVariables{

        uint public myNum; 

        function local() public returns (uint){
            uint num1 = 333; //local variables
            myNum = num1;
            return myNum;
        }
    }