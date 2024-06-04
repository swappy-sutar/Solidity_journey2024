// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract A {
    function a1() public pure virtual returns (string memory) {
        return "a is the value";
    }
}

contract B is A {
    function a1() public pure virtual override returns (string memory) {
        return "b is also the value";
    }

    function b1() public pure returns (string memory) {
        return "b1 function in contract B";
    }
}

contract C is A {
    function a1() public pure virtual override returns (string memory) {
        return "c is also the value";
    }

    function c1() public pure returns (string memory) {
        return "c1 function in contract C";
    }
}


contract Test {
    function test() public pure returns (string memory) {
        A a = new A();
        B b = new B();
        C c = new C();

        string memory resultA = a.a1(); // "a is the value"
        string memory resultB = b.a1(); // "b is also the value"
        string memory resultC = c.a1(); // "c is also the value"

        return string(abi.encodePacked(resultA, " | ", resultB, " | ", resultC));
    }
}