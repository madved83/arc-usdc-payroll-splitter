// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract BatchPayroll is ReentrancyGuard {
    using SafeERC20 for IERC20;

    error EmptyBatch();
    error LengthMismatch();
    error BatchTooLarge(uint256 length, uint256 max);
    error ZeroAmount(uint256 index);
    error ZeroRecipient(uint256 index);
    error ZeroUSDCAddress();

    event BatchDispatched(
        address indexed payer,
        uint256 total,
        address[] recipients,
        uint256[] amounts
    );

    address public immutable usdc;
    uint256 public constant MAX_BATCH = 200;

    /// @notice Initializes the payroll dispatcher with the USDC token address.
    /// @param _usdc The ERC-20 USDC token contract address used for all transfers.
    constructor(address _usdc) {
        if (_usdc == address(0)) revert ZeroUSDCAddress();
        usdc = _usdc;
    }

    /// @notice Pulls total USDC from caller and atomically dispatches amounts to recipients.
    /// @param recipients List of recipient addresses to receive USDC.
    /// @param amounts List of USDC amounts matching each recipient by index.
    function dispatchBatch(
        address[] calldata recipients,
        uint256[] calldata amounts
    ) external nonReentrant {
        uint256 length = recipients.length;

        if (length == 0) revert EmptyBatch();
        if (length != amounts.length) revert LengthMismatch();
        if (length > MAX_BATCH) revert BatchTooLarge(length, MAX_BATCH);

        uint256 total = 0;
        for (uint256 i = 0; i < length; ++i) {
            if (amounts[i] == 0) revert ZeroAmount(i);
            if (recipients[i] == address(0)) revert ZeroRecipient(i);
            total += amounts[i];
        }

        IERC20 token = IERC20(usdc);
        token.safeTransferFrom(msg.sender, address(this), total);

        for (uint256 i = 0; i < length; ++i) {
            token.safeTransfer(recipients[i], amounts[i]);
        }

        emit BatchDispatched(msg.sender, total, recipients, amounts);
    }
}
