pragma solidity ^0.4.15;

contract CredentialManager {

    //0 - admin
    //1 - supplier
    //2 - buyer
    //3 - investor

    mapping(uint => mapping(address => bool)) private userRoles;

    function setRole(uint role, address user) {
        userRoles[role][user] = true;
    }

    function isInRole(uint role, address user) constant public returns (bool) {
        return userRoles[role][user];
    }
}