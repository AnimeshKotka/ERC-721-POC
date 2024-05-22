//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "./StorageContractA.sol";

contract StorageContractMethod { 
    StorageContractA public storageContractAInstance;

    function getStorageContractA() public view returns(string memory) {
        return storageContractAInstance.stringAvalue1();
    }


    function getStorageContractB() public view returns (string memory) {
        bytes memory getValueData = abi.encodeWithSignature("stringBvalue1()");
        (bool success, bytes memory returnData) = address(storageContractAInstance).staticcall(getValueData);
        require(success, "Call to get stringBvalue1 failed");
        string memory value = abi.decode(returnData, (string));
        return value;
    }

    function setStorageContractA(string memory value) public {
        storageContractAInstance.setStringAValue1(value);
    }

    // Set the address of the existing StorageContractA instance
    function setStorageContractAInstance(address payable  _storageContractAAddress) public {
        storageContractAInstance = StorageContractA(_storageContractAAddress);
    }

    //     function setStorageContractB(string memory value) public {
    //     stringBvalue1 = value;
    // }
}
