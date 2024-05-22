// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract WhileLoop {

    uint8 j = 0;
    uint256[] data;

    function whileloop() public returns (uint256[] memory) {
       do {
        j++;
        data.push(j);
       } 
       while(j < 10);
       
    return data;
    }

    
}
