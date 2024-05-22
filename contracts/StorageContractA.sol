//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract StorageContractA { 
   bytes32 private constant IMPLEMENTATION_KEY = keccak256("set.implementation.initiator");

    string public stringAvalue1 = "string value of A 1";
    string public stringAvalue2 = "string value of A 2";
    string public stringAvalue3 = "string value of A 3";


    function setImplementation(address _implementation) public {
        // calleeAddress = _implementation;
        bytes32 key = IMPLEMENTATION_KEY;
        assembly {
            sstore(key, _implementation)
        }
    }

    function setStringAValue1(string memory value) public {
        stringAvalue1 = value;
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