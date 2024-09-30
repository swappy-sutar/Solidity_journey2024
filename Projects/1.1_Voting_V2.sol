// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract VotingEVM is Pausable, ReentrancyGuard {
    address public immutable electionCommission;
    uint public constant candidateDeposit = 0.001 ether;

    constructor() {
        electionCommission = msg.sender;
    }

    enum VotingStatus { NotStarted, InProgress, Ended, VotingStopped }
    enum Gender { NotSpecified, Male, Female, Other }

    struct Voter {
        string name;
        uint8 age;
        uint voterId;
        Gender gender;
        uint voteCandidateId;
    }

    struct Candidate {
        string name;
        string party;
        uint8 age;
        Gender gender;
        uint candidateId;
        uint votes;
        uint deposit;
    }

    address public winner;
    uint private nextVoterId = 1;
    uint private nextCandidateId = 1;
    uint private startTime = 0;
    uint private endTime = 0;
    bool private stopVoting;

    mapping(address => Voter) public voterDetails;
    mapping(address => Candidate) public candidateDetails;
    address[] private voterList;
    address[] private candidateList;

    event VoterRegistered(address indexed voterAddress, uint voterId);
    event CandidateRegistered(address indexed candidateAddress, uint candidateId);
    event VotingPeriodSet(uint startTime, uint endTime);
    event VoteSuccessful(address indexed voterAddress, string candidateName);
    event ResultAnnounced(address indexed winner, string name, uint votes);
    event DepositRefunded(address indexed candidate, uint amount);

    modifier votingNotOver() {
        require(block.timestamp <= endTime && !stopVoting, "Voting is over or stopped");
        _;
    }

    modifier onlyCommissioner() {
        require(msg.sender == electionCommission, "Permission denied: Not election commissioner");
        _;
    }

    modifier validAge(uint _age) {
        require(_age >= 18, "Age must be at least 18");
        _;
    }

    receive() external payable {}

    function transferETH(address payable _address, uint256 _amount) external onlyCommissioner {
        require(address(this).balance >= _amount, "Insufficient contract balance");
        (bool success, ) = _address.call{value: _amount}("");
        require(success, "Transfer failed");
    }

    function registerVoter(string calldata _name, uint _age, Gender _gender) external validAge(_age) whenNotPaused {
        require(bytes(_name).length > 0, "Name cannot be empty");
        require(voterDetails[msg.sender].voterId == 0, "Voter already registered");

        voterDetails[msg.sender] = Voter({
            name: _name,
            age: uint8(_age),
            voterId: nextVoterId,
            gender: _gender,
            voteCandidateId: 0
        });

        voterList.push(msg.sender);
        emit VoterRegistered(msg.sender, nextVoterId++);
    }

    function registerCandidate(string calldata _name, string calldata _party, uint _age, Gender _gender) external payable validAge(_age) whenNotPaused {
        require(bytes(_name).length > 0 && bytes(_party).length > 0, "Name and party cannot be empty");
        require(candidateDetails[msg.sender].candidateId == 0, "Candidate already registered");
        require(msg.sender != electionCommission, "Commissioner cannot be a candidate");
        require(msg.value == candidateDeposit, "Deposit must be 0.001 ETH");

        candidateDetails[msg.sender] = Candidate({
            name: _name,
            party: _party,
            age: uint8(_age),
            gender: _gender,
            candidateId: nextCandidateId,
            votes: 0,
            deposit: msg.value
        });

        candidateList.push(msg.sender);
        emit CandidateRegistered(msg.sender, nextCandidateId++);
    }

    function getCandidateList() external view returns (address[] memory) {
        return candidateList;
    }

    function getVoterList() external view returns (address[] memory) {
        return voterList;
    }

    function emergencyStopVoting() external onlyCommissioner whenNotPaused {
        require(block.timestamp >= startTime, "Voting has not started yet");
        stopVoting = true;
    }

    function setVotingPeriod(uint _startTime, uint _endTime) external onlyCommissioner whenNotPaused {
        require(_endTime > _startTime, "End time must be after start time");
        require(getVotingStatus() != VotingStatus.InProgress, "Cannot set period during voting");

        startTime = _startTime;
        endTime = _endTime;
        emit VotingPeriodSet(_startTime, _endTime);
    }

    function getVotingStatus() public view returns (VotingStatus) {
        if (stopVoting) return VotingStatus.VotingStopped;
        if (block.timestamp < startTime) return VotingStatus.NotStarted;
        if (block.timestamp <= endTime) return VotingStatus.InProgress;
        return VotingStatus.Ended;
    }

    function vote(address _candidateAddress) external votingNotOver nonReentrant whenNotPaused {
        Voter storage voter = voterDetails[msg.sender];
        require(voter.voterId != 0, "Not registered");
        require(voter.voteCandidateId == 0, "Already voted");

        Candidate storage candidate = candidateDetails[_candidateAddress];
        require(candidate.candidateId != 0, "Candidate not found");

        voter.voteCandidateId = candidate.candidateId;
        candidate.votes++;
        emit VoteSuccessful(msg.sender, candidate.name);
    }

    function announceResult() external onlyCommissioner whenNotPaused {
        require(getVotingStatus() == VotingStatus.Ended, "Voting has not ended");

        uint winningVoteCount = 0;
        address winningCandidate;

        for (uint i = 0; i < candidateList.length; i++) {
            Candidate storage candidate = candidateDetails[candidateList[i]];
            if (candidate.votes > winningVoteCount) {
                winningVoteCount = candidate.votes;
                winningCandidate = candidateList[i];
            }
        }

        require(winningVoteCount > 0, "No votes cast");
        winner = winningCandidate;
        emit ResultAnnounced(winner, candidateDetails[winner].name, winningVoteCount);
    }

    function refundDeposit(address _candidate) external onlyCommissioner {
        require(candidateDetails[_candidate].candidateId != 0, "Candidate not found");
        require(getVotingStatus() == VotingStatus.Ended, "Voting not ended");
        require(candidateDetails[_candidate].deposit > 0, "No deposit to refund");

        uint refundAmount = candidateDetails[_candidate].deposit;
        candidateDetails[_candidate].deposit = 0; // Set to zero to prevent re-entrancy
        (bool success, ) = payable(_candidate).call{value: refundAmount}("");
        require(success, "Refund failed");

        emit DepositRefunded(_candidate, refundAmount);
    }

    function resetElection() external onlyCommissioner {
        require(getVotingStatus() == VotingStatus.Ended, "Election not ended");

        delete voterList;
        delete candidateList;
        nextVoterId = 1;
        nextCandidateId = 1;
        startTime = 0;
        endTime = 0;
        stopVoting = false;
        winner = address(0);
    }
}
