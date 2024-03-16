// SPDX-License-Identifier: MIT
pragma solidity ^0.8.;

import "@thirdweb-dev/contracts/base/ERC20SignatureMintVote.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract StakingReward is ERC20SignatureMintVote, ReentrancyGuard {
    // State variables
    mapping(address => uint256) public stakes;
    mapping(address => uint256) public lastUpdateTime;
    mapping(address => uint256) public rewards;

    uint256 public rewardRate = 0.001; // Reward rate per token per second
    uint256 public totalStaked;

    constructor(
        address _defaultAdmin,
        string memory _name,
        string memory _symbol,
        address _primarySaleRecipient
    )
        ERC20SignatureMintVote(
            _defaultAdmin,
            _name,
            _symbol,
            _primarySaleRecipient
        )
    {}

    // Modifier to prevent reentrancy attacks
    modifier updateReward(address _staker) {
        rewards[_staker] += (block.timestamp - lastUpdateTime[_staker]) * stakes[_staker] * rewardRate;
        lastUpdateTime[_staker] = block.timestamp;
        _;
    }

    // Call this function to stake tokens
    function stake(uint256 _amount) external nonReentrant updateReward(msg.sender) {
        require(_amount > 0, "Cannot stake 0");
        stakes[msg.sender] += _amount;
        totalStaked += _amount;
        _burn(msg.sender, _amount);
    }

    // Call this function to withdraw staked tokens
    function withdraw(uint256 _amount) external nonReentrant updateReward(msg.sender) {
        require(stakes[msg.sender] >= _amount, "Cannot withdraw more than staked");
        stakes[msg.sender] -= _amount;
        totalStaked -= _amount;
        _mint(msg.sender, _amount);
    }

    // Call this function to claim rewards
    function claimReward() external nonReentrant updateReward(msg.sender) {
        uint256 reward = rewards[msg.sender];
        require(reward <= balanceOf(address(this)), "Not enough tokens in contract for rewards");
        rewards[msg.sender] = 0;
        _mint(msg.sender, reward);
    }

    // Function to safely update the reward rate
    function setRewardRate(uint256 _newRate) external onlyRole(DEFAULT_ADMIN_ROLE) {
        require(_newRate > 0, "Reward rate must be greater than 0");
        rewardRate = _newRate;
    }
}
