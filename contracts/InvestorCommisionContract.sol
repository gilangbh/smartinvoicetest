pragma solidity ^0.4.0;
import "./SafeMath.sol";
import "./CredentialManager.sol";

contract InvestorCommisionContract {
    using SafeMath for uint256;
    enum RateType {NONE, FLAT_RATE, DYNAMIC_RATE}
    
    uint256 constant public decimals = 3;
    CredentialManager private credentialManager;
    bool private isCredentialManagerSet = false;

    mapping(address => uint256) private rate;
    mapping(address => RateType) private rateType;
    
    mapping(address => uint256) private rateProposal;
    mapping(address => RateType) private rateTypeProposal;
    
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
    
    //be careful when reading rate in regard to contract's decimals value
    function getFee(address investor, uint256 val) public constant returns (uint256) {
    	require(credentialManager.isInRole(0,msg.sender) || 
            (msg.sender == investor && credentialManager.isInRole(3,msg.sender)));
        
        uint256 fee;
        RateType _;
        
        if(rateType[investor] == RateType.FLAT_RATE){
            (fee, _) = getRate(investor);
        } else {
            uint256 _rate;
            (_rate, _) = getRate(investor);
            _rate = _rate.div(100);
            fee = val.mul(_rate);
        }
        
        assert(fee >= 0);
        return fee;
    }
    
    //be carefule when setting rate in regard to contract's decimals value
    function proposeRate(address investor, uint256 newRate, RateType newRateType) public {
        require(credentialManager.isInRole(0,msg.sender));
        require(credentialManager.isInRole(3,investor));
        
        rateProposal[investor] = newRate;
        rateTypeProposal[investor] = newRateType;
	assert(rateProposal[investor] >= 0);
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
	require(rateTypeProposal[investor] != RateType.NONE && rateProposal[investor] > 0);
        rate[investor] = rateProposal[investor];
        rateType[investor] = rateTypeProposal[investor];
        
        assert(rate[investor] == rateProposal[investor] && rateType[investor] == rateTypeProposal[investor]);
	assert(rate[investor] >= 0);
        rateTypeProposal[investor] = RateType.NONE;
        rateProposal[investor] = 0; 
    }
}
