var Chainy = artifacts.require("./Chainy.sol");
//var SimpleStorage = artifacts.require("./SimpleStorage.sol");
var Verification = artifacts.require("./Verification.sol");
var InvoiceToken = artifacts.require("./InvoiceToken.sol");
var CredentialManager = artifacts.require("./CredentialManager.sol");

module.exports = function(deployer) {
  deployer.deploy(Chainy);
  //deployer.deploy(SimpleStorage);
  deployer.deploy(Verification);
  deployer.deploy(InvoiceToken);
  deployer.deploy(CredentialManager);
};
