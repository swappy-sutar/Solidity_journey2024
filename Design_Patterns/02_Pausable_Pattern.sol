// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

    import "../Design_Patterns/01_Ownable_Pattern.sol";
    
contract Pausable is Ownable {
    bool public paused;

    modifier whenNotPaused() {
        require(!paused, "Contract is paused");
        _;
    }

    modifier whenPaused() {
        require(paused, "Contract is not paused");
        _;
    }

    function pause() public onlyOwner whenNotPaused {
        paused = true;
    }

    function unpause() public onlyOwner whenPaused {
        paused = false;
    }
}
