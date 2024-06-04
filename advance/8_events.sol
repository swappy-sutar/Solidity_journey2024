// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleEventExample {

    event NewMessage(address indexed from, string message);

    string public lastMessage;

    function setMessage(string memory _message) public {
        lastMessage = _message;
        emit NewMessage(msg.sender, _message);
    }
}

