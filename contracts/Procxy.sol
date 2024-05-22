//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "./StorageContractA.sol";

contract Proxy is StorageContractA {
// address public calleeAddress;
    bytes32 private constant IMPLEMENTATION_KEY = keccak256("set.implementation.initiator");


    function setImplementation(address _implementation) public {
        // calleeAddress = _implementation;
        bytes32 key = IMPLEMENTATION_KEY;
        assembly {
            sstore(key, _implementation)
        }
    }

    // fallback() external payable {
    //     _delegate2();
    // }

    // receive() external payable {
    //     _delegate2();
    // }

    // function delegateTo(bytes memory data) public payable returns (bytes memory) {
    //     (bool success, bytes memory returnData) = calleeAddress.delegatecall(data);
    //     require(success, "Delegatecall failed");
    //     return returnData;
    // }

    // function _delegate() internal {
    //     require(calleeAddress != address(0), "Error");
    //     (bool success, bytes memory returnData) = calleeAddress.delegatecall(data);
    //     require(success, "Delegatecall failed");
    //     return returnData;
        
    //     assembly {
    //         let pointer := mload(0x40)
    //         // calldatacopy(pointer, 0, calldatasize)
    //         let result := delegatecall()
    //         // let size := returndatasize
    //         returndatacopy(pointer, 0, size)

    //         switch result
    //         case 0 { revert(pointer, size) }
    //         default { return(pointer, size) }
    //     }
    // }

    function getImplementation() public view returns (address _implementation) {
        bytes32 key = IMPLEMENTATION_KEY;
        assembly {
            _implementation := sload(key)
        }
    }


    /**
     * @dev Fallback function allowing to perform a delegatecall
     * Returns whatever the implementation call returns
     */
    fallback() payable external {
        address implementation = getImplementation();
        require(implementation != address(0), "ERROR_IMPLEMENTATION_NOT_FOUND");

        assembly {
            let pointer := mload(0x40)
            calldatacopy(pointer, 0, calldatasize())
            let result := delegatecall(gas(), implementation, pointer, calldatasize(), 0, 0)
            let size := returndatasize()
            returndatacopy(pointer, 0, size)

            switch result
            case 0 { revert(pointer, size) }
            default { return(pointer, size) }
        }
    }
}
