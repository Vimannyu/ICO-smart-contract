// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/crowdsale/Crowdsale.sol";
import "@openzeppelin/contracts/ownership/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ZEROtokenSale is Crowdsale, Ownable , IERC20{
//configuring different stages of ICO
    enum ICOsale {
        preSale,
        seedSale,
        finalSale
    }

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
            _rate = 300000;
            if (_getTokenAmount(weiRaised()) >= 30000000) {
                stage = ICOsale.seedSale;
            }
        } else if (stage == ICOsale.seedSale) {
            _rate = 150000;
            if (_getTokenAmount(weiRaised()) >= 50000000) {
                stage == ICOsale.finalSale;
            }
        } else {
            _rate = 100000; // assuming the final stage rate.
        }
    }

    /*this function can end the ICO crowdsale without losing any ether but if you want to still use this smart contract in future you can use delegate call to transfer this contract to another.   */
    function endSale() public onlyOwner {
        require(stage == ICOsale.finalSale, "Not in the final stage");
        _forwardFunds();
        selfdestruct(msg.sender);
    }
}
