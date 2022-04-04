const { ethers, contract } = require("hardhat");
const { Bytecode } = require("hardhat/internal/hardhat-network/stack-traces/model");

async function main() {

  const [wallet] = await hre.ethers.getSigners();


  const Token = await ethers.getContractFactory("ZEROToken");
  let token = await Token.deploy(" ZeroToken", "ZERO", 18 ,100000000);
 token =  await token.deployed();
  console.log("Token address:", token.address);
 
const  Bytecode = "0x60566050600b82828239805160001a6073146043577f4e487b7100000000000000000000000000000000000000000000000000000000600052600060045260246000fd5b30600052607381538281f3fe73000000000000000000000000000000000000000030146080604052600080fdfea2646970667358221220ca4bcf7f2cd8e6c301403b2670e9870510a5b083a25411bf41dedcfedede806764736f6c63430008000033";

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
