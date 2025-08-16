// SPDX-License-Identifier: MIT 
pragma solidity >=0.8.13<0.9.0;
import "@openzeppelin/contracts/access/Ownable.sol";
contract TestOwnable is Ownable{
    constructor() Ownable(msg.sender){}
}