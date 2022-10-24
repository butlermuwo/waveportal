require("@nomicfoundation/hardhat-toolbox");

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
    solidity: "0.8.17",
    networks: {
      goerli: {
        url: "https://sly-practical-scion.ethereum-goerli.discover.quiknode.pro/2d3d90939cd0464adadbdcb1f461e6cb312696c7/",
        accounts: ["baf12133e52d9438f1e3246276f1aa364cf73a607d21b9f0c5ec109f675525d1"]
      },
    },
};
