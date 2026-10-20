# Arc USDC Payroll Splitter

Minimalist smart contract and frontend interface for batching USDC payouts on Arc Network (Chain ID: 5042).

## Architecture
- **Contract:** `PayrollSplitter.sol` — accepts an array of recipient addresses and corresponding USDC values, executing atomic transfers in a single call.
- **Native Gas Advantage:** Eliminates dual-token treasury management by utilizing Arc's native USDC gas model.

## Deployment Info
- **Network:** Arc Mainnet (Chain ID: 5042)
- **Contract Address:** `0x9e18033582b25Df4aEddd681D00f6a9551FfB45c`
