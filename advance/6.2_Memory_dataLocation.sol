// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Memory: Temporary storage that is erased between external function calls.

contract MemoryExample {

    function doubleArray(uint256[] memory inputArray) public pure returns (uint256[] memory) {
        uint256[] memory resultArray = new uint256[](inputArray.length);
        for (uint256 i = 0; i < inputArray.length; i++) {
            resultArray[i] = inputArray[i] * 2; 
        }
        return resultArray; 
    }

    // Function to concatenate two strings
    function concatenateStrings(string memory str1, string memory str2) public pure returns (string memory) {
        return string(abi.encodePacked(str1, str2));
    }
}
