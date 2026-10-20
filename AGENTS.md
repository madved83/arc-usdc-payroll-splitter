# BatchPayroll

> Built with Arc Studio - money-powered apps in minutes

This is the **project memory** - what Arc Studio remembers about building this app. It helps future agents (or humans) understand and extend the project.

---

## What This App Does

Batch USDC payroll dispatcher on Arc Testnet. An employer connects their wallet, enters recipient addresses and USDC amounts (or imports a CSV), sees the total, approves USDC allowance, then dispatches a single on-chain transaction that distributes USDC to all recipients atomically. Includes a transaction history table.

## Deployed Contracts

| Contract | Network | Address | Explorer |
|---|---|---|---|
| BatchPayroll | Arc Testnet | `0x5699c781941cc1d2fa7d432827824d2520305bf6` | [View](https://explorer.testnet.arc.io/address/0x5699c781941cc1d2fa7d432827824d2520305bf6) |

## Tech Stack

- Frontend: React 18, Vite, TypeScript, Tailwind CSS
- Web3: wagmi v2, viem v2, ConnectKit
- Contracts: Solidity 0.8.28 + Foundry. Sources in `contracts/`, unit tests in `contracts/test/*.t.sol`. Build with `bun run contracts:build` (`forge build`), test with `bun run contracts:test` (`forge test`).
- Wallet: injected (MetaMask, etc.)
- Chain: Arc Testnet (Chain ID: 5042002, imported from `viem/chains`)
- Token: USDC (6 decimals) (Address: 0x3600000000000000000000000000000000000000, Chain: Arc Testnet)
- Toasts: Sonner

## Key Files

- `src/App.tsx` - Main application logic
- `src/components/` - UI components
- `src/config.ts` - wagmi config (chains, connectors, transports)

## To Run

```bash
bun install
bun run dev
```
