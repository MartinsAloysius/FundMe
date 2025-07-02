# 🪙 FundMe Smart Contract

A simple smart contract that accepts ETH donations with a minimum USD value enforced via Chainlink price feeds. Only the owner can withdraw funds, and all funders are tracked transparently.

---

## 🚀 Features

- ✅ Accepts ETH from users
- 💵 Enforces a **minimum funding value in USD**
- 🔗 Integrates with **Chainlink Price Feeds**
- 🔐 Allows only the **owner** to withdraw funds
- 🧾 Tracks funders and contributions

---

## 🛠 Tech Stack

- **Solidity** `^0.8.24`
- **Chainlink Oracles**
  

---

## 📂 Project Structure

| Function            | Description                                       |
| ------------------- | ------------------------------------------------- |
| `fund()`            | Accepts ETH if it meets the minimum USD threshold |
| `withdraw()`        | Owner-only: withdraws all funds from the contract |
| `cheaperWithdraw()` | Gas-optimized withdraw for multiple funders       |


| Function              | Purpose                                  |
| --------------------- | ---------------------------------------- |
| `getPrice()`          | Fetches real-time ETH/USD from Chainlink |
| `getConversionRate()` | Converts ETH to USD                      |
| `getVersion()`        | Gets price feed contract version         |


🧪 How to Deploy
You can deploy using Remix, Hardhat, or Foundry.
Make sure to:

Use a supported testnet (like Goerli or Sepolia)

Fund your wallet with test ETH

Verify the price feed contract address for the network


🔐 Access Control
Only the contract deployer becomes the owner

onlyOwner modifier restricts sensitive operations


📝 License
MIT © 2025

👨‍💻 Author
Built by Aloysius Martins
Web3 Developer | Solidity smart contract developer

```plaintext
FundMe.sol          # Main contract logic
|-- PriceConverter  # Library for price conversion using Chainlink
