// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/crowdsale/Crowdsale.sol";
import "@openzeppelin/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "@openzeppelin/contracts/crowdsale/distribution/RefundableCrowdsale.sol";
import "./ICO-Token.sol";

/*for setting up the admin for the contract  */
contract Admin {
    address internal _admin;

    constructor() public {
        _admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == _admin, "Admin required");
        _;
    }
}

contract ZEROtokenSale is
    Crowdsale,
    CappedCrowdsale,
    RefundableCrowdsale,
    Admin
{
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

    /* This function sets the stage of the ICO like( presale ,seedsale ), only admin/owner can call this function and
this function also set the rate according to the stage of the ICO */
    function setStage(uint256 value) public onlyAdmin {
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

    /*this function sets ICO to finalstage and  takes in  the rate as an argument ,the admin can choose whatever the rate would be in finalstage */
    function setFinalStage(uint256 _rate) private onlyAdmin {
        if (goalReached()) {
            stage = ICOStages.finalSale;
            setRate(_rate);
            finalSaleRemainingTokens = 20000000 * (10**(Token.getDecimal()));
            buyTokens(msg.sender);
            _forwardFunds();
        }
    }

    /*this function checks weather in which stage yout contract is in and then when the certain validation meet the function deposit the fund to the wallet after each stage . */
    function fundTransfer(uint256 _minInvestorAmount)
        external
        payable
        onlyAdmin
    {
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

    /*this function can end the ICO crowdsale without losing any ether but if you want to still use this smart contract in future you can use delegate call to transfer this contract to another.   */
    function endCrowdSale(address payable account) private onlyAdmin {
        require(stage == ICOStages.finalSale, "Not in the final stage");
        claimRefund(account);
        selfdestruct(msg.sender);
    }
}
