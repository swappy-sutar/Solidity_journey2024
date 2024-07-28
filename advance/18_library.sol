// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

    library MathLibrary{
        function add(uint a ,uint b) internal pure returns (uint) {
            return a+b;
        }
        function sub(uint a ,uint b) internal pure returns (uint) {
            return a-b;
        }
        function mul(uint a ,uint b) internal pure returns (uint) {
            return a*b;
        }
        function div(uint a ,uint b) internal pure returns (uint) {
            return a/b;
        }
    }


    contract testLibrary{

        function testAdd(uint x,uint y)external pure returns (uint, uint ,uint,uint) {
            return (MathLibrary.add(x,y),MathLibrary.sub(x,y),MathLibrary.mul(x,y),MathLibrary.div(x,y));
        }
    }