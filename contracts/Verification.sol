pragma solidity ^0.4.16;

contract Verification {
    mapping (string => address) invoiceBuyer;
    mapping (string => address) invoiceAdminVerifier;

    function Verification() public {

    }

    function verifyFromBuyer(string _chainy, address _buyer) public {
        invoiceBuyer[_chainy] = _buyer;
    }

    function verifyFromAdmin(string _chainy, address _admin) public {
        invoiceAdminVerifier[_chainy] = _admin;
    }

    function getVerificationStatus(string _chainy) public constant returns(bool) {
        if(invoiceBuyer[_chainy] != 0x0 && invoiceAdminVerifier[_chainy] != 0x0) {
            return true;
        }
        return false;
    }
}