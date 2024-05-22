// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

            //function modifiers
            //Modifiers are code that can be run before and after the function call.
            
            //it's used for 3 reason's 
        //     1. Restriction.
        //     2. Validate Inputs.
        //     3. Guard against reentrancy hack.

    contract modifierKeyword{

        address public owner;
        uint public data = 10;
        bool public locked;

        constructor() {
            owner = msg.sender;
        }

        modifier onlyOwner(){
            require(msg.sender == owner, "YOU ARE NOT OWNER");
            _;
        }

        modifier validateData(address _address){
            require(_address != address(0),"NOT VALID ADDRESS");
            _;
        }

        function changeOwner(address newOwner)public onlyOwner validateData(newOwner){
            owner = newOwner;
        }
         
        modifier noReentrancy(){
            require(!locked,"NO Reentrancy");
            locked = true;
            _;
            locked = false;
        }

        function decrement(uint i) public noReentrancy{
            data -= 1;

            if(data > 1){
            decrement(i - 1);
            }
        }

    }

