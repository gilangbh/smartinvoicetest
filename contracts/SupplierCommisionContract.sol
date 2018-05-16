pragma solidity ^0.4.0;
import "./CredentialManager.sol";

contract SupplierCommisionContract {
    enum RateType {NONE, FLAT_RATE, DYNAMIC_RATE}
    
    uint256 constant public decimals = 3;
    CredentialManager private credentialManager;
    bool private isCredentialManagerSet = false;

    mapping(address => uint256) private rate;
    mapping(address => RateType) private rateType;
    
    mapping(address => uint256) private rateProposal;
    mapping(address => RateType) private rateTypeProposal;

    event SupplierCommisionStatus(string proposalStatus, address supplier);

    function SupplierAdminContract(CredentialManager credmgr) {
    	require(isCredentialManagerSet == false);
	    credentialManager = credmgr;
	    isCredentialManagerSet = true;
    }
    
    //be careful when reading rate in regard to contract's decimals value
    function getRate(address supplier) public constant returns (uint256, RateType) {
        require(credentialManager.isInRole(0,msg.sender) || 
            (msg.sender == supplier && credentialManager.isInRole(1,msg.sender)));
            
        return (rate[supplier], rateType[supplier]);
    }

    //be carefule when setting rate in regard to contract's decimals value
    function setRate(address supplier, uint256 newRate, RateType newRateType) public {
        require(credentialManager.isInRole(0,msg.sender));
        require(credentialManager.isInRole(1,supplier));
        require(newRate > 0 && newRateType != RateType.NONE);
        rate[supplier] = newRate;
        rateType[supplier] = newRateType;
        SupplierCommisionStatus("rateChanged", supplier);
    }
    
    //be carefule when setting rate in regard to contract's decimals value
    function proposeRate(address supplier, uint256 newRate, RateType newRateType) public {
        require(credentialManager.isInRole(0,msg.sender));
        require(credentialManager.isInRole(1,supplier));
        require(newRate > 0 && newRateType != RateType.NONE);
        rateProposal[supplier] = newRate;
        rateTypeProposal[supplier] = newRateType;
        SupplierCommisionStatus("proposalAdded", supplier);
    }
    
    //be careful when reading rate in regard to contract's decimals value
    function getRateProposal(address supplier) public constant returns (uint256, RateType) {
        require(credentialManager.isInRole(0,msg.sender) || 
            (msg.sender == supplier && credentialManager.isInRole(1,msg.sender)));
            
        return (rateProposal[supplier], rateTypeProposal[supplier]);
    }
    
    function acceptRateProposal() public {
        require(credentialManager.isInRole(1,msg.sender));
        
        address supplier = msg.sender;
        rate[supplier] = rateProposal[supplier];
        rateType[supplier] = rateTypeProposal[supplier];
        
        assert(rate[supplier] == rateProposal[supplier] && rateType[supplier] == rateTypeProposal[supplier]);
	    assert(rate[supplier] > 0 && rateTypeProposal[supplier] != RateType.NONE);
        rateTypeProposal[supplier] = RateType.NONE;
        rateProposal[supplier] = 0; 

        SupplierCommisionStatus("proposalAccepted", supplier);
    }

    function rejectRateProposal() public {
        require(credentialManager.isInRole(1,msg.sender));
        
        address supplier = msg.sender;
        rateTypeProposal[supplier] = RateType.NONE;
        rateProposal[supplier] = 0; 

        SupplierCommisionStatus("proposalRejected", supplier);
    }
}
