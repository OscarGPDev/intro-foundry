// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0 <0.9.0;

contract UncheckedSend {
    mapping(address => uint256) private balances;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 _amount) external {
        require(_amount <= balances[msg.sender], "Insufficient balance");
        //Vulnerable code
        //payable(msg.sender).transfer(_amount);

        //Improved version
        require(payable(msg.sender).send(_amount), "Failed transfer");

        balances[msg.sender] -= _amount;
    }
}
