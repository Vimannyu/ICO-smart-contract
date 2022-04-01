const { expect } = require("chai");
const { ethers } = require("hardhat");

beforeEach(async function () {
  const Token = await ethers.getContractFactory("ZEROToken");
  const deptoken = await Token.deploy("ZeroToken", "ZERO", 18, 100000000);
  await deptoken.deployed();

  const tokenSale = await ethers.getContractAt("ZEROtokenSale");
 const [walletaddr] = await ethers.getSigners();
  console.log(wallet);


  const rate = 300000; //hardcoding rate to test it .
  const wallet = walletaddr.address;
  const ERCToken = deptoken.address;
  console.log(ERCToken);

  deployedTokenSale = await tokenSale.deploy(rate, wallet, ERCToken);
  deployedTokenSale.deployed();
});

// ICO Stages
const preSale = 0;
const preIcoRate = 300000;
const seedSale = 1;
const icoRate = 150000;

describe("Deployment", function () {
  it("Should set the right owner", async function () {
    expect(await deployedToken.owner()).to.equal(owner.address);
  });
});

describe("Deployment", function () {
  it("Should set the right wallet", async function () {
    expect(await deployedTokenSale.wallet()).to.equal(wallet.address);
  });
});

describe("ZEROToken Crowdsale attributes", function () {
  it("tracks the rate", async function () {
    expect(await deployedTokenSale.rate()).to.equal(rate);
  });

  describe("when the ICO stage is in PreSale", function () {
    beforeEach(async function () {
      // Crowdsale stage is already PreICO by default
      expect(await deployedTokenSale.buyTokens(addr2));
    });
  });
});

describe("crowdsale stages", function () {
  it("it starts in PreICO", async function () {
    const stage = await deployedTokenSale.stage();
    stage.should.be.bignumber.equal(preIcoRate);
  });

  it("starts at the preICO rate", async function () {
    const rate = await deployedTokenSale.rate();
    rate.should.be.bignumber.equal(preIcoRate);
  });

  it("allows admin to update the stage & rate", async function () {
    const stage = await deployedTokenSale.setStage(seedSale);

    stage.should.be.bignumber.equal(seedSale);
    const rate = await deployedTokenSale.rate();
    expect(await rate).to.equal(icoRate);
  });

  it("prevents non-admin from updating the stage", async function () {
    expect(await deployedTokenSale.setStage(preSale, { from: addr2 })).to.be
      .reverted;
  });
});
