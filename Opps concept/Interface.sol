// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ISay {
    function greet(string memory _name) external view returns (string memory);
    function setGreeting(string memory _greeting) external returns (string memory);
}

contract Say is ISay {
    string public greetMsg;

    function greet(string memory _name) external view override returns (string memory) {
        return string(abi.encodePacked(greetMsg, ", ", _name));
    }

    function setGreeting(string memory _greeting) external override returns (string memory) {
        greetMsg = _greeting;
        return greetMsg;
    }
}


contract Greet {
    function setMsg(address _SayContractAddr, string memory _msg) external returns ( string memory) {

        string memory set = ISay(_SayContractAddr).setGreeting(_msg);
        return set;
    }

    function setName(address _SayContractAddr, string memory _name) external view returns (string memory) {
        return ISay(_SayContractAddr).greet(_name);
    }
}
