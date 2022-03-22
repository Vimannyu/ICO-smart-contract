// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

import "hardhat/console.sol";

contract Token {
    string public name;
    string public symbol;
    uint256 public totalSupply;
    uint256 public decimal;

    constructor(
        string memory _name,
        string memory _symbol,
        uint256 _totalSupply,
        uint256 _decimal
    ) public {
        name = _name;
        symbol = _symbol;
        totalSupply = _totalSupply;
        decimal = _decimal;
    }

    function getName() public view returns (string memory) {
        return name;
    }

    function getSymbol() public view returns (string memory) {
        return symbol;
    }

    function getTotalSupply() public view returns (uint256) {
        return totalSupply;
    }

    function getDecimal() public view returns (uint256) {
        return decimal;
    }
}
