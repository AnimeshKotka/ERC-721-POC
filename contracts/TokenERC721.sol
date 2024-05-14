//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Token is ERC721 {

  constructor(string memory _name, string memory _symbol, uint tokenId, address owner) ERC721(_name, _symbol) {
    mintNFT(tokenId, owner);
  }

  function mintNFT(uint256 tokenId, address to) internal   {
    _mint(to, tokenId);
  }  
}