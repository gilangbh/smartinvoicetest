var Chainy = artifacts.require("./Chainy.sol");
//var SimpleStorage = artifacts.require("./SimpleStorage.sol");
var Verification = artifacts.require("./Verification.sol");

module.exports = function(deployer) {
  deployer.deploy(Chainy);
  //deployer.deploy(SimpleStorage);
  deployer.deploy(Verification);
};
