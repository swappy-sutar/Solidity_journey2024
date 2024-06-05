// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleEventExample {

    event NewMessage(address indexed from, string message);

    string public lastMessage;

    function setMessage(string memory _message) public {
        lastMessage = _message;
        emit NewMessage(msg.sender, _message);
    }


    uint public value = 10;
    event message(uint _value, string _message);

    function checkEvent(uint val)public returns (uint){
       emit message(val, "this is the value");
       return  value = val ;

    }


}

