// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract  concatenateTwoString{

    function concatenate(string memory string1, string memory string2) public pure returns (string memory) {
        return string(abi.encodePacked(string1, string2));
    }
}
