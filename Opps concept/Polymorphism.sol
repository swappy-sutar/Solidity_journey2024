// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

    // Polymorphism in Solidity means that you can have multiple functions with the same name in different contracts, 
    // and these functions can perform different tasks depending on the contract instance that is calling them.

    contract Polymorphism{

        function calculations(uint a, uint b)external pure returns (uint) {
            return a + b;
        }

         function calculations(uint a, uint b,uint c)external pure returns (uint) {
            return a + b + c;
        }

         function calculations(uint a)external pure returns (uint) {
            return a + 10 ;
        }

        function calculations(string memory _name)external pure returns (string memory) {
            return _name;
        }
    }