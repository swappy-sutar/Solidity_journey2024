// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

    contract viewInSol{
        uint public num1 = 5;
        uint public num2 = 5;

        // We can only use view keyword to see the state variables data We can't update state variables.

        function getResult() public view returns (uint addition, uint multiplication){
            
            addition = num1 + num2;
            multiplication = num1 * num2;
        }


        // without view keyword.
       function Without_view() public returns (uint addition, uint multiplication){

            num1 += 5;
            num2 += 15;
            
            // here we can change the value of state variables and update state variables.

            addition = num1 + num2;
            multiplication = num1 * num2;
        }
    }