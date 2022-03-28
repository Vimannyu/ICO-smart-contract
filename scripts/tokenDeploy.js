const { ethers } = require("hardhat");

async function main() {

  const [wallet, owner, ...address] = await ethers.getSigners();

  const Token = await ethers.getContractFactory("ZEROToken");
  let token = await Token.deploy(" ZeroToken", "ZERO", 9 ,ethers.BigNumber.from(100000000));
 token =  await token.deployed();
  console.log("Token address:", token.address);
  const exp = ethers.BigNumber.from("10").pow(19);
const capval= ethers.BigNumber.from("10").mul(exp);
const goalval= ethers.BigNumber.from("5").mul(exp);


  const walletAddress = wallet.address; 
  console.log(walletAddress)
  const TOKEN = token.address;
  console.log(TOKEN)
  const cap = capval;
  console.log(cap);
  const goal = goalval;
  console.log(goal);
  const rate = 300000;

  const tokenSale = await ethers.getContractAt("ZEROtokenSale");
  const deployICO = await tokenSale.deploy(rate, walletAddress, TOKEN , cap , goal);
  deployICO.deployed();
  console.log(tokenSale.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
