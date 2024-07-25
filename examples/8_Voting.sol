// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Vote {

    address electionCommission;

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
    uint nextVoterId = 1;
    uint nextCandidateId = 1;
    uint startTime = 0;
    uint endTime = 0 ;
    bool public stopVoting;


    mapping(uint => Voter) voterDetails;
    mapping(uint => Candidate) candidateDetails;

    enum VotingStatus {NotStarted, InProgress, Ended}
    enum Gender {NotSpecified, Male, Female, Other}


    modifier isVotingOver() {
        require(block.timestamp<= endTime && stopVoting == false, "Voting is over");
      _;
    }

    modifier onlyCommissioner() {
        require(msg.sender == electionCommission,"You dont have permission to perform this task");
        _;
    }

    function registerVoter(string calldata _name, uint _age, Gender _gender) external {
        require(_age >= 18, "Voter must be at least 18 years old");
        
        voterDetails[nextVoterId] = Voter({
            name: _name,
            age: _age,
            voterId: nextVoterId,
            gender: _gender,
            voteCandidateId: 0,
            voterAddress: msg.sender
        });
        
        nextVoterId++;
    }

    function getVoterDetails(uint _voterID )public view returns(Voter memory){
        Voter memory vtdetails  = voterDetails[_voterID];
        return vtdetails;

        // return (vtdetails.name,vtdetails.age,vtdetails.voterId,vtdetails.voterAddress,vtdetails.voteCandidateId);
    }

    function registerCandidate(string calldata _name,string calldata _party,uint _age,Gender _gender) external {
        require(_age >= 18, "Candidate must be at least 18 years old");
        candidateDetails[nextCandidateId] = Candidate({
            name:_name,
            party:_party,
            age:_age,
            gender:_gender,
            candidateId:nextCandidateId,
            candidateAddress: msg.sender,
            votes:0
        });
        nextCandidateId++;
    }

    function getCandidateList() public view returns (Candidate[] memory) {
       Candidate[] memory candidates = new Candidate[](nextCandidateId - 1);
            for (uint i = 1; i < nextCandidateId; i++) {
                candidates[i - 1] = candidateDetails[i];
            }
        return candidates;
    }

     function getVoterList() public view returns (Voter[] memory) {
        Voter[] memory voters = new Voter[](nextVoterId -1);
            for (uint i = 1; i< nextVoterId; i++)    
            {
                voters[i - 1] =voterDetails[i];
            }
        return voters;
     }

    function isCandidateNotRegistered(address _person) internal view returns (bool) {
        for (uint i = 1; i < nextCandidateId; i++) {
            if (candidateDetails[i].candidateAddress == _person) {
                return false;
            }
        }
        return true;
    }

    function emergencyStopVoting() public onlyCommissioner() { 
       stopVoting = true;
    }

    function emergencyAgainOnVoting() public onlyCommissioner() {
       stopVoting = false;
    }

    function setVotingPeriod(uint _startTime, uint _endTime) external onlyCommissioner() {
        startTime = _startTime;
        endTime = _endTime;
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

    function isVoterNotRegistered(address _person) internal view returns (bool) {
        for (uint i = 1; i < nextVoterId; i++) {
            if (voterDetails[i].voterAddress == _person) {
                return false;
            }
        }
    return true;
    }

      function castVote(uint _voterId, uint _candidateId) external {
        // Ensure voting is in progress
        require(block.timestamp >= startTime && block.timestamp <= endTime, "Voting is not in progress");
        require(!stopVoting, "Voting has been stopped");

        // Ensure voter is registered
        Voter storage voter = voterDetails[_voterId];
        require(voter.voterAddress == msg.sender, "You are not authorized to vote with this ID");
        require(voter.voteCandidateId == 0, "You have already voted");

        // Ensure candidate is registered
        Candidate storage candidate = candidateDetails[_candidateId];
        require(candidate.candidateAddress != address(0), "Candidate is not registered");

        // Record the vote
        voter.voteCandidateId = _candidateId;
        candidate.votes++;

        // Emit an event for successful vote casting (optional but recommended)
        emit VoteCasted(_voterId, _candidateId);
    }

    // Event to log vote casting (optional but recommended)
    event VoteCasted(uint indexed voterId, uint indexed candidateId);


}


 


   

   


 

    // function castVote(uint _voterId, uint _id) external {
   
    // }


   


   


    // function announceVotingResult() external onlyCommissioner() {
   
    // }


  

