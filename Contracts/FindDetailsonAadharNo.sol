// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MappingDetailsOnAadhaarNum {

    address public owner;
    mapping(uint256 => bool)private aadhaarExists; //it's store the index number is present on not in mapping.

    struct AadhaarDetails {
        string name;
        uint256 dob;
        string sex;
        string addr;
        uint256 pincode;
    }

    mapping(uint256 => AadhaarDetails) private aadhaarDetails;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can add details");
        _;
    }

    function addDetails(uint256 _aadhaarNo,string memory _name,uint256 _dob,string memory _sex,string memory _address,uint256 _pincode) public onlyOwner returns (bool) {
        require(!aadhaarExists[_aadhaarNo], "Aadhaar number already exists");
        aadhaarDetails[_aadhaarNo] = AadhaarDetails(_name, _dob, _sex, _address, _pincode);
        aadhaarExists[_aadhaarNo] = true;
        return true;
    }

    function getDetails(uint256 _aadhaarNo) public view returns (string memory name,uint256 dob,string memory sex,string memory addr,uint256 pincode) {
        AadhaarDetails memory details = aadhaarDetails[_aadhaarNo];
        return (details.name, details.dob, details.sex, details.addr, details.pincode);
    }

    function deleteDetails(uint256 _aadhaarNo) public onlyOwner returns (string memory) {
        require(aadhaarExists[_aadhaarNo], "Aadhaar number does not exist");
        delete aadhaarDetails[_aadhaarNo];
        delete aadhaarExists[_aadhaarNo];
        return "Aadhaar deleted successfully";
    }


}
