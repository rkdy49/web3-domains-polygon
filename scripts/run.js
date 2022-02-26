const main = async () => {
    const [owner, randomPerson]  = await hre.ethers.getSigners();
    const domainContractFactory = await hre.ethers.getContractFactory('Domains');
    const domainContract = await domainContractFactory.deploy("jets");
    await domainContract.deployed();
    console.log("Contract deployed to:", domainContract.address);
    console.log("contract deployed by: ", owner)

    let txn = await domainContract.register("light",  {value: hre.ethers.utils.parseEther('0.1')});
    await txn.wait();

    const domainOwner = await domainContract.getAddress("light");
    console.log("owner of domain is: ", domainOwner);

    const balance = await hre.ethers.provider.getBalance(domainContract.address);
    console.log("Amount in contract", balance);

  };
  
  const runMain = async () => {
    try {
      await main();
      process.exit(0);
    } catch (error) {
      console.log(error);
      process.exit(1);
    }
  };
  
  runMain();