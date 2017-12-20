pragma solidity ^0.4.15;

contract SimpleStorage {
    bytes32 public storageString;
    uint public storageInteger;
    bytes32[] storageArray;

    function SimpleStorage() {
        storageString = "Hello world!";
        storageInteger = 12345;
        storageArray.push("Hello");
        storageArray.push("World");
        storageArray.push("How are you");
        storageArray.push("Today");
    }

    function getStorageString() constant returns (bytes32) {
        return storageString;
    }
    
    function getStorageInteger() constant returns (uint) {
        return storageInteger;
    }

    function getStorageArray() constant returns (bytes32[4]) {
        bytes32[4] memory result;
        
        for (var index = 0; index < 4; index++) {
            result[index] = storageArray[index];
        }
        return result;
    }
}