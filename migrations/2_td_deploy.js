const Str = require('@supercharge/strings')
// const BigNumber = require('bignumber.js');

var Q2Erc20 = artifacts.require("Thf_A_ERC20.sol");


module.exports = (deployer, network, accounts) => {
    deployer.then(async () => {
        await deployErc20(deployer, network, accounts); 
        await deployRecap(deployer, network, accounts); 
    });
};

async function deployErc20(deployer, network, accounts) {
	Q2contract = await Q2Erc20.new(web3.utils.toBN("920046364000000000000000000"))
}

async function deployRecap(deployer, network, accounts) {
	console.log("Thf_A_ERC20 Contract (Q2) : " + Q2contract.address)
}

//Nb : truffle migrate --f 2 --to 2 --network goerli