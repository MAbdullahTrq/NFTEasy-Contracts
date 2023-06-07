// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./FactoryContract.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
contract NFTEasy is ERC721, ERC721URIStorage {
    address private contractOwner;
    address private contractFactory;
    mapping(uint256 => uint256) private tokenPrices;
    mapping(uint256 => uint256) private _tokenId;
    mapping(uint256 => bool) private listedForSale;

    event TokenListed(uint256 indexed tokenId, uint256 price);
    event TokenSold(uint256 indexed tokenId, address indexed buyer, uint256 price);

    constructor(string memory name, string memory symbol, address owner) ERC721(name, symbol) {
        contractOwner = owner;
        contractFactory = msg.sender;
    }

    function mintNFT(address to, uint256 tokenId) public {
        require(msg.sender == contractOwner, "NFTEasy: Only contract owner can mint NFTs");

        _safeMint(to, tokenId);
        
    }

    function setTokenURI(uint256 tokenId, string memory _tokenURI) public {
        super._setTokenURI(tokenId,_tokenURI);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function listToken(uint256 tokenId, uint256 price) public {
        require(_isApprovedOrOwner(msg.sender, tokenId), "NFTEasy: Caller is not the owner or approved");
        require(ownerOf(tokenId) != address(0), "NFTEasy: Invalid token");
        require(tokenPrices[tokenId] != 0, "NFTEasy: Token Price unset");

        tokenPrices[tokenId] = price;
        listedForSale[tokenId] = true;
        emit TokenListed(tokenId, price);
    }


    function buyToken(uint256 tokenId) public payable {
        require(ownerOf(tokenId) != address(0), "NFTEasy: Invalid token");
        require(msg.value >= tokenPrices[tokenId], "NFTEasy: Insufficient payment");
        require(listedForSale[tokenId], "NFTEasy: Token is not listed for sale");
        address tokenOwner = ownerOf(tokenId);
        uint256 sellerAmount = msg.value*99/100;
        uint256 factoryCommission = msg.value - sellerAmount;
        address payable payableOwner = payable(tokenOwner);
        payableOwner.transfer(sellerAmount);
        payable(contractFactory).transfer(factoryCommission);
        _transfer(tokenOwner, msg.sender, tokenId);
        emit TokenSold(tokenId, msg.sender, msg.value);
    }

    function setTokenPrice(uint256 tokenId, uint256 price) public {
        require(msg.sender == ownerOf(tokenId), "NFTEasy: Caller is not the owner");

        tokenPrices[tokenId] = price;
    }

    function getTokenPrice(uint256 tokenId) public view returns (uint256) {
        return tokenPrices[tokenId];
    }

    function transferNFT(address from, address to, uint256 tokenId) public {
        require(_isApprovedOrOwner(msg.sender, tokenId), "NFTEasy: Caller is not the owner or approved");
        _transfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721URIStorage) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
