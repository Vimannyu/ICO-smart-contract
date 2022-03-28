require("dotenv").config();

require("@nomiclabs/hardhat-etherscan");
require("@nomiclabs/hardhat-waffle");
require("hardhat-gas-reporter");
require("solidity-coverage");

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: {
    compilers: [
      {
        version: "0.5.0",
      },
      {
        version: "0.5.5"

      },
      {
        version : "5.6.0"
      },
      {
        version: "0.9.0",
        settings: {},
      },
    ],
  },
  networks: {
    ropsten: {
      url: process.env.ROPSTEN_URL || "https://eth-ropsten.alchemyapi.io/v2/1ooKqDonNey5ZT-fCR2Ag7MfhtQPttxa",
      accounts:
PRIVATE_KEY=['14db4132a8b9eeb87be6ade92fd4854b783e5ee7b60da8ffb9995645b21c77cf' , "16c568563fc6f4f0bdb70a9f9231b1fdc1df34b26e24bd6a80da80d2e01d011b"]
//process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [""],
    },
  },
  gasReporter: {
    enabled: process.env.REPORT_GAS !== undefined,
    currency: "USD",
  },
  etherscan: {
    apiKey: 'X7DNSNA4P2W397T3TYH8E7UPA75ZAHQZNA',
  },
};
