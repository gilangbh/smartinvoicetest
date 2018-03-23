pragma solidity ^0.4.18;

import "./ERC721Token.sol";

contract InvoiceToken is ERC721Token {
    
    string constant private TOKENNAME = "Invoice Token";
    string constant private TOKENSYMBOL = "INV";
    mapping (uint256 => string) private tokenLinks;

    function InvoiceToken () {

    }
    
    function mint(address _to, uint256 _tokenId) public {
        super._mint(_to, _tokenId);
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
    
   function tokenMetadata(uint256 _tokenId) constant returns (string chainyUrl) {
       return tokenLinks[_tokenId];
   }
}