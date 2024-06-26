// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EmployeeDetails {

    address public owner;
    uint public totalEmployeeCount = 0;
    uint[] private employeeIds;

    constructor() {
        owner = msg.sender;
    }

    struct Employee {
        string name;
        uint256 salary;
        uint256 joiningDate;
        string designation;
        uint256 yearOfExperience;
    }

    struct EmployeeInfo {
        uint employeeId;
        string name;
    }

    mapping (uint => Employee) private empMapp;

    event EmployeeAdded(uint employeeId, string name,string message);
    event SalaryHiked(uint employeeId, uint256 oldSalary, uint256 newSalary, uint256 percentage);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    function addDetails(string memory _name,uint256 _salary,string memory _designation,uint256 _yearOfExperience) public onlyOwner {
        
        totalEmployeeCount += 1;
        uint256 employeeId = totalEmployeeCount;
        empMapp[employeeId] = Employee(_name,_salary,block.timestamp,_designation,_yearOfExperience);
        employeeIds.push(employeeId);

        emit EmployeeAdded(employeeId, _name , "Details added successfully");
    }

    function getEmployeeDetails(uint employeeId) public view returns (string memory name,uint256 salary,uint256 joiningDate,string memory designation,uint256 yearOfExperience) {
        Employee storage emp = empMapp[employeeId];
        return (emp.name,emp.salary,emp.joiningDate,emp.designation,emp.yearOfExperience);
    }

    function hikeSalary(uint employeeId, uint256 percentage) public onlyOwner {
        require(percentage > 0, "Percentage must be greater than zero");

        Employee storage emp = empMapp[employeeId];
        uint256 oldSalary = emp.salary;
        uint256 newSalary = oldSalary + (oldSalary * percentage / 100);
        emp.salary = newSalary;

        emit SalaryHiked(employeeId, oldSalary, newSalary, percentage);
    }

    function getAllEmployeeIdsAndNames() public view returns (EmployeeInfo[] memory) {
        EmployeeInfo[] memory employeeInfoArray = new EmployeeInfo[](totalEmployeeCount);

        for (uint i = 0; i < totalEmployeeCount; i++) {
            uint employeeId = employeeIds[i];
            employeeInfoArray[i] = EmployeeInfo(employeeId, empMapp[employeeId].name);
        }

        return employeeInfoArray;
    }
}
//0x5cb0270b71de3a078bb00f6ff9239b86dc208627e80652e60f451bf60367aa9a