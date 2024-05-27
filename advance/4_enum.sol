// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EnumExample {
    // Define an enum to represent the different states of an order
    enum OrderStatus {
        Pending,
        Shipped,
        Delivered,
        Cancelled
    }

    // State variable to store the status of an order
    OrderStatus public status;

    // Event to emit when the status changes
    event StatusChanged(OrderStatus newStatus);

    // Constructor to initialize the order status to Pending
    constructor() {
        status = OrderStatus.Pending;
    }

    // Function to set the order status to Shipped
    function shipOrder() public {
        require(status == OrderStatus.Pending, "Order can only be shipped if it is pending");
        status = OrderStatus.Shipped;
        emit StatusChanged(status);
    }

    // Function to set the order status to Delivered
    function deliverOrder() public {
        require(status == OrderStatus.Shipped, "Order can only be delivered if it is shipped");
        status = OrderStatus.Delivered;
        emit StatusChanged(status);
    }

    // Function to cancel the order
    function cancelOrder() public {
        require(status == OrderStatus.Pending, "Order can only be cancelled if it is pending");
        status = OrderStatus.Cancelled;
        emit StatusChanged(status);
    }

    // Function to get the current order status as a string
    function getStatus() public view returns (string memory) {
        if (status == OrderStatus.Pending) {
            return "Pending";
        } else if (status == OrderStatus.Shipped) {
            return "Shipped";
        } else if (status == OrderStatus.Delivered) {
            return "Delivered";
        } else if (status == OrderStatus.Cancelled) {
            return "Cancelled";
        } else {
            return "Unknown";
        }
    }
}
