const {expect} = require('chai');
const { ethers } = require('hardhat');

describe("ERC20 Token testing" , function () {

    it('Checking the attributes of the token' , async function () {


        const token = await ethers.getContractFactory("ZEROToken");
        const deptoken =  await token.deploy( 'ZeroToken' , 'ZERO' , 18 , 100000000  );
         await deptoken.deployed();

        expect(await deptoken.name()).to.equal("ZeroToken");
        expect(await deptoken.symbol()).to.equal('ZERO');
        expect(await deptoken.totalSupply()).to.equal(100000000);
        expect(await deptoken.decimals()).to.equal(18);

    })


});