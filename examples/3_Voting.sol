// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Q.Conditional Logic

// Create a contract called Voting that allows users to vote on different proposals.
// Implement the following functions:

// addProposal(string memory _proposal): Adds a new proposal.
// vote(uint256 _proposalIndex): Allows a user to vote for a proposal.
// getWinningProposal() view returns (string memory): Returns the proposal with the most votes.

contract Voting {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require (msg.sender == owner,"You do not have access");
        _;
    }
    
    struct Proposal {
        string name;
        uint256 voteCount;
    }

    Proposal[] private proposals;
    mapping(address => bool) public hasVoted;

    function getProposals(uint _proposalIndex)public view returns (string memory) {
        require(_proposalIndex < proposals.length, "Proposal does not exist");
        return proposals[_proposalIndex].name;
    }

    function addProposal(string memory _proposal) public onlyOwner {
        proposals.push(Proposal({
            name: _proposal,
            voteCount: 0
        }));
    }

    function vote(uint256 _proposalIndex) public {
        require(_proposalIndex < proposals.length, "Proposal does not exist");
        require(!hasVoted[msg.sender], "You have already voted");

        proposals[_proposalIndex].voteCount += 1;
        hasVoted[msg.sender] = true;
    }

    function getWinningProposal() public view returns (string memory) {
        require(proposals.length > 0, "No proposals available");

        uint256 winningVoteCount = 0;
        uint256 winningProposalIndex = 0;
        bool isTie = false;

        for (uint256 i = 0; i < proposals.length; i++) {
            if (proposals[i].voteCount > winningVoteCount) {
                winningVoteCount = proposals[i].voteCount;
                winningProposalIndex = i;
                isTie = false;
            } else if (proposals[i].voteCount == winningVoteCount) {
                isTie = true;
            }
        }

        if (isTie) {
            return "Tie";
        } else {
            return proposals[winningProposalIndex].name;
        }
    }
}
