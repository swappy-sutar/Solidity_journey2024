// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

contract assertKeyword{

    bool result ;

    //in assert we can use only condition not message.

    function checkoverflow(uint256 num1, uint num2)public returns(uint256){
        uint256 sum = num1 + num2;
        assert(sum <= 300); 
        result = true;
        return sum;
    }

    function getResult() public view returns (string memory){
        if (result == true) {
            return "number is less than 300";
        } else {
            return "number is greater than 300";
            
        }
    }

}