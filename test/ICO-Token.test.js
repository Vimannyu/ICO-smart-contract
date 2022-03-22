const {expect} = require('chai');
const { ethers } = require('hardhat');

describe("ERC20 Token testing" , function () {

    it('Checking the name if the token has the correct name' , async function () {


        const token = await ethers.getContractFactory("Token");
        const deptoken =  await token.deploy( 'VimToken' , 'VIM' ,100000000 , 18 );
        deptoken.deployed();

        expect(await deptoken.getName()).to.equal("VimToken");
        expect(await deptoken.getSymbol()).to.equal('VIM');
        expect(await deptoken.getTotalSupply()).to.equal(100000000);
        expect(await deptoken.getDecimal()).to.equal(18);

    })


});