require("@nomicfoundation/hardhat-toolbox");
require("@nomicfoundation/hardhat-chai-matchers");
require("@nomiclabs/hardhat-ethers");
require("dotenv").config();

task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  defaultNetwork: "ganache",
  networks: {
    ganache:{
      url: process.env.GANACHE_URL,
      accounts: [process.env.GANACHE_ACC1_KEY],
      // gas: 3000000,
      // gasPrice: 8000000000,
    },

    hardhat: {
      chainId: 1337,
    },

    BSCtestnet: {
      url: process.env.BSC_TESTNET_URL,
      chainId: 97,
      accounts: [process.env.BSC_PRIVATE_KEY],
    },

  },

  etherscan: {
    apiKey: process.env.BSC_SCAN_KEY
  },
};
