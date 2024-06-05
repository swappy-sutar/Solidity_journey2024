// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ForLoop {

    uint[]  data;

    function loop() public returns (uint[] memory) {
        // delete data;

        for (uint i = 0; i < 10; i++) {
            data.push(i);
        }

        return data;
    }
}
