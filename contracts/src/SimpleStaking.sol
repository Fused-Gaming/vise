// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title SimpleStaking
 * @notice ETH staking contract demonstration for VISE Module 2
 * @dev Demonstrates:
 *      - Payable functions
 *      - Reward calculations
 *      - Time-based logic
 *      - ETH handling
 */
contract SimpleStaking {
    // Constants
    uint256 public constant REWARD_RATE = 10; // 10% APY
    uint256 public constant SECONDS_PER_YEAR = 365 days;

    // State variables
    mapping(address => uint256) public stakedAmount;
    mapping(address => uint256) public stakingTimestamp;
    uint256 public totalStaked;

    // Events
    event Staked(address indexed user, uint256 amount, uint256 timestamp);
    event Unstaked(address indexed user, uint256 amount, uint256 reward);
    event RewardClaimed(address indexed user, uint256 reward);

    /**
     * @notice Stake ETH
     */
    function stake() public payable {
        require(msg.value > 0, "Cannot stake 0");

        // Claim existing rewards before adding new stake
        if (stakedAmount[msg.sender] > 0) {
            uint256 reward = calculateReward(msg.sender);
            if (reward > 0) {
                payable(msg.sender).transfer(reward);
                emit RewardClaimed(msg.sender, reward);
            }
        }

        stakedAmount[msg.sender] += msg.value;
        stakingTimestamp[msg.sender] = block.timestamp;
        totalStaked += msg.value;

        emit Staked(msg.sender, msg.value, block.timestamp);
    }

    /**
     * @notice Unstake all ETH and claim rewards
     */
    function unstake() public {
        require(stakedAmount[msg.sender] > 0, "No stake to withdraw");

        uint256 amount = stakedAmount[msg.sender];
        uint256 reward = calculateReward(msg.sender);
        uint256 total = amount + reward;

        // Update state before transfer (CEI pattern)
        stakedAmount[msg.sender] = 0;
        stakingTimestamp[msg.sender] = 0;
        totalStaked -= amount;

        // Transfer
        payable(msg.sender).transfer(total);

        emit Unstaked(msg.sender, amount, reward);
    }

    /**
     * @notice Calculate pending rewards for a user
     * @param user The user's address
     * @return The pending reward amount
     */
    function calculateReward(address user) public view returns (uint256) {
        if (stakedAmount[user] == 0) return 0;

        uint256 stakingDuration = block.timestamp - stakingTimestamp[user];
        uint256 reward = (stakedAmount[user] * REWARD_RATE * stakingDuration) /
            (100 * SECONDS_PER_YEAR);

        return reward;
    }

    /**
     * @notice Get staking information for a user
     * @param user The user's address
     * @return amount The staked amount
     * @return timestamp When the stake began
     * @return reward The pending reward
     */
    function getStakeInfo(address user)
        public
        view
        returns (
            uint256 amount,
            uint256 timestamp,
            uint256 reward
        )
    {
        return (
            stakedAmount[user],
            stakingTimestamp[user],
            calculateReward(user)
        );
    }

    /**
     * @notice Get the contract's ETH balance
     * @return The balance in wei
     */
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }

    /**
     * @notice Receive ETH
     */
    receive() external payable {
        // Allow contract to receive ETH for rewards
    }
}
