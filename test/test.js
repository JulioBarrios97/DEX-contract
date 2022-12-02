const { expect, assert } = require("chai");
const hre = require("hardhat");

describe("Wallet Contract", () => {

  //---------Test the main function------------

  it("This should confirm that there are SLP tokens", async () => {
    const Wallet = await hre.ethers.getContractFactory("Wallet");
    this.wallet = await Wallet.deploy();

    await this.wallet.deployed();

    //------Aprobar el contato el ambos tokens a utilizar

    //-----Carga los datos de los token al contrato
    await this.wallet.mainFunction(
      "0xF820D59BAF6799063bE03367fA963454117aaDf3", //Token propio
      "0x07865c6E87B9F70255377e024ace6630C1Eaa37F", //USDC en Goerli
      10000000000000000000, //18 decimales
      10000000, //6 decimales
      9000000000000000000,
      9000000
    );

    var result = await this.wallet.sushiTokenBalance(); //Consulta el balance de SUSHI en el contrato

    assert.notEqual(result, 0);
  })

});
