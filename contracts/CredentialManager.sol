pragma solidity ^0.4.15;

contract CredentialManager {

    //0 - admin
    //1 - supplier
    //2 - buyer
    //3 - investor

    mapping(uint => mapping(address => bool)) private userRoles;
    
    function CredentialManager() {
        //set initial admin
        userRoles[0][msg.sender] = true;
    }

    function setRole(uint role, address user) {
        require(isInRole(0, msg.sender)); //check whether the sender is admin
        userRoles[role][user] = true;
    }

    function isInRole(uint role, address user) constant public returns (bool) {
        return userRoles[role][user];
    }
}
