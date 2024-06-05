// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

    contract IFElse{

        uint public constant num = 5;
        string public myStr;

        function checkNum(uint _num)public returns(string memory){
            // if (_num == num) {
            //     myStr = "the both number are same";
            // }else{
            //     myStr = "the both number are not same";
            // }

            //ternary operator
            return _num == num ? myStr = "the both number are same" : myStr = "the both number are not same";
        }
    }