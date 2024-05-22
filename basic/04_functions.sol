// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

    contract functions{

        string public say = "good morning";
        string public massage;
        uint public num ;

        function getVal()public view returns (string memory) {
            return say;
        }

        function setVal(string memory _say)public {
            massage = _say;
        }

        function addition(uint _num1, uint _num2) public returns (uint){
            uint holdVal = _num1 + _num2;
            num = holdVal;
            return num;
        }

    }
    

    