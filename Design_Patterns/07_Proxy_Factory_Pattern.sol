// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ProxyFactory {
    address public implementation;

    constructor(address _implementation) {
        implementation = _implementation;
    }

    function createProxy() public returns (address) {
        Proxy proxy = new Proxy();
        proxy.setImplementation(implementation);
        return address(proxy);
    }
}
