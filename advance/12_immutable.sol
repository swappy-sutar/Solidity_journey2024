// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;


    contract immutableKeyword{
        address public immutable owner ;
        uint public immutable val;

        constructor(address _owner , uint _val){
            owner = _owner;
            val = _val;
        }

    
    }