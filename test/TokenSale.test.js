const { expect } = require("chai");
const { ethers } = require("hardhat");
const { describe } = require('yargs');
const BigNumber = web3.BigNumber;

const rate = 300000; //hardcoding rate to test it .
const wallet = wallet;
const token = token.address;
const cap = ethers.utils.parseEther("1000"); // we will get the value in wei
//console.log(cap);
const goal = ethers.utils.parseEther("500"); // the goal of the organisation to reach by creating ICO.
//console.log(goal);


  // ICO Stages
  const preSale = 0;
  const preIcoRate = 300000;
  const  seedSale = 1;
  const icoRate = 150000;









beforeEach(async function () {
  const token = await ethers.getContractFactory("ZEROToken");
  const tokenSale = await ethers.getContractFactory("ZEROtokenSale");
  [wallet, owner, addr1, addr2, ...addrs] = await ethers.getSigners();
  deployedTokenSale = await tokenSale.deploy(rate, wallet, token, cap, goal);
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

describe("ZEROToken Crowdsale attributes", function () {
  it("tracks the rate", async function () {
    expect(await deployedToken.rate()).to.equal(rate);
  });
  it("testing the max capacity to send ether", async function () {
    expect(await deployedToken.cap).to.be.lessThanOrEqual(cap);
  });
});

it("testing the goal of the ICO", async function () {
  expect(await deployedToken.goal).to.be.lessThanOrEqual(goal);
});
