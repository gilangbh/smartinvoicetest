pragma solidity ^0.4.18;

import "./ERC721Token.sol";
import "./CredentialManager.sol";

contract InvoiceToken is ERC721Token {

    struct Invoice {
        string chainy;
        address supplier;
        address buyer;
        address investor;
        uint percentageFunding;
        uint percentageInterest;
        uint iCommision;
        uint sCommision;
    }
    
    string constant private TOKENNAME = "Invoice Token";
    string constant private TOKENSYMBOL = "INV";
    mapping (uint256 => Invoice) private invoiceMetadata;
    
    CredentialManager private credentialManager;
    bool private isCredentialManagerSet;
    mapping (uint256 => mapping(address => bool)) private invoiceAccess;
    
    event InvoiceMinted(uint tokenId, address supplier, address owner);

    function InvoiceToken () {
        isCredentialManagerSet = false;
    }

    function setCredentialManager(address _cred) public {
        require(!isCredentialManagerSet);
        credentialManager = CredentialManager(_cred);
        isCredentialManagerSet = true;
    }

    function mint(address _to, string _chainyCode, address _supplier, address _investor, address _buyer, uint _percentageFunding, uint _percentageInterest, uint _iCommision, uint _sCommision) public {
        require(msg.sender == _supplier);
        uint last = totalSupply();
        super._mint(_to, last);
        invoiceMetadata[last].chainy = _chainyCode;
        invoiceMetadata[last].supplier = _supplier;
        invoiceMetadata[last].buyer = _buyer;
        invoiceMetadata[last].investor = _investor;
        invoiceMetadata[last].percentageFunding = _percentageFunding;
        invoiceMetadata[last].percentageInterest = _percentageInterest;

        invoiceMetadata[last].iCommision = _iCommision;
        invoiceMetadata[last].sCommision = _sCommision;

        invoiceAccess[last][_supplier] = true;
        invoiceAccess[last][_investor] = true;
        invoiceAccess[last][_buyer] = true;
        InvoiceMinted(last,_supplier,_to);
    }

    function burn(uint256 _tokenId) public {
        super._burn(_tokenId);
    }

    function name() public constant returns (string) {
        return TOKENNAME;
    }

    function symbol() public constant returns (string) {
        return TOKENSYMBOL;
    }
    
    function tokenMetadata(uint256 _tokenId) public constant returns (string chainyUrl, address supplier, address investor, address buyer, uint percentageFunding, uint percentageInterest) {
        if (invoiceAccess[_tokenId][msg.sender] == true) {
            return 
            (
                invoiceMetadata[_tokenId].chainy,
                invoiceMetadata[_tokenId].supplier,
                invoiceMetadata[_tokenId].investor,
                invoiceMetadata[_tokenId].buyer,
                invoiceMetadata[_tokenId].percentageFunding,
                invoiceMetadata[_tokenId].percentageInterest
            );
        } else {
            require(credentialManager.isInRole(0,msg.sender));
            return 
            (
                invoiceMetadata[_tokenId].chainy,
                invoiceMetadata[_tokenId].supplier,
                invoiceMetadata[_tokenId].investor,
                invoiceMetadata[_tokenId].buyer,
                invoiceMetadata[_tokenId].percentageFunding,
                invoiceMetadata[_tokenId].percentageInterest
            );
        }
    }
}