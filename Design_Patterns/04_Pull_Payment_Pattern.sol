// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract PullPayment {
    mapping(address => uint256) public payments;

    function asyncSend(address dest, uint256 amount) internal {
        payments[dest] += amount;
    }

    function withdrawPayments() external {
        uint256 payment = payments[msg.sender];
        require(payment != 0, "No funds to withdraw");

        payments[msg.sender] = 0;
        payable(msg.sender).transfer(payment);
    }
}
