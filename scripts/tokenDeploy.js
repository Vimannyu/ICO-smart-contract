const { ethers, contract } = require("hardhat");
const { Bytecode } = require("hardhat/internal/hardhat-network/stack-traces/model");

async function main() {

  const [wallet] = await hre.ethers.getSigners();


  const Token = await ethers.getContractFactory("ZEROToken");
  let token = await Token.deploy(" ZeroToken", "ZERO", 18 ,100000000);
 token =  await token.deployed();
  console.log("Token address:", token.address);


  const walletAddress = wallet.address ; 
  
  console.log(typeof(walletAddress))
 // const  TOKEN =  token.address ;
  //console.log(typeof(TOKEN));
 //console.log(ethers.utils.isAddress(TOKEN));
  const rate = 300000;

  const tokenSale = await ethers.getContractAt("ZEROtokenSale");
  const deployICO = await tokenSale.deploy(rate, walletAddress, token.address);
 await deployICO.deployed();
  console.log(tokenSale.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
