// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract PredictAgentChat {

    struct Interaction {
        address user;
        uint256 agentId;
        string message;
        uint256 timestamp;
    }

    mapping(uint256 => uint256) public agentKarma;

    Interaction[] public interactions;

    event NewInteraction(
        address indexed user,
        uint256 indexed agentId,
        string message,
        uint256 timestamp
    );

    event KarmaUpdated(
        uint256 indexed agentId,
        address indexed user,
        uint256 karma
    );

    
    function interact(uint256 agentId, string memory message) public {

        interactions.push(
            Interaction(
                msg.sender,
                agentId,
                message,
                block.timestamp
            )
        );

        
        agentKarma[agentId] += 1;

        emit NewInteraction(
            msg.sender,
            agentId,
            message,
            block.timestamp
        );

        emit KarmaUpdated(
            agentId,
            msg.sender,
            agentKarma[agentId]
        );
    }

    function getInteractions() public view returns (Interaction[] memory) {
        return interactions;
    }

    function getKarma(uint256 agentId) public view returns (uint256) {
        return agentKarma[agentId];
    }
}
