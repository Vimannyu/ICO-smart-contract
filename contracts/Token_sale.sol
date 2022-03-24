// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/crowdsale/Crowdsale.sol";
import "@openzeppelin/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "@openzeppelin/contracts/crowdsale/validation/CappedCrowdsale.sol";

contract tokenSale is Crowdsale, MintedCrowdsale, CappedCrowdsale {
    uint256 private minWeiForOnePreToken = 3333;
    uint256 private minWeiForOneSeedToken = 6666;

    enum ICOStageS {
        preSale,
        seedSale,
        finalSale
    }

    ICOStages public stage = ICOStages.preSale;

    function investorMinCap() internal view returns (uint256) {
        if (stage == ICOStages.preSale) {
            return minWeiForOnePreToken;
        } else {
            return minWeiForOneSeedToken;
        }
    }

    uint256 public investorMaxCap = 100000000000000000000;

    constructor(
        uint256 _rate,
        address _wallet,
        ERC20 _token,
        uint256 _cap
    ) public Crowdsale(_rate, _wallet, _token) CappedCrowdsale(_cap) {}
}
