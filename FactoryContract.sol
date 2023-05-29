// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./NFTEasy.sol";

contract NFTEasyContractFactory {
    address private factoryAdmin;
    mapping(address => address[]) private contractOwners;
    address[] private allContracts;
    struct listedTokens{
        address contractAddress;
        uint256 tokenId;
        uint256 price;
        string tokenURI;
    }
    
    event ContractCreated(address indexed owner, address indexed contractAddress);

    constructor() {
        factoryAdmin = msg.sender;
    }

    function createContract(string memory name, string memory symbol) public {
        NFTEasy newContract = new NFTEasy(name, symbol, msg.sender);
        contractOwners[msg.sender].push(address(newContract));
        allContracts.push(address(newContract));

        emit ContractCreated(msg.sender, address(newContract));
    }

    function getContractCount() public view returns (uint256) {
        return allContracts.length;
    }

    function getContractsByOwner(address owner) public view returns (address[] memory) {
        return contractOwners[owner];
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function withdraw() public payable{
        payable(factoryAdmin).transfer(address(this).balance);
    }
}
