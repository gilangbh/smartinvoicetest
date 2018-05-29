pragma solidity ^0.4.16;

import "./Chainy.sol";

contract Verification {
    mapping (string => address) invoiceBuyer;
    mapping (string => address) invoiceAdminVerifier;

    mapping (string => address) rejectedByBuyer;
    mapping (string => address) rejectedByAdmin;

    Chainy private chainy;
    bool private isChainySet;
    
    event VerificationStatusEvent(string chainy, bool verificationStatus, bool isAccepted);

    function Verification() public {
        
    }

    function setChainy(address _chainyAddress) {
        require(!isChainySet);
        chainy = Chainy(_chainyAddress);
        isChainySet = true;
    }

    function verifyFromBuyer(string _chainy, address _buyer) public {
        invoiceBuyer[_chainy] = _buyer;
        
        VerificationStatusEvent(_chainy, getVerificationStatus(_chainy),true); 
    }

    function verifyFromAdmin(string _chainy, address _admin) public {
        invoiceAdminVerifier[_chainy] = _admin;
        
        VerificationStatusEvent(_chainy, getVerificationStatus(_chainy),true);
    }

    
    function rejectFromBuyer(string _chainy, address _buyer) public {
        invoiceBuyer[_chainy] = 0x0;
        rejectedByBuyer[_chainy] = _buyer;
        
        VerificationStatusEvent(_chainy, getVerificationStatus(_chainy),false); 
    }

    function rejectFromAdmin(string _chainy, address _admin) public {
        invoiceAdminVerifier[_chainy] = 0x0;
        rejectedByAdmin[_chainy] = _admin;
        
        VerificationStatusEvent(_chainy, getVerificationStatus(_chainy),false);
    }

    function getVerificationStatus(string _chainy) public constant returns(bool) {
        if(invoiceBuyer[_chainy] != 0x0 && invoiceAdminVerifier[_chainy] != 0x0) {
            return true;
        }
        return false;
    }
}
