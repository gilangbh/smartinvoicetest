var Chainy = artifacts.require("./Chainy.sol");
//var SimpleStorage = artifacts.require("./SimpleStorage.sol");
var Verification = artifacts.require("./Verification.sol");
var InvoiceToken = artifacts.require("./InvoiceToken.sol");
var CredentialManager = artifacts.require("./CredentialManager.sol");
var InvestorCommisionContract = artifacts.require("./InvestorCommisionContract.sol");
<<<<<<< HEAD
=======
var SupplierCommisionContract = artifacts.require("./SupplierCommisionContract.sol");
>>>>>>> 0bec0d2854cc98a0bdd67bda9ea776499618a0bc

module.exports = function(deployer) {
  deployer.deploy(Chainy);
  deployer.deploy(Verification);
  deployer.deploy(CredentialManager);
  deployer.deploy(InvoiceToken);
<<<<<<< HEAD
  deployer.deploy(InvestorCommisionContract, CredentialManager);
=======
  deployer.deploy(InvestorCommisionContract);
  deployer.deploy(SupplierCommisionContract)
>>>>>>> 0bec0d2854cc98a0bdd67bda9ea776499618a0bc
};
