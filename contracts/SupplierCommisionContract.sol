pragma solidity ^0.4.0;
import "./SafeMath.sol";
import "./CredentialManager.sol";

contract SupplierCommisionContract {
    using SafeMath for uint256;
    enum RateType {NONE, FLAT_RATE, DYNAMIC_RATE}
    
    uint256 constant public decimals = 3;
    CredentialManager private credentialManager;
    bool private isCredentialManagerSet = false;

    mapping(address => uint256) private rate;
    mapping(address => RateType) private rateType;
    
    mapping(address => uint256) private rateProposal;
    mapping(address => RateType) private rateTypeProposal;
    
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
    
    //be careful when reading rate in regard to contract's decimals value
    function getFee(address supplier, uint256 val) public constant returns (uint256) {
    	require(credentialManager.isInRole(0,msg.sender) || 
            (msg.sender == supplier && credentialManager.isInRole(1,msg.sender)));
        
        uint256 fee;
        RateType _;
        
        if(rateType[supplier] == RateType.FLAT_RATE){
            (fee, _) = getRate(supplier);
        } else {
            uint256 _rate;
            (_rate, _) = getRate(supplier);
            _rate = _rate.div(100);
            fee = val.mul(_rate);
        }
        
        assert(fee >= 0);
        return fee;
    }
    
    //be carefule when setting rate in regard to contract's decimals value
    function proposeRate(address supplier, uint256 newRate, RateType newRateType) public {
        require(credentialManager.isInRole(0,msg.sender));
        require(credentialManager.isInRole(1,supplier));
        
        rateProposal[supplier] = newRate;
        rateTypeProposal[supplier] = newRateType;
	assert(rateProposal[supplier] >= 0);
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
	require(rateTypeProposal[supplier] != RateType.NONE && rateProposal[supplier] > 0);

        rate[supplier] = rateProposal[supplier];
        rateType[supplier] = rateTypeProposal[supplier];
        
        assert(rate[supplier] == rateProposal[supplier] && rateType[supplier] == rateTypeProposal[supplier]);
	assert(rate[supplier] >= 0);
        rateTypeProposal[supplier] = RateType.NONE;
        rateProposal[supplier] = 0; 
    }
}
