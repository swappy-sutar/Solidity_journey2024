// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

    contract  reverseArray{

        function reverseArr(uint256[] memory arr) public pure returns (uint256[] memory){
            
            uint256[] memory newArr = new uint256[](arr.length);
            for (uint256 i = 0; i < arr.length; i++) {
                newArr[i] = arr[arr.length - 1 - i];
            }
            return newArr;
        }
    }
