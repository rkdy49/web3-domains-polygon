// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

import "hardhat/console.sol";
import {StringUtils} from "../libraries/StringUtils.sol";

contract Domains {

    mapping(string => address) public domains;
    mapping(string => string) public records;
    string public tld;

    constructor(string memory _tld) payable{
        tld = _tld;
        console.log("%s name service deployed", _tld);
    }

    function price(string memory name) public pure returns (uint){
        uint len = StringUtils.strlen(name);

        require(len > 0);

        if(len == 3){
        return 5* 10**17; 
        }
        else if(len == 4){
        return 3* 10**17;
        }
        else{
        return 1* 10**17;
        }
    }

    function register(string calldata name) public payable{
        require(domains[name] == address(0));
        uint _price = price(name);

        require(msg.value >= _price, "Not Enough Matic");
        domains[name] = msg.sender;
        console.log("%s has registered a domain!", msg.sender);
    }

    function getAddress(string calldata name) public view returns (address){
        return domains[name];
    }

    function setRecord(string calldata name, string calldata record) public {
        require(domains[name] == msg.sender);
        records[name] = record;
    }

    function getRecord(string calldata name) public view returns(string memory){
        return records[name];
    }
}

