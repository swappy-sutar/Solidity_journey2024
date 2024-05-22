// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

    contract x {

        string public name;

            constructor(string memory _name) {
                name = _name;
            }
    }

    contract y{
        string public text;

        constructor(string memory _text) {
            text = _text;
        }
    }

     // There are 2 ways to initialise parameters contract with parameters.

     contract b is x("swap"), y("welocome to solidity"){

     }

     contract c is x,y{
        // Pass the parameter here in the constructor.
        // Similar to function modifiers

        constructor(string memory _name, string memory _text) x(_name) y(_text) {}
     }

      // Parameter constructors are always called in the order of inheritance.
        // Regardless of the order of parent  contracts listed in the or
        // Constructor of child contract

        // Order of constructor called:
        // 1. x
        // 2. y
        // 3. d

      contract D is x , y{
        constructor(string memory _name, string memory _text) x(_name) y(_text) {}

      }