// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ReceiveEther {
    // Event to log received Ether
    event EtherReceived(address indexed from, uint amount);
    // Event to log sent Ether
    event EtherSent(address indexed to, uint amount, bool success);

    // Fallback function to handle non-existent function calls
    fallback() external payable {
        emit EtherReceived(msg.sender, msg.value);
    }

    // Receive function to handle plain Ether transfers
    receive() external payable {
        emit EtherReceived(msg.sender, msg.value);
    }

    // Function to get the balance of the contract
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    // Function to send ether using call
    function sendEther(address payable _to) public payable  returns (bool) {
        (bool success, ) = _to.call{value: msg.value}("");
        emit EtherSent(_to, msg.value, success);
        return success;
    }
}

    contract sendEther {
    //there are three methods to sendEther.
 
    // 1.transfer
        // Automatically reverts on failure.
        // Forwards a fixed 2300 gas.
        // Simpler to use but less flexible.

        function sentViaTransfer(address payable _to)public payable {
            _to.transfer(msg.value);
        }

    // 2.Send
        // Returns a boolean.
        // Forwards a fixed 2300 gas.
        // Does not revert automatically on failure.

            function sentViaSend(address payable _to)public payable {
            bool sent = _to.send(msg.value);
            require(sent, "transfer failed");
            }

    // 3. call
        // Returns a boolean and data.
        // More flexible (can specify gas and call functions).
        // Recommended for modern Solidity due to EVM gas stipend changes.

        function sentViaCall(address payable _to)public payable {
            (bool sent, bytes memory data) = _to.call{value: msg.value}("");
            require(sent, "call failed");
        }
    
}