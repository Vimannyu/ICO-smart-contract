const {expect} = require('chai');
const { ethers } = require('hardhat');
const { describe } = require('yargs');

describe("ERC20 Token testing" , function () {

    it('Checking the attributes of the token' , async function () {


        const token = await ethers.getContractFactory("ZEROToken");
        const deptoken =  await token.deploy( 'VimToken' , 'VIM' ,100000000 , 18 );
        deptoken.deployed();

        expect(await deptoken.getName()).to.equal("VimToken");
        expect(await deptoken.getSymbol()).to.equal('VIM');
        expect(await deptoken.getTotalSupply()).to.equal(100000000);
        expect(await deptoken.getDecimal()).to.equal(18);

    })


});