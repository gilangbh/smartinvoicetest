pragma solidity ^0.4.0;
import "./CredentialManager.sol";

contract InvestorCommisionContract {
    enum RateType {NONE, FLAT_RATE, DYNAMIC_RATE}
    
    uint256 constant public decimals = 3;
    CredentialManager private credentialManager;
    bool private isCredentialManagerSet = false;

    mapping(address => uint256) private rate;
    mapping(address => RateType) private rateType;
    
    mapping(address => uint256) private rateProposal;
    mapping(address => RateType) private rateTypeProposal;

    event InvestorCommisionStatus(string proposalStatus, address investor);

    function InvestorAdminContract(CredentialManager credmgr) {
    	require(isCredentialManagerSet == false);
	    credentialManager = credmgr;
	    isCredentialManagerSet = true;
    }
    
    //be careful when reading rate in regard to contract's decimals value
    function getRate(address investor) public constant returns (uint256, RateType) {
        require(credentialManager.isInRole(0,msg.sender) || 
            (msg.sender == investor && credentialManager.isInRole(3,msg.sender)));
            
        return (rate[investor], rateType[investor]);
    }

    //be carefule when setting rate in regard to contract's decimals value
    function setRate(address investor, uint256 newRate, RateType newRateType) public {
        require(credentialManager.isInRole(0,msg.sender));
        require(credentialManager.isInRole(3,investor));
        require(newRate > 0 && newRateType != RateType.NONE);
        rate[investor] = newRate;
        rateType[investor] = newRateType;
        InvestorCommisionStatus("rateChanged", investor);
    }
    
    //be carefule when setting rate in regard to contract's decimals value
    function proposeRate(address investor, uint256 newRate, RateType newRateType) public {
        require(credentialManager.isInRole(0,msg.sender));
        require(credentialManager.isInRole(3,investor));
        require(newRate > 0 && newRateType != RateType.NONE);
        rateProposal[investor] = newRate;
        rateTypeProposal[investor] = newRateType;
        InvestorCommisionStatus("proposalAdded", investor);
    }
    
    //be careful when reading rate in regard to contract's decimals value
    function getRateProposal(address investor) public constant returns (uint256, RateType) {
        require(credentialManager.isInRole(0,msg.sender) || 
            (msg.sender == investor && credentialManager.isInRole(3,msg.sender)));
            
        return (rateProposal[investor], rateTypeProposal[investor]);
    }
    
    function acceptRateProposal() public {
        require(credentialManager.isInRole(3,msg.sender));
        
        address investor = msg.sender;
        rate[investor] = rateProposal[investor];
        rateType[investor] = rateTypeProposal[investor];
        
        assert(rate[investor] == rateProposal[investor] && rateType[investor] == rateTypeProposal[investor]);
	    assert(rate[investor] > 0 && rateTypeProposal[investor] != RateType.NONE);
        rateTypeProposal[investor] = RateType.NONE;
        rateProposal[investor] = 0; 

        InvestorCommisionStatus("proposalAccepted", investor);
    }

    function rejectRateProposal() public {
        require(credentialManager.isInRole(3,msg.sender));
        
        address investor = msg.sender;
        rateTypeProposal[investor] = RateType.NONE;
        rateProposal[investor] = 0; 

        InvestorCommisionStatus("proposalRejected", investor);
    }
}
