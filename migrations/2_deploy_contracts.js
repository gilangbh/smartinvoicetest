var Chainy = artifacts.require("./Chainy.sol");
//var SimpleStorage = artifacts.require("./SimpleStorage.sol");
var Verification = artifacts.require("./Verification.sol");
var InvoiceToken = artifacts.require("./InvoiceToken.sol");
var CredentialManager = artifacts.require("./CredentialManager.sol");
var InvestorCommisionContract = artifacts.require("./InvestorCommisionContract.sol");
var SupplierCommisionContract = artifacts.require("./SupplierCommisionContract.sol");

module.exports = function(deployer) {
  deployer.deploy(Chainy);
  deployer.deploy(Verification);
  deployer.deploy(CredentialManager);
  deployer.deploy(InvoiceToken);
  deployer.deploy(InvestorCommisionContract);
  deployer.deploy(SupplierCommisionContract)
};
