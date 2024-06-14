// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../Design_Patterns/01_Ownable_Pattern.sol";

contract CircuitBreaker is Ownable {
    
    bool public stopped = false;

    modifier stopInEmergency() {
        require(!stopped, "Emergency stop activated");
        _;
    }

    modifier onlyInEmergency() {
        require(stopped, "Not in emergency");
        _;
    }

    function toggleEmergencyStop() external onlyOwner {
        stopped = !stopped;
    }

    function withdraw() external stopInEmergency {
        // Function implementation
    }
}
