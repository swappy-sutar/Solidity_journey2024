// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract A {
    uint256 public number;

    function setNumber(uint256 _number) external {
        number = _number;
    }
}

contract B {
    uint256 public number;
    uint public total;

    function setNumber(address _contract, uint256 _num) external {
        bytes memory data = abi.encodeWithSignature("setNumber(uint256)", _num);
        (bool success, ) = _contract.delegatecall(data);
        require(success, "DelegateCall failed");
    }

    function addition (uint256 num1 ,uint num2) external {
      total = num1 + num2;
    }    
}

contract c{
    uint256 public number;
    uint public total;

     function addition(address _contract, uint256 _num1 , uint _num2) external {
        bytes memory data = abi.encodeWithSignature("addition(uint256,uint256)", _num1,_num2);
        (bool success, ) = _contract.delegatecall(data);
        require(success, "DelegateCall failed");
    }

    function subtraction (uint256 num1 ,uint num2) external {
      total = num1 - num2;
    } 


}