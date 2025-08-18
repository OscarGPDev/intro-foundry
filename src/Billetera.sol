// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

contract Billetera {
    address payable public owner;

    constructor() payable {
        owner = payable(msg.sender);
    }

    receive() external payable {}

    function retirar(uint256 cantidad) external {
        require(msg.sender == owner, "No eres el owner");
        payable(owner).transfer(cantidad);
    }

    function setOwner(address _newOwner) external {
        require(msg.sender == owner, "No eres el owner");
        owner = payable(_newOwner);
    }
}
