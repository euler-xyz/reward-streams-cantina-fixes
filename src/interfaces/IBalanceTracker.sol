// SPDX-License-Identifier: GPL-2.0-or-later

pragma solidity ^0.8.23;

/// @title Interface for the Balance Tracker
interface IBalanceTracker {
    /// @notice Executes the balance tracking hook for an account
    /// @dev This function is called by the Balance Forwarder contract which was enabled for the account
    /// @dev To prevent DOS attacks, forgiveRecentReward should be used appropriately
    /// @param account The account address to execute the hook for
    /// @param newBalance The new balance of the account
    /// @param forgiveRecentReward Whether to forgive the most recent reward and not update the accumulator
    function balanceTrackerHook(address account, uint256 newBalance, bool forgiveRecentReward) external;
}