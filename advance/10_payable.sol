// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PayableKeyword {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    // Function to accept ether deposits
    function deposit() public payable {}

    // Function to withdraw a specified amount to the owner
      function withdraw() public {
        uint _amount = address(this).balance;
        (bool success, ) = owner.call{value: _amount}("");
        require(success, "Withdrawal failed.");
    }

    // Function to transfer the entire balance to a given address
    function transferFunds(address payable _to) public {
        uint _amount = address(this).balance;
        (bool success, ) = _to.call{value: _amount}("");
        require(success, "Failed to send Ether");
    }
}
