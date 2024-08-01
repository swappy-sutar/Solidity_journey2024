// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ShopManagementSystem {

    address public shopkeeper;

    constructor() {
        shopkeeper = msg.sender;
    }

    struct Customer {
        string name;
        uint256 mobileNum;
        string email;
        uint256 registrationDate;
        bool status;
    }

    struct Product {
        string name;
        string description;
        uint256 price;
        uint256 quantityInStock;
        ProductCategory category;
    }

    struct CartItem {
        uint256 productId;
        uint256 quantity;
    }

    struct Cart {
        CartItem[] items;
        uint256 totalPrice;
    }

    struct Bill {
        uint256 number;
        CartItem[] items;
        uint256 amount;
        bool isPaid;
    }

    mapping(uint256 => Product) private products;
    mapping(string => uint256) private productNames; // Mapping from product names to IDs
    mapping(uint256 => bool) private productExists;
    mapping(address => Customer) private customers;
    mapping(address => bool) private customerExists;
    mapping(address => Cart) private carts;
    mapping(address => mapping(uint256 => Bill)) private bills;
    mapping(address => uint256[]) private customerBillNumbers;

    uint256 private productIdCount = 1;
    uint256 private billNum = 1;

    event ProductAdded(uint256 indexed productId, string name);
    event ProductUpdated(uint256 indexed productId, string name);
    event ProductDeleted(uint256 indexed productId);
    event CustomerRegistered(address indexed customer);
    event CustomerUpdated(address indexed customer);
    event CustomerDeleted(address indexed customer);
    event BillCreated(uint256 indexed billNumber, address indexed customer, uint256 amount);
    event BillPaid(uint256 indexed billNumber, address indexed customer, uint256 amount);

    enum ProductCategory { Grocery, Electronics, Clothing, HomeAppliances, Books, Toys }

    modifier onlyShopkeeper() {
        require(msg.sender == shopkeeper, "Only shopkeeper can call this function");
        _;
    }

    modifier statusPermission() {
        require(customers[msg.sender].status != true, "Permission required from Shopkeeper");
        _;
    }

    function registerCustomer(string memory _name, uint256 _mobileNum, string memory _email) external {
        require(!customerExists[msg.sender], "You're already registered");
        customers[msg.sender] = Customer({
            name: _name,
            mobileNum: _mobileNum,
            email: _email,
            registrationDate: block.timestamp,
            status: false
        });
        customerExists[msg.sender] = true;
        emit CustomerRegistered(msg.sender);
    }

    function updateCustomer(string memory _name, uint256 _mobileNum, string memory _email, bool updateName, bool updateMobileNum, bool updateEmail) statusPermission() external {
        require(customerExists[msg.sender], "Customer does not exist");
        Customer storage customer = customers[msg.sender];
        if (updateName) {
            customer.name = _name;
        }
        if (updateMobileNum) {
            customer.mobileNum = _mobileNum;
        }
        if (updateEmail) {
            customer.email = _email;
        }
        emit CustomerUpdated(msg.sender);
    }

    function deleteCustomer(address _customerAddr) external onlyShopkeeper {
        require(customerExists[_customerAddr], "Customer does not exist");
        delete customers[_customerAddr];
        delete customerExists[_customerAddr];
        emit CustomerDeleted(_customerAddr);
    }

    function getCustomerDetails(address _customerAddr) external view onlyShopkeeper returns (string memory name, uint256 mobileNum, string memory email, uint256 registrationDate, bool status) {
        Customer storage customer = customers[_customerAddr];
        return (customer.name, customer.mobileNum, customer.email, customer.registrationDate, customer.status);
    }

    function addProduct(string memory _name, string memory _description, uint256 _price, uint256 _quantity, ProductCategory _category) external onlyShopkeeper {
        uint256 existingProductId = productNames[_name];
        require(existingProductId == 0 || (productExists[existingProductId] && products[existingProductId].price == _price), "Product already exists with different price");
        if (existingProductId == 0) {
            products[productIdCount] = Product({
                name: _name,
                description: _description,
                price: _price,
                quantityInStock: _quantity,
                category: _category
            });
            productExists[productIdCount] = true;
            productNames[_name] = productIdCount;
            emit ProductAdded(productIdCount, _name);
            productIdCount++;
        }
    }

    function updateProduct(uint256 _productId, string memory _name, string memory _description, uint256 _price, uint256 _quantity, ProductCategory _category, bool updateName, bool updateDescription, bool updatePrice, bool updateQuantity, bool updateCategory) external onlyShopkeeper {
        require(productExists[_productId], "Product does not exist");
        Product storage product = products[_productId];
        if (updateName) {
            productNames[product.name] = 0; // Remove old name mapping
            product.name = _name;
            productNames[_name] = _productId; // Update new name mapping
        }
        if (updateDescription) {
            product.description = _description;
        }
        if (updatePrice) {
            product.price = _price;
        }
        if (updateQuantity) {
            product.quantityInStock = _quantity;
        }
        if (updateCategory) {
            product.category = _category;
        }
        emit ProductUpdated(_productId, product.name);
    }

    function deleteProduct(uint256 _productId) external onlyShopkeeper {
        require(productExists[_productId], "Product does not exist");
        delete productNames[products[_productId].name]; // Remove name mapping
        delete products[_productId];
        delete productExists[_productId];
        emit ProductDeleted(_productId);
    }

    function getProduct(uint256 _productId) external view returns (string memory name, string memory description, uint256 price, uint256 quantityInStock, ProductCategory category) {
        require(productExists[_productId], "Product does not exist");
        Product storage product = products[_productId];
        return (product.name, product.description, product.price, product.quantityInStock, product.category);
    }

    function getProductPrice(uint256 _productId) public view returns (uint256) {
        require(productExists[_productId], "Product does not exist");
        return products[_productId].price;
    }

    function addItemToCart(uint256 _productId, uint256 _quantity) external returns (uint256) {
        require(productExists[_productId], "Product does not exist");
        Product storage product = products[_productId];
        require(product.quantityInStock >= _quantity, "Not enough stock");

        Cart storage cart = carts[msg.sender];
        bool found = false;
        for (uint256 i = 0; i < cart.items.length; i++) {
            if (cart.items[i].productId == _productId) {
                cart.items[i].quantity += _quantity;
                found = true;
                break;
            }
        }
        if (!found) {
            cart.items.push(CartItem({
                productId: _productId,
                quantity: _quantity
            }));
        }
        cart.totalPrice += getProductPrice(_productId) * _quantity;
        product.quantityInStock -= _quantity;
        return cart.totalPrice;
    }

    function getCart() external view returns (Cart memory) {
        return carts[msg.sender];
    }

    function createBill() external returns (uint256) {
        require(customerExists[msg.sender], "Customer does not exist");
        Cart storage cart = carts[msg.sender];
        require(cart.items.length > 0, "Cart is empty");

        uint256 billNumber = billNum++;
        Bill storage bill = bills[msg.sender][billNumber];
        bill.number = billNumber;
        bill.amount = cart.totalPrice;
        bill.isPaid = false;

        for (uint256 i = 0; i < cart.items.length; i++) {
            bill.items.push(cart.items[i]);
        }

        customerBillNumbers[msg.sender].push(billNumber);
        emit BillCreated(billNumber, msg.sender, cart.totalPrice);
        return billNumber;
    }

    function buy(uint256 _billNumber) external payable {
        Bill storage bill = bills[msg.sender][_billNumber];
        require(!bill.isPaid, "Bill is already paid");
        require(msg.value == bill.amount, "Amount mismatch");
        require(customerExists[msg.sender], "Customer does not exist");
        
        bill.isPaid = true;
        (bool success, ) = payable(shopkeeper).call{value: msg.value}("");
        require(success, "Transfer failed");

        emit BillPaid(_billNumber, msg.sender, msg.value);
    }

    function getCustomerBills() external view returns (Bill[] memory) {
        uint256[] storage billNumbers = customerBillNumbers[msg.sender];
        Bill[] memory billsList = new Bill[](billNumbers.length);
        for (uint256 i = 0; i < billNumbers.length; i++) {
            billsList[i] = bills[msg.sender][billNumbers[i]];
        }
        return billsList;
    }

    function changePermissionStatus(address _customer, bool _status) external onlyShopkeeper returns (bool) {
        
        customers[_customer].status = _status;
        return _status;
    }

    receive() external payable {}
}
