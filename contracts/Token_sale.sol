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
    function setStage(uint256 _stage) internal {
        if (uint256(ICOsale.preSale) == _stage) {
            stage = ICOsale.preSale;
        } else if (uint256(ICOsale.seedSale) == _stage) {
            stage = ICOsale.seedSale;
        } else {
            stage = ICOsale.finalSale;
        }

        if (stage == ICOsale.preSale) {
            _rate = preRateBeforeDiv;
        } else if (stage == ICOsale.seedSale) {
            _rate = seedRateBeforeDiv;
        } else {
            _rate = finalRateBeforeDiv; // assuming the final stage rate = 0.03.
        }
    }

    function _getTokenAmount(uint256 weiAmount, uint256 denominator)
        internal
        view
        returns (uint256)
    {
        return (weiAmount.mul(_rate)).div(denominator);
    }

    function _preValidatePurchase(address _beneficiary, uint256 _weiAmount) 
        internal 
    {
        require(
            _weiAmount >= minWeiAmountToBuyOneTokenForPresale ||
                _weiAmount >= minWeiAmountToBuyOneTokenForSeedsale ||
                _weiAmount >= minWeiAmountToBuyOneTokenForFinalsale,
            "amount required to buy one token not fullfilled"
        );
        super._preValidatePurchase(_beneficiary, _weiAmount);

        if (_getTokenAmount(weiRaised(), denominatorForpreSale) >= 30000000) {
            setStage(1);
        } else if (
            _getTokenAmount(weiRaised(), denominatorForseedSale) >= 50000000
        ) {
            setStage(2);
        }
    }

    /*this function can end the ICO crowdsale without losing any ether but if you want to still use this smart contract in future you can use delegate call to transfer this contract to another.   */
    function endSale() public onlyOwner {
        require(stage == ICOsale.finalSale, "Not in the final stage");
        _forwardFunds();
        selfdestruct(msg.sender);
    }
}
