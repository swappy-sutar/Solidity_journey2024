// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract VotingEVM is Pausable, ReentrancyGuard {
    address public immutable electionCommission;
    uint256 public constant candidateDeposit = 0.0001 ether;

    constructor() {
        electionCommission = msg.sender;
    }

    enum VotingStatus { NotStarted, InProgress, Ended, VotingStopped }
    enum Gender { NotSpecified, Male, Female, Other }

    struct Voter {
        string name;
        uint8 age;
        uint256 voterId;
        Gender gender;
        uint256 voteCandidateId;
    }

    struct Candidate {
        string name;
        string party;
        uint8 age;
        Gender gender;
        uint256 candidateId;
        uint256 votes;
        uint256 deposit;
    }

    address public winner;
    uint256 private nextVoterId = 1;
    uint256 private nextCandidateId = 1;
    uint256 private startTime = 0;
    uint256 private endTime = 0;
    bool private stopVoting;

    mapping(address => Voter) private voterDetails;
    mapping(address => bool) private voterExist;
    mapping(address => Candidate) private candidateDetails;
    mapping(address => bool) private candidateExist;

    address[] private voterList;
    address[] private candidateList;

    event VoterRegistered(address indexed voterAddress, uint256 voterId);
    event CandidateRegistered(address indexed candidateAddress, uint256 candidateId);
    event VotingPeriodSet(uint256 startTime, uint256 endTime);
    event VoteSuccessful(address indexed voterAddress, string candidateName);
    event ResultAnnounced(address indexed winner, string name, uint256 votes);
    event DepositRefunded(address indexed candidate, uint256 amount);

    modifier votingNotOver() {
        require(block.timestamp <= endTime && !stopVoting, "Voting is over or stopped");
        _;
    }

    modifier onlyCommissioner() {
        require(msg.sender == electionCommission, "Permission denied: Not election commissioner");
        _;
    }

    modifier validAge(uint256 _age) {
        require(_age >= 18, "Age must be at least 18");
        _;
    }

    receive() external payable {}

    function transferETH(address payable _address, uint256 _amount) external onlyCommissioner {
        require(address(this).balance >= _amount, "Insufficient contract balance");
        (bool success, ) = _address.call{value: _amount}("");
        require(success, "Transfer failed");
    }

    function registerVoter(string calldata _name, uint256 _age, Gender _gender) external validAge(_age) whenNotPaused {
        require(!voterExist[msg.sender], "Voter already registered");
        require(bytes(_name).length > 0, "Name cannot be empty");

        voterDetails[msg.sender] = Voter({
            name: _name,
            age: uint8(_age),
            voterId: nextVoterId,
            gender: _gender,
            voteCandidateId: 0
        });

        voterExist[msg.sender] = true;
        voterList.push(msg.sender);

        emit VoterRegistered(msg.sender, nextVoterId);
        nextVoterId++;
    }

    function getVoter(address _voterAddress) public view returns (string memory name, uint256 age, Gender gender) {
        Voter memory voter = voterDetails[_voterAddress];
        return (voter.name, voter.age, voter.gender);
    }

    function registerCandidate(string calldata _name, string calldata _party, uint256 _age, Gender _gender) external payable validAge(_age) whenNotPaused {
        require(!candidateExist[msg.sender], "Candidate already registered");
        require(msg.sender != electionCommission, "Election commissioner cannot be a candidate");
        require(bytes(_name).length > 0, "Name cannot be empty");
        require(bytes(_party).length > 0, "Party cannot be empty");
        require(msg.value == candidateDeposit, "Deposit amount must be 0.0001 ETH");

        candidateDetails[msg.sender] = Candidate({
            name: _name,
            party: _party,
            age: uint8(_age),
            gender: _gender,
            candidateId: nextCandidateId,
            votes: 0,
            deposit: msg.value
        });

        candidateExist[msg.sender] = true;
        candidateList.push(msg.sender);

        emit CandidateRegistered(msg.sender, nextCandidateId);
        nextCandidateId++;
    }

    function getCandidate(address _candidateAddress) public view returns (string memory name, string memory party, uint256 age, Gender gender) {
        Candidate memory candidate = candidateDetails[_candidateAddress];
        return (candidate.name, candidate.party, candidate.age, candidate.gender);
    }

    function getCandidateList() public view returns (address[] memory) {
        return candidateList;
    }

    function getVoterList() public view returns (address[] memory) {
        return voterList;
    }

    function emergencyStopVoting() public onlyCommissioner whenNotPaused {
        require(block.timestamp >= startTime, "Voting has not started yet");
        stopVoting = true;
    }

    function setVotingPeriod(uint256 _startTime, uint256 _endTime) external onlyCommissioner whenNotPaused {
        require(_endTime > _startTime, "End time must be greater than start time");
        require(getVotingStatus() != VotingStatus.InProgress, "Cannot set period during active voting");

        startTime = _startTime;
        endTime = _endTime;

        emit VotingPeriodSet(_startTime, _endTime);
    }

    function getVotingTimePeriod() external view returns (uint256, uint256) {
        return (startTime, endTime);
    }

    function getVotingStatus() public view returns (VotingStatus) {
        if (stopVoting) {
            return VotingStatus.VotingStopped;
        } else if (block.timestamp < startTime) {
            return VotingStatus.NotStarted;
        } else if (block.timestamp >= startTime && block.timestamp <= endTime) {
            return VotingStatus.InProgress;
        } else {
            return VotingStatus.Ended;
        }
    }

    function vote(address _candidateAddress) external votingNotOver nonReentrant whenNotPaused {
        require(voterExist[msg.sender], "You are not registered to vote");
        require(voterDetails[msg.sender].voteCandidateId == 0, "You have already voted");
        require(candidateExist[_candidateAddress], "Candidate not found");

        Voter storage voter = voterDetails[msg.sender];
        voter.voteCandidateId = candidateDetails[_candidateAddress].candidateId;

        candidateDetails[_candidateAddress].votes++;

        emit VoteSuccessful(msg.sender, candidateDetails[_candidateAddress].name);
    }

    function announceResult() external onlyCommissioner whenNotPaused {
        require(getVotingStatus() == VotingStatus.Ended, "Voting has not ended yet");

        address winningCandidate;
        uint256 winningVoteCount = 0;

        for (uint256 i = 0; i < candidateList.length; i++) {
            address candidateAddr = candidateList[i];
            uint256 candidateVotes = candidateDetails[candidateAddr].votes;
            if (candidateVotes > winningVoteCount) {
                winningVoteCount = candidateVotes;
                winningCandidate = candidateAddr;
            }
        }

        require(winningVoteCount > 0, "No votes were cast");

        winner = winningCandidate;
        emit ResultAnnounced(winner, candidateDetails[winner].name, winningVoteCount);
    }

    function refundDeposit(address _candidate) external onlyCommissioner {
        require(candidateExist[_candidate], "Candidate does not exist");
        require(address(this).balance > 0, "No balance available for refund");
        require(getVotingStatus() == VotingStatus.Ended, "Voting not ended yet");

        Candidate memory candidate = candidateDetails[_candidate];

        // Transfer the deposit back to the candidate
        (bool success, ) = payable(_candidate).call{value: candidate.deposit}("");
        require(success, "Refund failed");

        emit DepositRefunded(_candidate, candidate.deposit);
    }

    function resetElection() external onlyCommissioner {
        require(getVotingStatus() == VotingStatus.Ended, "Election not ended yet");

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
