// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ShopManagementSystem {

    address public Shopkeeper; 

    constructor() {
        Shopkeeper = msg.sender;
    }

    modifier onlyShopkeeper(){
        require(msg.sender == Shopkeeper, "Only shopkeeper can call this function");
        _;
    }
    modifier statusPermission(){
        require(CustomerDetails[msg.sender].status != true, "take Permission from Shopkeeper");
        _;
    }

   enum Category {Electronics,Clothing,HomeAppliances,Books,Toys}

    struct Customer{
        address id;
        string name;
        uint mobileNum;
        string email;
        uint registrationDate;
        bool status;
    }
    struct product{
        uint productId;
        string productName;
        string productDescription;
        uint price;
        uint quantityInStock;
        Category categoryId;
    }
    product[] public productList;

    mapping (address=> Customer) private CustomerDetails;
    mapping (address=> bool) private CustomerExists;
    mapping (string => product)private ProductDetails;
    mapping (string => bool) private ProductExists;
    
    function registerCustomer(string memory _name, uint _mobileNum, string memory _email)external{
        require(CustomerExists[msg.sender] != true, "you're already registered");
        CustomerDetails[msg.sender] = Customer({
            id : msg.sender,
            name: _name,
            mobileNum : _mobileNum,
            email : _email,
            registrationDate : block.timestamp,
            status: false
        });
        CustomerExists[msg.sender] = true;
    }

    function updateCustomer(string memory _name,uint _mobileNum, string memory _email)external {
       require( CustomerExists[msg.sender] != true, "You are not registered");
        CustomerDetails[msg.sender].name = _name;
        CustomerDetails[msg.sender].mobileNum = _mobileNum;
        CustomerDetails[msg.sender].email = _email;
    }

    function deleteCustomer(address _customeraddr)external onlyShopkeeper {
        require(CustomerExists[_customeraddr], "Customer does not exist");
        delete CustomerDetails[_customeraddr];
        delete CustomerExists[_customeraddr];
    }

    function getCustomerDetails(address _customeraddr)external view onlyShopkeeper returns(address id,string memory name,uint mobileNum,string memory email,uint registrationDate,bool status){
        Customer storage details = CustomerDetails[_customeraddr];
        return (details.id,details.name,details.mobileNum,details.email,details.registrationDate,details.status);
    }



}
