// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CalldataExample {
    
    function sumArray(uint256[] calldata inputArray) external pure returns (uint256) {
        uint256 sum = 0;
        for (uint256 i = 0; i < inputArray.length; i++) {
            sum += inputArray[i];
        }
        return sum;
    }
}

