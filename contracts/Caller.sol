//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

// import "./StorageContractA.sol";
import "./Procxy.sol";

contract Caller {

    address public storageMethods;
    Proxy public proxy;

    constructor(address _storageMethod) {
        proxy = new Proxy(_storageMethod);
    }

    // function test() public returns () {

    //     // Set value via Caller using delegateTo
    //     bytes memory setValueData = abi.encodeWithSignature("setValue(string)", "Hello, World!");
    //     proxy.delegateTo(setValueData);

    //     // Get value via Caller using delegateTo
    //     bytes memory getValueData = abi.encodeWithSignature("getValue()");
    //     bytes memory result = caller.delegateTo(getValueData);
    //     string memory value = abi.decode(result, (string));

    //     // Now value should be "Hello, World!"
    //     require(keccak256(bytes(value)) == keccak256(bytes("Hello, World!")), "Incorrect value");
    // }

    function getStringAValue() public view returns (string memory) {

        // Get value via Caller using delegateTo
        bytes memory getValueData = abi.encodeWithSignature("stringAvalue1()");
        bytes memory result = proxy.delegateTo(getValueData);
        string memory value = abi.decode(result, (string));

        return value;

        // // Define the function signature for the stringAvalue1() getter
        // bytes memory payload = abi.encodeWithSignature("stringAvalue1()");

        // // Make the call to the contract
        // (bool success, bytes memory returnData) = stotageContractAddress.staticcall(payload);
        // require(success, "Call failed");

        //  // Decode the returned data
        // return abi.decode(returnData, (string));
    }
}

/**
function getStringAValue(address stotageContractAddress) public view returns (string memory) {
        // Define the function signature for the stringAvalue1() getter
        bytes memory payload = abi.encodeWithSignature("stringAvalue1()");

        // Make the call to the contract
        (bool success, bytes memory returnData) = stotageContractAddress.staticcall(payload);
        require(success, "Call failed");

         // Decode the returned data
        return abi.decode(returnData, (string));
    }

        function getUnknowVariable(address stotageContractAddress) public view returns (string memory) {
        // Define the function signature for the stringAvalue1() getter
        bytes memory payload = abi.encodeWithSignature("stringAvalue5()");

        // Make the call to the contract
        (bool success, bytes memory returnData) = stotageContractAddress.staticcall(payload);
        require(success, "Call failed");

         // Decode the returned data
        return abi.decode(returnData, (string));
    }
*/