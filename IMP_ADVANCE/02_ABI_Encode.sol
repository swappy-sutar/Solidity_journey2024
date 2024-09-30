// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

interface IERC20 {
    event Transfer(address indexed _from, address indexed _to, uint amount);

    function transfer(address _to, uint amount) external returns (bool);
}

contract Token is IERC20 {
    function transfer(address , uint ) external override returns (bool) {
        bytes memory data = msg.data[4:];

        (address _to, uint256 amount) = abi.decode(data, (address, uint256));

        
        emit Transfer(msg.sender, _to, amount);
        return true;
    }
}

contract ABIEncode {
    function callTokenContractFunction(address _contract, bytes calldata data) external {
        (bool ok,) = _contract.call(data);
        require(ok, "transaction failed");
    }


    function EncodingWithSignature(address to, uint amount) external pure returns (bytes memory) {
        return abi.encodeWithSignature("transfer(address,uint256)", to, amount);
    }

    function EncodingWithSelector(address to, uint amount) external pure returns (bytes memory) {
        return abi.encodeWithSelector(IERC20.transfer.selector, to, amount);
    }

    function encodeCall(address to, uint amount) external pure returns (bytes memory) {
        return abi.encodeCall(IERC20.transfer, (to, amount));
    }
}
 