const hre = require("hardhat");

async function main() {
  const Wallet = await hre.ethers.getContractFactory("Wallet"); //  Recupera los archivos compilados
  const wallet = await Wallet.deploy(); //Despliega el contrato

  await wallet.deployed(); // Espera el Contrato deployado

  console.log("Wallet Contract deployed to:", wallet.address); //  Muestra por consola la direccion del contrato
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
