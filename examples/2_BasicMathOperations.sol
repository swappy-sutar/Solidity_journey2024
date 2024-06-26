// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

// Q.Basic Math Operations

//     Write a contract called BasicMath that performs basic arithmetic operations. 
//     Implement functions for addition, subtraction, multiplication, and division of two numbers.


contract BasicMathOperations {
    
    // Addtion 
    function addtion(uint num1, uint num2) public pure returns (uint){
        uint total = num1 + num2;
        return total;
    }
    
    // subtraction 
    function subtraction(uint num1, uint num2) public pure returns (uint){
        uint total = num1 - num2;
        return total;
    }

    // multiplication 
    function multiplication(uint num1, uint num2) public pure returns (uint){
        uint total = num1 * num2;
        return total;
    }

    // division
    function division(uint num1, uint num2) public pure returns (uint){
        uint total = num1 / num2;
        return total;
    }


}
