// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

    contract sendViacall{

       
        function transfer(address payable _to) public  returns (bool) {
            (bool success, ) = _to.call{value: 1 ether}("");
            return success;
        }
        
        receive() external payable {}
        }