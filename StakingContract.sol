// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract StakingContract is Ownable {
    IERC20 public lpToken1;
    IERC20 public lpToken2;
    IERC20 public rewardToken;

    uint256 public constant REWARD_AMOUNT = 100000;
    uint256 public constant REWARD_INTERVAL = 30 days;
    uint256 public lastRewardTime;

    mapping(address => uint256) public stakes;

    constructor(address _lpToken1, address _lpToken2, address _rewardToken) {
        lpToken1 = IERC20(_lpToken1);
        lpToken2 = IERC20(_lpToken2);
        rewardToken = IERC20(_rewardToken);
        lastRewardTime = block.timestamp;
    }

    function stake(uint256 amount) public {
        lpToken1.transferFrom(msg.sender, address(this), amount);
        lpToken2.transferFrom(msg.sender, address(this), amount);
        stakes[msg.sender] += amount;
    }

    function unstake(uint256 amount) public {
        require(amount <= stakes[msg.sender], "Cannot unstake more than you've staked.");
        stakes[msg.sender] -= amount;
        lpToken1.transfer(msg.sender, amount);
        lpToken2.transfer(msg.sender, amount);
    }

    function distributeRewards() public onlyOwner {
        require(block.timestamp >= lastRewardTime + REWARD_INTERVAL, "Too early to distribute rewards.");

        uint256 totalStaked = lpToken1.balanceOf(address(this));
        for (uint256 i = 0; i < totalStaked; i++) {
            uint256 reward = stakes[msg.sender] * REWARD_AMOUNT / totalStaked;
            rewardToken.transfer(msg.sender, reward);
        }

        lastRewardTime = block.timestamp;
    }
}
