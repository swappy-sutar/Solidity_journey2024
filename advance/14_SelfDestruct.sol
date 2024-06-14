// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    address payable public owner;
    address payable  public charity;

    constructor(address payable  _charity){
        owner  = payable(msg.sender);
        charity = _charity;
    }

    receive() external payable {}

    function tip()external payable {
        charity.transfer(msg.value);
    }
    function sendETH()public payable  {
        (bool success, ) = charity.call{value: msg.value}("");
        require(success, "Donation failed");
    }

    function donate() external returns(uint){
        (bool success, ) = charity.call{value: address(this).balance}("");
        require(success, "Donation failed");
        return charity.balance;
    }

    
}