// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract difficulty {

        // Using block.difficulty to generate a pseudo-random number
    function random() public view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));
    }
}
