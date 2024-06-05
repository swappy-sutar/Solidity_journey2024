// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract pureKeyword{

    uint public a = 10;
    uint public b = 20;


    function pure_keyWord()public pure returns (uint product,uint total){

        uint num1 = 5;
        uint num2 = 3;

        product = num1 * num2;
        total = num1 + num2; 

        return (product,total);

    }

}