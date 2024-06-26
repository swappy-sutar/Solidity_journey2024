// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

    contract Base {

        string private privateVar = "private variable";
        string internal internalVar = "internal variable";
        string public publicVar = "public variable";


        function PrivateFun() private pure returns (string memory){
            return "Private function called";
        }

        function TestPrivateFun() public pure returns (string memory){
            return PrivateFun();
        }

         function internalFun() internal pure returns (string memory){
            return "internal function called";
        }

        function TestinternalFun() public pure returns (string memory){
            return internalFun();
        }

         function publicFun() public pure returns (string memory){
            return "public function called";
        }

         function externalFun() external pure returns (string memory){
            return "external function called";
        }    
    }

    contract Child is Base{

        // function testPrivateFun() external pure returns (string memory){
        //     return PrivateFun();
        //  }
        
        //  function testexternalFun() external pure returns (string memory){
        //     return externalFun();
        //  }
         function testInternalFun() external pure returns (string memory){
            return internalFun();
         }
          function testPublicFun() external pure returns (string memory){
            return publicFun();
         }
    }