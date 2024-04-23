// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.24;

import "../../src/StakingRewardStreams.sol";

contract StakingRewardStreamsHarness is StakingRewardStreams {
    using SafeERC20 for IERC20;
    using Set for SetStorage;

    constructor(address evc, uint48 epochDuration) StakingRewardStreams(evc, epochDuration) {}

    function setDistributionAmount(address rewarded, address reward, uint48 epoch, uint128 amount) external {
        distributions[rewarded][reward].amounts[epoch / EPOCHS_PER_SLOT][epoch % EPOCHS_PER_SLOT] = amount;
    }

    function getDistributionData(address rewarded, address reward) external view returns (uint48, uint208) {
        Distribution storage distribution = distributions[rewarded][reward];
        return (distribution.lastUpdated, distribution.accumulator);
    }

    function setDistributionData(address rewarded, address reward, uint48 lastUpdated, uint208 accumulator) external {
        Distribution storage distribution = distributions[rewarded][reward];
        distribution.lastUpdated = lastUpdated;
        distribution.accumulator = accumulator;
    }

    function getDistributionTotals(
        address rewarded,
        address reward
    ) external view returns (uint256, uint128, uint128) {
        Distribution storage distribution = distributions[rewarded][reward];
        return (distribution.totalEligible, distribution.totalRegistered, distribution.totalClaimed);
    }

    function setDistributionTotals(
        address rewarded,
        address reward,
        uint256 totalEligible,
        uint128 totalRegistered,
        uint128 totalClaimed
    ) external {
        Distribution storage distribution = distributions[rewarded][reward];
        distribution.totalEligible = totalEligible;
        distribution.totalRegistered = totalRegistered;
        distribution.totalClaimed = totalClaimed;
    }

    function getAccountBalance(address account, address rewarded) external view returns (uint256) {
        return accountStorage[account][rewarded].balance;
    }

    function setAccountBalance(address account, address rewarded, uint256 balance) external {
        accountStorage[account][rewarded].balance = balance;
    }

    function insertReward(address account, address rewarded, address reward) external {
        accountStorage[account][rewarded].enabledRewards.insert(reward);
    }

    function getAccountEarnedData(
        address account,
        address rewarded,
        address reward
    ) external view returns (EarnStorage memory) {
        return accountStorage[account][rewarded].earnedData[reward];
    }

    function setAccountEarnedData(
        address account,
        address rewarded,
        address reward,
        EarnStorage memory earnStorage
    ) external {
        accountStorage[account][rewarded].earnedData[reward] = earnStorage;
    }
}
