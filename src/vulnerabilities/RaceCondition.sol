// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract VulnerableToRaceCondition {
    uint256 private balance;
    mapping(address => uint256) private balances;

    function depositar() public payable {
        balances[msg.sender] += msg.value;
        balance += msg.value;
    }

    function retirar(uint256 _cantidad) public {
        require(balances[msg.sender] >= _cantidad, "Saldo insuficiente");

        uint256 saldoAnterior = balances[msg.sender];
        balances[msg.sender] -= _cantidad;

        require(payable(msg.sender).send(_cantidad), "Error al realizar la transferencia");
        require(balances[msg.sender] == saldoAnterior, "Race Condition detectada");
    }
}

contract NonVulnerableToRaceCondition {
    uint256 private balance;
    mapping(address => uint256) private balances;
    //We use a "task manager" mapping to control the transfer process like a lock mechanism
    mapping(address => bool) isTransferring;

    function depositar() public payable {
        balances[msg.sender] += msg.value;
        balance += msg.value;
    }

    function retirar(uint256 _cantidad) public {
        require(balances[msg.sender] >= _cantidad, "Saldo insuficiente");
        require(!isTransferring[msg.sender], "Transferencia en curso");

        // We lock the transfer process to avoid race conditions
        isTransferring[msg.sender] = true;

        require(payable(msg.sender).send(_cantidad), "Error al realizar la transferencia");
        balances[msg.sender] -= _cantidad;
        // Once we finish the transfer, we unlock it
        isTransferring[msg.sender] = false;
    }
}
