// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MakeupToken is ERC20, Ownable {
    struct MakeupItem {
        uint256 id;
        string name;
        uint256 cost;
    }

    MakeupItem[] public makeupItems;
    mapping(address => MakeupItem[]) private ownedMakeupItems;

    event ItemRedeemed(address indexed redeemer, uint256 itemId, string itemName, uint256 itemCost);
    event TokensTransferred(address indexed from, address indexed to, uint256 amount);

    // Constructor with initialOwner explicitly passed
    constructor(address initialOwner) ERC20("MakeupToken", "MAKEUP") Ownable(initialOwner) {
        // Add predefined makeup items
        makeupItems.push(MakeupItem(1, "Lipstick", 100));
        makeupItems.push(MakeupItem(2, "Eyeshadow", 150));
        makeupItems.push(MakeupItem(3, "Foundation", 250));
        makeupItems.push(MakeupItem(4, "Blush", 500));
    }

    // Override decimals to make tokens non-fractional
    function decimals() public view virtual override returns (uint8) {
        return 0;
    }

    // Mint tokens (only owner can mint)
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    // Burn tokens
    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    // Redeem tokens for a makeup item
    function redeem(uint256 itemId) external {
        require(itemId > 0 && itemId <= makeupItems.length, "Invalid item ID");
        MakeupItem memory item = makeupItems[itemId - 1];
        require(balanceOf(msg.sender) >= item.cost, "Insufficient tokens");

        // Deduct tokens and assign item to user
        _burn(msg.sender, item.cost);
        ownedMakeupItems[msg.sender].push(item);

        emit ItemRedeemed(msg.sender, item.id, item.name, item.cost);
    }

    // Transfer tokens (explicitly defined)
    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        require(to != address(0), "Transfer to the zero address");
        require(amount > 0, "Transfer amount must be greater than zero");

        // Call the parent implementation for transferring tokens
        super.transfer(to, amount);

        emit TokensTransferred(msg.sender, to, amount);
        return true;
    }

    // Get all available makeup items
    function getMakeupItems() external view returns (MakeupItem[] memory) {
        return makeupItems;
    }

    // Get items owned by the caller
    function getOwnedItems() external view returns (MakeupItem[] memory) {
        return ownedMakeupItems[msg.sender];
    }
}
