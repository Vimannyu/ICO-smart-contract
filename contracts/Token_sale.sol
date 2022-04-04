// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/crowdsale/Crowdsale.sol";
import "@openzeppelin/contracts/ownership/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ZEROtokenSale is Crowdsale, Ownable, IERC20 {
    //configuring different stages of ICO
    enum ICOsale {
        preSale,
        seedSale,
        finalSale
    }

    uint256 constant denominatorForpreSale = 10**4;
    uint256 constant denominatorForseedSale = 10**5;
    uint256 constant denominatorForfinalSale = 10**6;
    uint256 constant preRateBeforeDiv = 3;
    uint256 constant seedRateBeforeDiv = 16;
    uint256 constant finalRateBeforeDiv = 1;

    uint256 public ratepreSale = preRateBeforeDiv.div(denominatorForpreSale);
    uint256 public rateseedSale = seedRateBeforeDiv.div(denominatorForseedSale);
    uint256 public ratefinalSale = finalRateBeforeDiv.div(denominatorForfinalSale);

    uint256 constant minWeiAmountToBuyOneTokenForPresale = 3335;
    uint256 constant minWeiAmountToBuyOneTokenForSeedsale = 6250;
    uint256 constant minWeiAmountToBuyOneTokenForFinalsale = 1000000;

    ICOsale public stage = ICOsale.preSale; // Default stage

    constructor(
        uint256 _rate,
        address payable _wallet,
        IERC20 _token
    ) public Crowdsale(_rate, _wallet, _token) {}

    /* This function sets the stage of the ICO like( presale ,seedsale ), only admin/owner can call this function and
this function also set the rate according to the stage of the ICO */
    function setStage(uint256 _stage) public onlyOwner {
        if (uint256(ICOsale.preSale) == _stage) {
            stage = ICOsale.preSale;
        } else if (uint256(ICOsale.seedSale) == _stage) {
            stage = ICOsale.seedSale;
        } else {
            stage = ICOsale.finalSale;
        }

        if (stage == ICOsale.preSale) {
            _rate = ratepreSale;
        } else if (stage == ICOsale.seedSale) {
            _rate = rateseedSale;
        } else {
            _rate = ratefinalSale; // assuming the final stage rate = 0.03.
        }
    }

    function _preValidatePurchase(address _beneficiary, uint256 _weiAmount)
       internal
    {
        super._preValidatePurchase(_beneficiary, _weiAmount);
         require(_weiAmount >= minWeiAmountToBuyOneTokenForPresale || _weiAmount>= minWeiAmountToBuyOneTokenForSeedsale ||  _weiAmount>= minWeiAmountToBuyOneTokenForFinalsale , "amount required to buy one token not fullfilled");
        
         require( _getTokenAmount(weiRaised()) >= 30000000, "there are still some preSales tokens to spend");
         setStage(1);
         require(_getTokenAmount(weiRaised()) >= 50000000, "there are still some seedSales tokens to spend");
         setStage(2);
         

    }

    /*this function can end the ICO crowdsale without losing any ether but if you want to still use this smart contract in future you can use delegate call to transfer this contract to another.   */
    function endSale() public onlyOwner {
        require(stage == ICOsale.finalSale, "Not in the final stage");
        _forwardFunds();
        selfdestruct(msg.sender);
    }
}
