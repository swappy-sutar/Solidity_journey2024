// SPDX-License-Identifier: MIT

    pragma solidity ^0.8.26;

//Add the following features
//1.Setting and Changing Owner done
//2. Check for invalid address done
//3. Transaction history - from,to,amount,timestamp done

    contract SimpleWallet{

        address public owner;

        constructor(){ 
            owner =  msg.sender;
        }

        modifier onlyOwner(){
            require(msg.sender == owner, "You dont have access");
            _;
        }

        struct Transaction{
            uint id ;
            address from;
            address to;
            uint timeStamp;
            uint amount;
        }
        uint private TransactionCount = 1;
        Transaction[] public transactionHistory;

        function transferToContrct()external payable{ }

        function getContractBalanceInWai()external view returns (uint) {
        return address(this).balance;
        }
        
        function transferToUserViaContract(address payable  _to, uint _wai)external payable  {
            require(address(this).balance >= msg.value,"Insufficient fund");
            _to.transfer(_wai);

            transactionHistory.push(Transaction({
                id: TransactionCount,
                from : msg.sender,
                to: _to,
                timeStamp:block.timestamp,
                amount: _wai

            }));
           TransactionCount++;
        }

        function withdrewFromContract(uint _wai)external payable {
            require(address(this).balance >= msg.value,"Insufficient fund");
            payable (owner).transfer(_wai); 

             transactionHistory.push(Transaction({
                id: TransactionCount,
                from : address(this),
                to: msg.sender,
                timeStamp:block.timestamp,
                amount: _wai

            }));
           TransactionCount++;
        }

        function transferToUserViaMsgValue(address _to) external payable {
            require(address(this).balance >= msg.value,"Insufficient fund");
            payable(_to).transfer(msg.value);

             transactionHistory.push(Transaction({
                id: TransactionCount,
                from : msg.sender,
                to: _to,
                timeStamp:block.timestamp,
                amount: msg.value

            }));
           TransactionCount++;
        }

        function receiveFromUser()external payable{
            require(msg.value > 0,"Insufficient fund");
            payable(owner).transfer(msg.value);
        }

        function getOwnerBalance() external view returns (uint){
            return owner.balance;
        }

        function getTransactionHistory()external view returns (Transaction[] memory) {
            return transactionHistory;
        }

       function changeOwner(address _newOwner) external onlyOwner {
        require(_newOwner != address(0), "Invalid address");
        owner = _newOwner;
    }
    }
