// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0 <0.9.0;

contract ReentrancyVulnerable {
    mapping(address => uint256) private balances;

    function desposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 _amount) external {
        require(_amount <= balances[msg.sender], "Insufficient balance");

        //Vulnerable code
        (bool success,) = msg.sender.call{value: _amount}("");
        require(success, "Failed transfer");
        balances[msg.sender] -= _amount;
    }
}

contract ReentrancyImproved {
    mapping(address => uint256) private balances;

    function desposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 _amount) external {
        require(_amount <= balances[msg.sender], "Insufficient balance");
        // Verify first if the transfer failed
        require(payable(msg.sender).send(_amount), "Failed transfer");
        balances[msg.sender] -= _amount;
    }
}
