// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/crowdsale/Crowdsale.sol";
import "@openzeppelin/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "@openzeppelin/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "@openzeppelin/contracts/crowdsale/distribution/RefundableCrowdsale.sol";

contract tokenSale is Crowdsale, MintedCrowdsale, CappedCrowdsale {
    
    
    uint256 private minTokenPreSaleCap = 30000000 * (10**(token.decimals()));     // in TOKENbits
    uint256 private minTokenSeedSaleCap = 50000000 * (10**(token.decimals()));
    uint256 private minWeiAmountForPreSale = 3337;  //min wei amouint to buy 1 token during presale.
    uint256 private minWieAmountForSeedSale = 6667; //min wei amouint to buy 1 token during seedsale.

    enum ICOStages {
        preSale,
        seedSale
    }

    ICOStages public stage = ICOStages.preSale; // Default stage

    uint256  public investorMinCap ;

    constructor(
        uint256 _rate,
        address _wallet,
        ERC20 _token,
        uint256 _cap
    ) public Crowdsale(_rate, _wallet, _token) CappedCrowdsale(_cap) {}


    
}

function setStage(uint value) public onlyOwner {

  ICOStages _stage;

      if (uint(ICOStages.preSale) == value) {
        _stage = ICOStages.preSale;
      } else if (uint(ICOStages.seedSale) == value) {
        _stage = ICOStages.seedSale;
      }

      stage = _stage;

      if (stage == ICOStages.preSale) {
        setRate(300000);  // 1 wei will give 300000 TOKENbits 
      } else if (stage == ICOStages.seedSale) {
        setRate(150000); // 1 wei will give 150000 TOKENbits
      }
  }

  function setRate(uint256 _rate) private {
      rate = _rate;
  }
    



function ICOflow() public {
    


}