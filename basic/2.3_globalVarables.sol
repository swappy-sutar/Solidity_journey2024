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

// blockhash(uint blockNumber) returns (bytes32): hash of the given block when blocknumber is one of the 256 most recent blocks; otherwise returns zero

// blobhash(uint index) returns (bytes32): versioned hash of the index-th blob associated with the current transaction. A versioned hash consists of a single byte representing the version (currently 0x01), followed by the last 31 bytes of the SHA256 hash of the KZG commitment (EIP-4844).

// block.basefee (uint): current block’s base fee (EIP-3198 and EIP-1559)

// block.blobbasefee (uint): current block’s blob base fee (EIP-7516 and EIP-4844)

// block.chainid (uint): current chain id

// block.coinbase (address payable): current block miner’s address

// block.difficulty (uint): current block difficulty (EVM < Paris). For other EVM versions it behaves as a deprecated alias for block.prevrandao (EIP-4399 )

// block.gaslimit (uint): current block gaslimit

// block.number (uint): current block number

// block.prevrandao (uint): random number provided by the beacon chain (EVM >= Paris)

// block.timestamp (uint): current block timestamp as seconds since unix epoch

// gasleft() returns (uint256): remaining gas

// msg.data (bytes calldata): complete calldata

// msg.sender (address): sender of the message (current call)

// msg.sig (bytes4): first four bytes of the calldata (i.e. function identifier)

// msg.value (uint): number of wei sent with the message

// tx.gasprice (uint): gas price of the transaction

// tx.origin (address): sender of the transaction (full call chain)