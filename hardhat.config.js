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
  defaultNetwork: "goerli",
  networks: {
    goerli: {
      url:process.env.GOERLI_URL,
      accounts: [process.env.GOERLI_ACC1],
    },

    hardhat: {
      chainId: 1337,
    },

  },

  etherscan: {
    apiKey: process.env.BSC_SCAN_KEY
  },
};
