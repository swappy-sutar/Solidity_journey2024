// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

    contract A{
        string public name = "this is A";

        function getName()public view returns (string memory){
            return name;
        }

    }

    contract B is A{

        constructor(){
            name = "This is B";
        }
    }