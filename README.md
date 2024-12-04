# MakeupToken Smart Contract

MakeupToken is an ERC20 token that allows users to redeem their tokens for makeup items. It incorporates functionalities such as minting, burning, and redeeming tokens for predefined items. The contract is built using the OpenZeppelin library for secure and robust implementation of ERC20 standards and ownership management.

---

## Features

- **ERC20 Implementation**: Fully compliant ERC20 token with a fixed decimal of 0 (non-fractional tokens).
- **Minting and Burning**: 
  - Tokens can be minted by the contract owner.
  - Users can burn their tokens.
- **Redeemable Items**: Users can redeem tokens for predefined makeup items such as Lipstick, Eyeshadow, Foundation, and Blush.
- **Ownership Management**: The contract owner has special permissions for minting tokens.
- **Token Transfers**: Tokens can be transferred between users with event logging for transparency.
- **View User Data**: Functions to retrieve available items and the items owned by a specific user.

---

## Deployment

The contract is deployed using the Solidity version `^0.8.18` and requires the OpenZeppelin library.

### Constructor Parameters

- **initialOwner**: Address of the contract owner who can mint tokens and manage the contract.

---

## Contract Details

### Token Details

- **Token Name**: MakeupToken
- **Token Symbol**: MAKEUP
- **Decimals**: 0 (tokens are non-fractional)

---

## Available Functions

### Public/External Functions

#### Token Operations
- **`mint(address to, uint256 amount)`**: Mint new tokens. Only callable by the owner.
- **`burn(uint256 amount)`**: Burn tokens from the caller's balance.
- **`transfer(address to, uint256 amount)`**: Transfer tokens to another address.

#### Redeem Items
- **`redeem(uint256 itemId)`**: Redeem tokens for a predefined makeup item. Emits an `ItemRedeemed` event.

#### View Functions
- **`getMakeupItems()`**: Returns all available makeup items in the contract.
- **`getOwnedItems()`**: Returns the list of makeup items owned by the caller.

---

## Events

- **`ItemRedeemed(address indexed redeemer, uint256 itemId, string itemName, uint256 itemCost)`**: Emitted when a user redeems tokens for an item.
- **`TokensTransferred(address indexed from, address indexed to, uint256 amount)`**: Emitted when tokens are transferred.

---

## Makeup Items

| ID | Name       | Cost (Tokens) |
|----|------------|---------------|
| 1  | Lipstick   | 100           |
| 2  | Eyeshadow  | 150           |
| 3  | Foundation | 250           |
| 4  | Blush      | 500           |

---

## Usage

### Minting Tokens
The owner can mint tokens using the `mint` function:
```solidity
mint(address recipient, uint256 amount);
```

### Redeeming Items
Users can redeem tokens for a makeup item:
```solidity
redeem(uint256 itemId);
```

### Viewing Data
Retrieve available items:
```solidity
getMakeupItems();
```

Retrieve owned items for the caller:
```solidity
getOwnedItems();
```

---

## Development

### Prerequisites
- Node.js and npm
- Hardhat development environment
- OpenZeppelin contracts library

### Installing Dependencies
```bash
npm install @openzeppelin/contracts
```

### Testing
Use Hardhat to write and execute tests for the contract.

---

## Security

The contract uses the following security practices:
- OpenZeppelin's audited library for ERC20 and ownership functionalities.
- Checks for zero address transfers and invalid item IDs.
- Prevents unauthorized minting of tokens.

---

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.
