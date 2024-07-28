// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

// abstract contract means contract that cannot be instantiated directly 
// and is used to define common functions that other contracts can inherit. 
// It may include functions without implementations, which must be implemented by derived contracts.
// Abstract contracts are used to create a base blueprint for other contracts.

// in short Restriction for creating new contract using old contract.


    abstract contract Parant {
        address public owner ;
        string public name;
        
        constructor() {
            owner = msg.sender;
            name = "swappy";
        }

        function UnimplementedFun(string memory)external virtual pure returns (string memory);
        function UnimplementedCalculations (uint _num1,uint _num2)external virtual pure returns(uint);
    }

    contract Child is Parant {

        constructor(address _owner){
            owner = _owner;
            name = "Swapnil";
        }

        function UnimplementedFun(string memory)external override pure returns (string memory){
            return "wow";
        } 

        function UnimplementedCalculations (uint x,uint y)external override  pure returns (uint){
            return x + y;
        }

        
    }