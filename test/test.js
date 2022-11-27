const { expect, assert } = require("chai");
const hre = require("hardhat");

describe("Wallet Contract", () => {

  //---------Test the main function------------

  it("This should confirm that there are SUSHI tokens", async () => {
    const Wallet = await hre.ethers.getContractFactory("Wallet");
    this.wallet = await Wallet.deploy();

    await this.wallet.deployed();

    const result = await this.wallet.sushiTokenBalance();
    expect(result.toNumber()).should.not.equal(0);
  })

});
