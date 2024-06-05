// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

    contract constantKeyword{

        //State variables can be declared as constant or immutable. In both cases, the variables cannot be modified after the contract has been constructed. For constant variables, the value has to be fixed at compile-time, while for immutable, it can still be assigned at construction time.

        //130254 gas
        address public myAddress1 = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

        //104193 gas
        address public constant myAddress2 = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    }