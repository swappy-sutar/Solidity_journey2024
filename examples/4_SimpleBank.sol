// SPDX-License-Identifier: MIT
// Data Structures

//     Write a contract called SimpleBank that keeps track of user balances. 
//     Implement the following functions:
//     deposit() payable: Allows a user to deposit Ether.
//     withdraw(uint256 _amount): Allows a user to withdraw Ether.
//     getBalance() view returns (uint256): Returns the user's balance.

pragma solidity 0.8.0;

    contract SimpleBank {

        struct newAccount{
            string name;
            uint dob;
            string sex;
            string location; 
        }

    mapping(address => newAccount) private accounts;
    mapping(address => uint256) private balances;
    mapping(address => bool) private accountExists;

   event withdrawMsg(uint , string);

   function createNewAccount(string memory _name, uint _dob, string memory _sex, string memory _location)public {
        require(!accountExists[msg.sender], "Already you have Account");
        accounts[msg.sender] = newAccount({
            name: _name,
            dob:_dob,
            sex:_sex,
            location:_location
        });
        accountExists[msg.sender] = true;
   }

   function getAccountDetails(address _address)public view returns (string memory , uint , string  memory, string memory) {
        require(accountExists[_address], "account not found");
        newAccount memory Account = accounts[_address];
        return (Account.name, Account.dob, Account.sex, Account.location);
   }

   function BankBalance()public view returns (uint){
        return address(this).balance;
   }

    function getBalance(address _accountAddress)public view returns(uint){
        require(accountExists[msg.sender] == true, "account not found");
        return balances[_accountAddress];
   }

   function deposit()public payable{
        require(msg.value > 0, "Deposit amount must be greater than zero");
        require(accountExists[msg.sender] == true, "you do not have account, Please create account");
        balances[msg.sender] += msg.value;
        accountExists[msg.sender] = true;
    }

    function withdraw(uint256 _amount) public {
        require(_amount <= balances[msg.sender], "Insufficient balance");
        require(_amount > 0, "Withdrawal amount must be greater than zero"); 
        balances[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount); //amount send form of Wei 1000000000000000000
    }
     
}