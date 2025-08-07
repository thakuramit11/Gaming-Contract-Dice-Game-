// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

/**
 * @title Gaming Contract (Dice Game)
 * @dev A provably fair dice game smart contract
 */
contract Project is Ownable, ReentrancyGuard {
    // Game configuration
    uint256 public constant MIN_BET = 0.01 ether;
    uint256 public constant MAX_BET = 1 ether;
    uint256 public constant HOUSE_EDGE = 2; // 2% house edge
    
    // Game state
    uint256 public gameCounter;
    uint256 public totalVolume;
    uint256 public houseBalance;
    
    // Struct to store game information
    struct Game {
        address player;
        uint256 betAmount;
        uint256 predictedNumber;
        uint256 rolledNumber;
        bool isWinner;
        uint256 payout;
        uint256 timestamp;
    }
    
    // Mappings
    mapping(uint256 => Game) public games;
    mapping(address => uint256) public playerWins;
    mapping(address => uint256) public playerLosses;
    
    // Events
    event GamePlayed(
        uint256 indexed gameId,
        address indexed player,
        uint256 betAmount,
        uint256 predictedNumber,
        uint256 rolledNumber,
        bool isWinner,
        uint256 payout
    );
    
    event HouseBalanceUpdated(uint256 newBalance);
    event FundsWithdrawn(address indexed owner, uint256 amount);
    
    constructor() Ownable(msg.sender) {
        houseBalance = 0;
    }
    
    /**
     * @dev Core Function 1: Play the dice game
     * @param _predictedNumber The number player predicts (1-6)
     */
    function playDice(uint256 _predictedNumber) 
        external 
        payable 
        nonReentrant 
        returns (uint256 gameId) 
    {
        require(msg.value >= MIN_BET, "Bet amount too low");
        require(msg.value <= MAX_BET, "Bet amount too high");
        require(_predictedNumber >= 1 && _predictedNumber <= 6, "Invalid prediction (1-6)");
        require(address(this).balance >= msg.value * 5, "Insufficient house balance");
        
        gameCounter++;
        gameId = gameCounter;
        
        // Generate random number (1-6)
        uint256 rolledNumber = _generateRandomNumber() % 6 + 1;
        
        bool isWinner = rolledNumber == _predictedNumber;
        uint256 payout = 0;
        
        if (isWinner) {
            // Winner gets 5x their bet (minus house edge)
            payout = (msg.value * 5 * (100 - HOUSE_EDGE)) / 100;
            playerWins[msg.sender]++;
            
            // Transfer payout to winner
            (bool success, ) = payable(msg.sender).call{value: payout}("");
            require(success, "Payout transfer failed");
        } else {
            // House keeps the bet
            houseBalance += msg.value;
            playerLosses[msg.sender]++;
        }
        
        // Store game information
        games[gameId] = Game({
            player: msg.sender,
            betAmount: msg.value,
            predictedNumber: _predictedNumber,
            rolledNumber: rolledNumber,
            isWinner: isWinner,
            payout: payout,
            timestamp: block.timestamp
        });
        
        totalVolume += msg.value;
        
        emit GamePlayed(
            gameId,
            msg.sender,
            msg.value,
            _predictedNumber,
            rolledNumber,
            isWinner,
            payout
        );
        
        return gameId;
    }
    
    /**
     * @dev Core Function 2: Get game statistics for a player
     * @param _player The player address
     */
    function getPlayerStats(address _player) 
        external 
        view 
        returns (
            uint256 wins,
            uint256 losses,
            uint256 winRate,
            uint256 totalGames
        ) 
    {
        wins = playerWins[_player];
        losses = playerLosses[_player];
        totalGames = wins + losses;
        
        if (totalGames > 0) {
            winRate = (wins * 100) / totalGames;
        } else {
            winRate = 0;
        }
        
        return (wins, losses, winRate, totalGames);
    }
    
    /**
     * @dev Core Function 3: Get contract statistics
     */
    function getContractStats() 
        external 
        view 
        returns (
            uint256 totalGames,
            uint256 contractBalance,
            uint256 houseProfit,
            uint256 volume
        ) 
    {
        return (
            gameCounter,
            address(this).balance,
            houseBalance,
            totalVolume
        );
    }
    
    /**
     * @dev Generate pseudo-random number
     * Note: This is for demonstration. In production, use Chainlink VRF or similar
     */
    function _generateRandomNumber() private view returns (uint256) {
        return uint256(
            keccak256(
                abi.encodePacked(
                    block.timestamp,
                    block.prevrandao,
                    block.coinbase,
                    msg.sender,
                    gameCounter
                )
            )
        );
    }
    
    /**
     * @dev Add funds to the house balance (only owner)
     */
    function addHouseFunds() external payable onlyOwner {
        houseBalance += msg.value;
        emit HouseBalanceUpdated(houseBalance);
    }
    
    /**
     * @dev Withdraw house profits (only owner)
     */
    function withdrawHouseFunds(uint256 _amount) external onlyOwner {
        require(_amount <= houseBalance, "Insufficient house balance");
        require(_amount <= address(this).balance, "Insufficient contract balance");
        
        houseBalance -= _amount;
        
        (bool success, ) = payable(owner()).call{value: _amount}("");
        require(success, "Withdrawal failed");
        
        emit FundsWithdrawn(owner(), _amount);
        emit HouseBalanceUpdated(houseBalance);
    }
    
    /**
     * @dev Get game details by ID
     */
    function getGameDetails(uint256 _gameId) 
        external 
        view 
        returns (
            address player,
            uint256 betAmount,
            uint256 predictedNumber,
            uint256 rolledNumber,
            bool isWinner,
            uint256 payout,
            uint256 timestamp
        ) 
    {
        require(_gameId > 0 && _gameId <= gameCounter, "Invalid game ID");
        
        Game storage game = games[_gameId];
        return (
            game.player,
            game.betAmount,
            game.predictedNumber,
            game.rolledNumber,
            game.isWinner,
            game.payout,
            game.timestamp
        );
    }
    
    // Allow contract to receive Ether
    receive() external payable {
        houseBalance += msg.value;
        emit HouseBalanceUpdated(houseBalance);
    }
}

