// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract A {
    uint public a;

    constructor(uint _a) {
        a = _a;
    }

    function setA(uint _a) public {
        a = _a;
    }

    function getA() public view returns (uint) {
        return a;
    }
}

contract B {
    uint public b;

    constructor(uint _b) {
        b = _b;
    }

    function setB(uint _b) public {
        b = _b;
    }

    function getB() public view returns (uint) {
        return b;
    }
}

contract C is A(1), B(2) {
    uint public c;

    constructor(uint _c) {
        c = _c;
    }

    function setC(uint _c) public {
        c = _c;
    }

    function getC() public view returns (uint) {
        return c;
    }
}
