// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RevertKeyword {

    function checkOverFlow(uint num1, uint num2) public pure returns (string memory, uint) {
        uint sum = num1 + num2;
        if (sum > 255) {
            revert("Number is greater than 255");
        }
        return ("Sum is between 255", sum);
    }
}
