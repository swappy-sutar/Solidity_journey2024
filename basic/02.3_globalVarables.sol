// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

    contract GlobalVariables{

        address public owner ;
        uint public blockNum;
        address public blockHash;
        uint public difficulty;
        uint public timestamp;
        uint public value;
        uint public nowOn;
        address public origin;
        uint256 public gasprice;
        bytes public callData;
        bytes4 public FirstFour;



        constructor(){
            owner = msg.sender;
            blockHash = block.coinbase;
            blockNum = block.number;
            timestamp = block.timestamp;
            origin = tx.origin;
            gasprice = tx.gasprice;
            callData = msg.data;
            FirstFour = msg.sig;
            // value = msg.value;
            // nowOn = now; 


        }

        function diff()public returns (uint) {
            difficulty = block.difficulty;
            return (difficulty);
        }


    }