const {expect} = require('chai');
const { ethers } = require('hardhat');
const { utils } = require('web3');
const BigNumber = web3.BigNumber;

const rate = 
 wallet = wallet.address;
const token = token.address;
const cap =  utils.parseEther('1000'); // we will get the value in wei 
const goal = utils.parseEther('500');  // the goal of the organisation to reach by creating ICO.


beforeEach(async function () {
    const token = await ethers.getContractFactory("ZEROToken");
   const  tokenSale = await ethers.getContractFactory("ZEROtokenSale");
    [wallet, owner , addr1, addr2, ...addrs] = await ethers.getSigners();
    deployedTokenSale = await tokenSale.deploy(rate , wallet , token , cap , goal);
    deployedTokenSale.deployed(); 
  });

  describe("Deployment", function () {
    it("Should set the right owner", async function () {
      expect(await deployedToken.owner()).to.equal(owner.address);
    });
});

describe("Deployment", function () {
    it("Should set the right wallet", async function () {
      expect(await deployedToken.wallet()).to.equal(wallet.address);
    });
});

describe('ZEROToken Crowdsale ', function() {
    it('tracks the rate', async function() {
    expect(await deployedToken.rate()).to.equal(rate);
    });

 
  });