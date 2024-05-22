// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RequireKeyword {

    function checkInput(uint _input) public pure returns (string memory) {
        require(_input > 18, "You are under age");
        return "You are 18+";
    }

     function odd(uint _input) public pure returns (bool) {
        require(_input % 2 != 0, "Input is not an odd number");
        return true;  
    }

    
//--------------------------------------------------------------------------
    address public owner;

    constructor(){
        owner = msg.sender;
    }

    function checkOwner()public view returns (string memory){
        require(owner == msg.sender, "You are not owner");
        return "You are owner";
    }
    
}
