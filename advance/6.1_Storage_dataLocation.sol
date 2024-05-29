// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

// Storage: Persistent storage where data is stored on the blockchain.
    contract StorageExample {

        struct Data {
            uint256 value;
        }

        mapping(address => Data) public dataMapping; 

        function set(uint256 x) public {
            Data storage data = dataMapping[msg.sender]; 
            data.value = x; 
        }

        function get() public view returns (uint256) {
            Data storage data = dataMapping[msg.sender]; 
            return data.value; 
        }
    }

