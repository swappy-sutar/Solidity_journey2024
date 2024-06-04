// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EmployeeDetails {
    uint public totalEmployee = 0;

    struct Employee {
        string name;
        uint256 salary;
        uint256 joiningDate;
        string designation;
        uint256 yearOfExperience;
    }

    mapping (uint => Employee) private empMapp;

    event EmployeeAdded(uint employeeId, string name);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function addDetails(string memory _name,uint256 _salary,string memory _designation,uint256 _yearOfExperience) public onlyOwner {
        
        totalEmployee += 1;
        uint256 employeeId = totalEmployee;
        empMapp[employeeId] = Employee(_name,_salary,block.timestamp,_designation,_yearOfExperience);
        emit EmployeeAdded(employeeId, _name);
    }

    function getEmployeeDetails(uint employeeId) public view returns (string memory name,uint256 salary,uint256 joiningDate,string memory designation,uint256 yearOfExperience) {

        Employee storage emp = empMapp[employeeId];
        return (emp.name,emp.salary,emp.joiningDate,emp.designation,emp.yearOfExperience);
    }
}
