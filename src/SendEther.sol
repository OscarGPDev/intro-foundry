// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

contract SendEther {
    address payable public owner;

    event Deposit(address account, uint256 value);

    constructor() payable {
        owner = payable(msg.sender);
    }

    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    function retirar(uint256 _cantidad) external {
        require(msg.sender == owner, "No eres el owner");
        payable(owner).transfer(_cantidad);
    }

    function setOwner(address _newOwner) external {
        require(msg.sender == owner, "No eres el owner");
        owner = payable(_newOwner);
    }
}
