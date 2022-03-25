// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/crowdsale/Crowdsale.sol";
import "@openzeppelin/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "@openzeppelin/contracts/crowdsale/validation/CappedCrowdsale.sol";

contract tokenSale is Crowdsale, MintedCrowdsale, CappedCrowdsale {
    uint256 private minWeiForOnePreToken = 3333;
    uint256 private minWeiForOneSeedToken = 6666;

    enum ICOStages {
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

function setStage(uint256 _stage) public onlyOwner {
    if (uint256(ICOStages.preSale) == _stage) {
        stage = ICOStages.preICO;
    } else if (uint256(ICOStages.seedSale) == _stage) {
        stage = ICOStages.seedSale;
    } else {
        stage = ICOStages.finalSale;
    }
}


   function rateCalculation() internal view returns (uint256) {
        if(stage == ICOStageS.preSale){
            return 300000;
        } else if(stage == ICOStage.seedSale){
            return 150000;
        } else if(stage == ICOStages.finalSale){
            return 600000;  
        }
    }
    function grtRate() public view returns (uint256) {
        return rateCalculation();
    }