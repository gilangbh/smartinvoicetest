pragma solidity ^0.4.16;

import "./Chainy.sol";

contract Verification {
    mapping (string => address) invoiceBuyer;
    mapping (string => address) invoiceAdminVerifier;

    mapping (string => address) rejectedByBuyer;
    mapping (string => address) rejectedByAdmin;

    event VerifyEvent(string chainy, bool verified, address verifier);

    function Verification() public {
        
    }

    function verifyFromBuyer(string _chainy, address _buyer) public {
        invoiceBuyer[_chainy] = _buyer;
        
        VerifyEvent(_chainy,true,_buyer); 
    }

    function verifyFromAdmin(string _chainy, address _admin) public {
        invoiceAdminVerifier[_chainy] = _admin;
        
        VerifyEvent(_chainy, true, _admin);
    }

    
    function rejectFromBuyer(string _chainy, address _buyer) public {
        invoiceBuyer[_chainy] = 0x0;
        rejectedByBuyer[_chainy] = _buyer;
        
        VerifyEvent(_chainy, false, _buyer); 
    }

    function rejectFromAdmin(string _chainy, address _admin) public {
        invoiceAdminVerifier[_chainy] = 0x0;
        rejectedByAdmin[_chainy] = _admin;
        
        VerifyEvent(_chainy, false, _admin);
    }

    function getVerificationStatus(string _chainy) public constant returns(bool) {
        if (invoiceBuyer[_chainy] != 0x0 && invoiceAdminVerifier[_chainy] != 0x0){
            return true;
        }
        return false;
    }
}
