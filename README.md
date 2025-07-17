# Gaming Contract (Dice Game)

A decentralized dice game smart contract built with Solidity and deployed on Core Testnet 2. Players can bet on dice rolls with provably fair outcomes and transparent gameplay.

## Project Description

This project implements a fully functional dice game on the blockchain where players can:
- Place bets on dice outcomes (1-6)
- Receive 5x payout for correct predictions
- Track their gaming statistics
- Enjoy provably fair gameplay with transparent random number generation

The contract includes house edge management, bet limits, and comprehensive game tracking for a complete gaming experience.

## Project Vision

To create a transparent, fair, and engaging blockchain-based gaming platform that demonstrates the power of decentralized applications. Our vision extends beyond simple gambling to showcase how smart contracts can revolutionize the gaming industry by providing:

- **Transparency**: All game outcomes are verifiable on-chain
- **Fairness**: Provably fair random number generation
- **Accessibility**: Global access without geographical restrictions
- **Trust**: No need to trust centralized operators

## Key Features

### 🎲 **Core Gaming Features**
- **Dice Rolling**: Players predict numbers 1-6 with 5x payout multiplier
- **Bet Limits**: Minimum 0.01 ETH, Maximum 1 ETH per game
- **House Edge**: 2% house edge for sustainable operations
- **Instant Results**: Immediate game resolution and payout

### 📊 **Statistics & Tracking**
- **Player Stats**: Win/loss ratio, total games, win rate calculation
- **Contract Stats**: Total games, volume, house profits tracking
- **Game History**: Complete game details stored on-chain
- **Real-time Updates**: Live statistics for all participants

### 🔒 **Security Features**
- **Reentrancy Protection**: Prevents common attack vectors
- **Access Control**: Owner-only functions for house management
- **Balance Verification**: Ensures contract can cover payouts
- **Input Validation**: Comprehensive parameter checking

### 💰 **Financial Management**
- **House Funds**: Owner can add/withdraw house balance
- **Automatic Payouts**: Instant winner payments
- **Profit Tracking**: Transparent house profit monitoring
- **Emergency Controls**: Owner withdrawal capabilities

## Future Scope

### 🚀 **Short-term Enhancements**
- **Multiple Dice Games**: Support for 2-dice, 3-dice variations
- **Jackpot System**: Progressive jackpot for consecutive wins
- **Referral Program**: Reward system for bringing new players
- **Mobile DApp**: React Native mobile application

### 🌟 **Medium-term Developments**
- **Chainlink VRF**: Integration for truly random number generation
- **Multi-token Support**: Accept various cryptocurrencies
- **Tournament Mode**: Competitive gaming with leaderboards
- **Social Features**: Player profiles, achievements, and rankings

### 🔮 **Long-term Vision**
- **Cross-chain Deployment**: Deploy on multiple blockchains
- **AI-powered Analytics**: Advanced player behavior analysis
- **NFT Integration**: Collectible game items and rewards
- **Decentralized Governance**: Community-driven development

### 🎯 **Advanced Features**
- **Prediction Markets**: Expand to sports and event betting
- **Liquidity Mining**: Reward liquidity providers
- **Layer 2 Integration**: Reduce transaction costs
- **Metaverse Integration**: 3D gaming environments

## Technical Specifications

- **Solidity Version**: ^0.8.19
- **Framework**: Hardhat
- **Network**: Core Testnet 2
- **Security**: OpenZeppelin contracts
- **Testing**: Comprehensive test suite included

## Installation & Setup

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd gaming-contract-dice-game## Things you need to do:

- Project.sol file - Rename this file and add the solidity code inside it.
- deploy.js file - Add the deploy.js (javascript) code inside it.
- .env.example - Add the Private Key of your MetaMask Wallet's account.
- Readme.md file - Add the Readme content inside this file.
- package.json file – Replace the `"name"` property value from `"Project-Title"` to your actual project title. <br/>
*Example:* `"name": "crowdfunding-smartcontract"`
