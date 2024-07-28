// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract JobHiring {

    address public hr;

    constructor() {
        hr = msg.sender;
    }
    
    modifier onlyHR() {
        require(msg.sender == hr, "Only HR has access");
        _;
    }
    
    struct EmpDetails {
        address empID;
        string jobDescription;
        uint currentCTC;
        uint expectedCTC;
        uint workExperience;
        bool selected;
        uint currentPackage;
    }

    struct PostRequirement {
        string jobDescription;
        uint package;
        uint workExperience;
    }

    mapping(address => EmpDetails) private getDetail;
    mapping(string => PostRequirement) public getRequirement;
    mapping(address => bool) private candidateExists;
    mapping(string => bool) private requirementExists;
    address[] private selectedCandidatesList;
    string[] private jobDescriptions; 

    event NewCandidateAdded(address indexed candidate, string jobDescription, string message);
    event NewRequirementAdded(string jobDescription, string message);
    event CandidateSelected(address indexed candidate, string jobDescription, uint salaryHike);
    event CandidateNotSelected(address indexed candidate, string jobDescription, string message);

    function newCandidate(string memory _jobDescription, uint _currentCTC, uint _expectedCTC, uint _workExperience) public returns (address) {
        require(!candidateExists[msg.sender], "Candidate already exists");
        require(requirementExists[_jobDescription], "Invalid job description");
        
        getDetail[msg.sender] = EmpDetails({
            empID: msg.sender,
            jobDescription: _jobDescription,
            currentCTC: _currentCTC,
            expectedCTC: _expectedCTC,
            workExperience: _workExperience,
            selected: false,
            currentPackage: 0
        });

        candidateExists[msg.sender] = true;
        emit NewCandidateAdded(msg.sender, _jobDescription, "Candidate added successfully");
        return msg.sender;
    }

    function requirement(string memory _jobDescription, uint _package, uint _workExperience) public onlyHR returns (string memory) {
        require(!requirementExists[_jobDescription], "Requirement already exists");
        
        getRequirement[_jobDescription] = PostRequirement({
            jobDescription: _jobDescription,
            package: _package,
            workExperience: _workExperience
        });

        requirementExists[_jobDescription] = true;
        jobDescriptions.push(_jobDescription);

        emit NewRequirementAdded(_jobDescription, "Requirement added successfully");
        return _jobDescription;
    }

    function candidateSelection(address _candidateID, uint salaryHike, uint expectedExperience) public onlyHR returns (bool) {
        require(candidateExists[_candidateID], "Candidate details not found");
        
        EmpDetails storage candidate = getDetail[_candidateID];
        if (candidate.expectedCTC <= salaryHike && candidate.workExperience >= expectedExperience) {
            candidate.selected = true;
            candidate.currentPackage = salaryHike;
            selectedCandidatesList.push(_candidateID);
            emit CandidateSelected(_candidateID, candidate.jobDescription, salaryHike);
            return true;
        } else {
            emit CandidateNotSelected(_candidateID, candidate.jobDescription, "Candidate not selected");
            return false;
        }
    }

    function getCandidate(address _candidateID) public view returns (address, string memory, uint, bool) {
        require(candidateExists[_candidateID], "Candidate details not found");
        EmpDetails storage details = getDetail[_candidateID];
        return (details.empID, details.jobDescription, details.currentPackage, details.selected);
    }

    function getRequirementList() public view returns (string[] memory) {
        return jobDescriptions;
    }

    function listSelectedCandidates() public view returns (address[] memory) {
        return selectedCandidatesList;
    }
}