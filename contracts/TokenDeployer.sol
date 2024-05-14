//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "./TokenERC721.sol";

contract TokenDeployer {
    function mintToken(string memory _name, string memory _symbol, uint tokenId, address owner) public  returns(address) {
        address tokenAddr = address(new Token(
            _name,
            _symbol,
            tokenId,
            owner
        ));
        // Allowable(tokenAddr)
        return tokenAddr;
    }
}