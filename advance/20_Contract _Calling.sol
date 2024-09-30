// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

    contract Info{
        string public name;

        function setName(string memory _name)public{
            name = _name;
        }
    }

    contract GetViaContract {
        
        function getName(Info _infoAddress,string memory _name) public{
            _infoAddress.setName(_name);
        }

        function getName(Info _infoAddress)public view returns (string memory) {
            return _infoAddress.name();
        }
    }