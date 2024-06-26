//SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.0;

    contract wallet{
        string public name = "wallet";
        uint num;
         
        function setVal(uint _num)public {
            num = _num;
        }

        function getVal()public view returns(uint){
            return num;
        }

        function sentEthContract()public payable{}

        function contractBalance() public view returns(uint) {
            return address(this).balance;
        }

        function sendETHUser(address _to)public payable{
            payable(_to).transfer(msg.value);
        }
            
        function accountBalance(address _address)public view returns(uint){
            return _address.balance;
        }
    }

    // 0x8c230cceb53d4361b9bd1f66287391230bfcee38