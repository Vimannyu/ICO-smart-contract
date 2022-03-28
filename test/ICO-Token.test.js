const {expect} = require('chai');
const { ethers } = require('hardhat');
const { describe } = require('yargs');

describe("ERC20 Token testing" , function () {

    it('Checking the attributes of the token' , async function () {


        const token = await ethers.getContractFactory("ZEROToken");
        const deptoken =  await token.deploy( 'ZeroToken' , 'ZERO' ,100000000 , 9);
        deptoken.deployed();

        expect(await deptoken.getName()).to.equal("ZeroToken");
        expect(await deptoken.getSymbol()).to.equal('ZERO');
        expect(await deptoken.getTotalSupply()).to.equal(100000000);
        expect(await deptoken.getDecimal()).to.equal(9);

    })


});