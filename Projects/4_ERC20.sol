// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC20 {
   
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 value) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 value) external returns (bool);
    function transferFrom(address from, address to, uint256 value) external returns (bool);
}

 contract SWAPTOKEN is IERC20{

    uint public totalSupply ;
    address public Owner;
    uint public decimals = 18 ;

    mapping (address => uint) public BalanceOfUser;
    mapping (address=> mapping (address => uint)) public allowedToken;

    constructor(uint _totalSupply){
        Owner = msg.sender;
        totalSupply = _totalSupply * 10 ** decimals ;
        BalanceOfUser[msg.sender] = _totalSupply ;
    }

    function balanceOf(address account)public view returns (uint256){
        return BalanceOfUser[account];
    }

    function transfer(address to,uint value)external returns (bool){
        require(to != address(0),"Invalid Address");
        require(BalanceOfUser[msg.sender] >= value,"Insufficient Balance");
        BalanceOfUser[msg.sender] -= value;
        BalanceOfUser[to] += value;
        return true;
    }

    function approve(address spender, uint256 value) external returns (bool){
        require(spender != address(0),"Invalid Address");
        require(BalanceOfUser[msg.sender] >= value,"insufficient Balance");

        allowedToken[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);

        return true;
    }

    function allowance(address owner, address spender) external view returns (uint256){
        return allowedToken[owner][spender];
    }

    function transferFrom(address from, address to, uint256 value) external returns (bool){
        require(from != address(0),"Invalid Address");
        require(to != address(0),"Invalid Address");
        require(allowedToken[from][to] >= value,"your Transfer limit is over");

        allowedToken[from][to] -= value; 
        BalanceOfUser[from] -= value;
        BalanceOfUser[to] += value;
        emit Transfer(from, to, value);
        return true; 
    }


}