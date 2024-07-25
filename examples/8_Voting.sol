// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract VotingEVM {

    address public electionCommission;

    constructor() {
        electionCommission = msg.sender;
    }

    struct Voter {
        string name;
        uint age;
        uint voterId;
        Gender gender;
        uint voteCandidateId;
        address voterAddress;
    }

    struct Candidate {
        string name;
        string party;
        uint age;
        Gender gender;
        uint candidateId;
        address candidateAddress;
        uint votes;
    }

    address public winner;
    uint private nextVoterId = 1;
    uint private nextCandidateId = 1;
    uint private startTime = 0;
    uint private endTime = 0;
    bool private stopVoting;

    mapping(uint => Voter) private voterDetails;
    mapping(address => bool) private voterExist;
    mapping(uint => Candidate) private candidateDetails;
    mapping(address => bool) private candidateExist;

    address[] private voterList;
    address[] private candidateList;

    enum VotingStatus { NotStarted, InProgress, Ended }
    enum Gender { NotSpecified, Male, Female, Other }

    modifier isVotingOver() {
        require(block.timestamp <= endTime && !stopVoting, "Voting is over");
        _;
    }

    modifier onlyCommissioner() {
        require(msg.sender == electionCommission, "You don't have permission to perform this task");
        _;
    }

    modifier checkAge(uint _age) {
        require(_age >= 18, "Your age is below 18");
        _;
    }

    function registerVoter(string calldata _name, uint _age, Gender _gender) external checkAge(_age) {
        require(!voterExist[msg.sender], "You are already registered");

        voterDetails[nextVoterId] = Voter({
            name: _name,
            age: _age,
            voterId: nextVoterId,
            gender: _gender,
            voteCandidateId: 0,
            voterAddress: msg.sender
        });

        voterExist[msg.sender] = true;
        voterList.push(msg.sender);

        nextVoterId++;
    }

    function getVoterDetails(uint _voterID) public view returns (Voter memory) {
        return voterDetails[_voterID];
    }

    function registerCandidate(string calldata _name, string calldata _party, uint _age, Gender _gender) external checkAge(_age) {
        require(!candidateExist[msg.sender], "Candidate is already registered");
        require(msg.sender != electionCommission, "You are from election Commission so don't have access");

        candidateDetails[nextCandidateId] = Candidate({
            name: _name,
            party: _party,
            age: _age,
            gender: _gender,
            candidateId: nextCandidateId,
            candidateAddress: msg.sender,
            votes: 0
        });

        candidateExist[msg.sender] = true;
        candidateList.push(msg.sender);
        nextCandidateId++;
    }

    function getCandidateList() public view returns (address[] memory) {
        return candidateList;
    }

    function getVoterList() public view returns (address[] memory) {
        return voterList;
    }

    function emergencyStopVoting() public onlyCommissioner {
        stopVoting = true;
    }

    function setVotingPeriod(uint _startTime, uint _endTime) external onlyCommissioner {
        // require(_startTime < 3600,"endTime must be greater than 1 hour");
        startTime = block.timestamp + _startTime;
        endTime = _startTime + _endTime;
    }

    function getVotingStatus() public view returns (string memory) {
        if (stopVoting) {
            return "Voting has been stopped";
        } else if (block.timestamp < startTime) {
            return "Not Started";
        } else if (block.timestamp >= startTime && block.timestamp <= endTime) {
            return "In Progress";
        } else {
            return "Ended";
        }
    }

    function Vote(uint _voterId, uint _candidateId) external isVotingOver{
        require(voterDetails[_voterId].voteCandidateId == 0, "You have already voted");
        require(voterDetails[_voterId].voterAddress == msg.sender, "You are not authorized to vote with this ID");
        require(candidateDetails[_candidateId].candidateAddress != address(0), "Candidate not found");

        voterDetails[_voterId].voteCandidateId = _candidateId;
        candidateDetails[_candidateId].votes++;
    }

    function announceResult() external isVotingOver onlyCommissioner returns (uint,address) {
        uint winningVoteCount = 0;
        address winningCandidateAddress;

        for (uint i = 1; i < nextCandidateId; i++) {
            if (candidateDetails[i].votes > winningVoteCount) {
                winningVoteCount = candidateDetails[i].votes;
                winningCandidateAddress = candidateDetails[i].candidateAddress;
            }
        }

        winner = winningCandidateAddress;
        return (winningVoteCount,winner);
    }

}
