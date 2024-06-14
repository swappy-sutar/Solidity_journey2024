// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "../Design_Patterns/01_Ownable_Pattern.sol";


contract Factory {
    address[] public deployedContracts;

    function createContract() public {
        address newContract = address(new Ownable());
        deployedContracts.push(newContract);
    }

    function getDeployedContracts() public view returns (address[] memory) {
        return deployedContracts;
    }
}
