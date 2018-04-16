pragma solidity ^0.4.16;

contract Verification {
    mapping (string => address) invoiceBuyer;
    mapping (string => address) invoiceAdminVerifier;
    
    event VerificationStatusEvent(string chainy, bool verificationStatus);

    function Verification() public {

    }

    function verifyFromBuyer(string _chainy, address _buyer) public {
        invoiceBuyer[_chainy] = _buyer;
        
        VerificationStatusEvent(_chainy, getVerificationStatus(_chainy)); 
    }

    function verifyFromAdmin(string _chainy, address _admin) public {
        invoiceAdminVerifier[_chainy] = _admin;
        
        VerificationStatusEvent(_chainy, getVerificationStatus(_chainy));
    }

    function getVerificationStatus(string _chainy) public constant returns(bool) {
        if(invoiceBuyer[_chainy] != 0x0 && invoiceAdminVerifier[_chainy] != 0x0) {
            return true;
        }
        return false;
    }
}
