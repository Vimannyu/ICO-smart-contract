// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/crowdsale/Crowdsale.sol";
import "@openzeppelin/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "@openzeppelin/contracts/crowdsale/distribution/RefundableCrowdsale.sol";
import "./ICO-Token.sol";

contract ZEROtokenSale is Crowdsale, CappedCrowdsale, RefundableCrowdsale  {
    uint256 private minTokenPreSaleCap = 30000000 * (10**(Token.getDecimal())); // in TOKENbits
    uint256 private minTokenSeedSaleCap = 50000000 * (10**(Token.getDecimal()));
    uint256 private minWeiAmountForPreSale = 3337; //min wei amouint to buy 1 token during presale.
    uint256 private minWeiAmountForSeedSale = 6667; //min wei amouint to buy 1 token during seedsale.
    uint256 public totalWeiRaisedDuringSeedICO;
    uint256 public totalWeiRaisedDuringPreICO;
    uint256 private finalSaleRemainingTokens;
    enum ICOStages {
        preSale,
        seedSale,
        finalSale
    }

    ZEROToken Token;

    ICOStages public stage = ICOStages.preSale; // Default stage

    constructor(
        uint256 _rate,
        address payable _wallet,
        ERC20 _token,
        uint256 _cap,
        uint256 _goal
    )
        public
        Crowdsale(_rate, _wallet, _token)
        CappedCrowdsale(_cap)
        RefundableCrowdsale(_goal)
    {
        require(_goal <= _cap);
    }

    function setStage(uint256 value) public {
        ICOStages _stage;

        if (uint256(ICOStages.preSale) == value) {
            _stage = ICOStages.preSale;
        } else if (uint256(ICOStages.seedSale) == value) {
            _stage = ICOStages.seedSale;
        }

        stage = _stage;

        if (stage == ICOStages.preSale) {
            setRate(300000); // 1 wei will give 300000 TOKENbits
        } else if (stage == ICOStages.seedSale) {
            setRate(150000); // 1 wei will give 150000 TOKENbits
        }
    }

    function setRate(uint256 _rate) private pure returns (uint256) {
        return _rate;
    }

    function setFinalStage(uint256 _rate) private {
        if (goalReached()) {
            stage = ICOStages.finalSale;
            setRate(_rate);
            finalSaleRemainingTokens = 20000000 * (10**(Token.getDecimal()));
            buyTokens(msg.sender);
            _forwardFunds();
        }
    }

    function fundTransfer(uint256 _minInvestorAmount) external payable {
        if (stage == ICOStages.preSale) {
            require(
                _minInvestorAmount >= minWeiAmountForPreSale,
                "Investor amount is less to invest in presal ICO"
            );
            buyTokens(msg.sender);
            totalWeiRaisedDuringPreICO = totalWeiRaisedDuringPreICO.add(
                msg.value
            );
            require(
                _getTokenAmount(totalWeiRaisedDuringPreICO) <=
                    minTokenPreSaleCap
            );
            _forwardFunds();
        } else if (stage == ICOStages.seedSale) {
            require(
                _minInvestorAmount >= minWeiAmountForSeedSale,
                "Investor amount is less to invest in seedsale ICO"
            );
            buyTokens(msg.sender);
            totalWeiRaisedDuringSeedICO = totalWeiRaisedDuringSeedICO.add(
                msg.value
            );
            require(
                _getTokenAmount(totalWeiRaisedDuringSeedICO) <=
                    minTokenPreSaleCap
            );
            _forwardFunds();
        } else {
            setFinalStage(150000);
        }
    }

    function endCrowdSale(address payable account ) private {
        require(stage == ICOStages.finalSale, "Not in the final stage");
        claimRefund(account);


       
        
    }
}
