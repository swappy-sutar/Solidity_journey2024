// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StructKeyword {
    struct Student {
        string name;
        uint class; 
        uint age;
    }

    mapping (uint => Student) public stuMapp;

    function addCollageDetails(uint prn_no, string memory _name, uint _class, uint _age) public {
        stuMapp[prn_no] = Student(_name, _class, _age);
    }

    function updateCollageDetails(uint prn_no, string memory _name, uint _class, uint _age) public {
        // Check if the student exists before updating
        require(bytes(stuMapp[prn_no].name).length != 0, "Student does not exist");

        // Update student details

        stuMapp[prn_no].name = _name;
        stuMapp[prn_no].class = _class;
        stuMapp[prn_no].age = _age;
    }

    function deleteDeatails(uint _index) public {
        delete stuMapp[_index];
    }
}
