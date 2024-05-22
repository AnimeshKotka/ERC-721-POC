//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract StorageContractB { 
    bytes32 private constant IMPLEMENTATION_KEY = keccak256("set.implementation.initiator");

    string public stringBvalue1 = "string value 1 of contract B";
    string public stringBvalue2 = "string value 1 of contract B";
    string public stringBvalue3 = "string value 1 of contract B";


    function setStringBValue1(string memory value) public {
        stringBvalue1 = value;
    }

    function setImplementation(address _implementation) public {
        // calleeAddress = _implementation;
        bytes32 key = IMPLEMENTATION_KEY;
        assembly {
            sstore(key, _implementation)
        }
    }

    function getImplementation() public view returns (address _implementation) {
        bytes32 key = IMPLEMENTATION_KEY;
        assembly {
            _implementation := sload(key)
        }
    }

    fallback(bytes calldata data) payable external returns (bytes memory) {
        address implementation = getImplementation();
        require(implementation != address(0), "ERROR_IMPLEMENTATION_NOT_FOUND");
        
        (bool ok, bytes memory res) = implementation.call{value: msg.value}(data);
        require(ok, "call failed");
        return res;
    }
}