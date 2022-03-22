// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;
import "hardhat/console.sol";

import "@openzeppelin/contracts/token/ERC20/ERC20Detailed.sol";

contract Token is ERC20Detailed {
    constructor(
        string memory name,
        string memory symbol,
        uint8 decimals
    ) public ERC20Detailed(name, symbol, decimals) {}
}
