// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0 <0.9.0;

contract FallbackVulnerable {
    mapping(address => uint256) private balances;
    /*
    As we handle our balances mapping from fallback we could suffer unexpected behavior that could be exploited.
    */

    fallback() external payable {
        balances[msg.sender] += msg.value;

        (bool success,) = msg.sender.call{value: msg.value}("");
        require(success, "Transferencia fallida");
    }

    function withdraw() public {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "No hay suficiente saldo para concretar la transaccion");

        balances[msg.sender] = 0;

        (bool success,) = msg.sender.call{value: amount}("");
        require(success, "Transferencia fallida");
    }

    receive() external payable {}
}

contract FallbackImproved {
    mapping(address => uint256) private balances;
    /*
    As fallback just revert the transaction, it's easier to prevent unexpected behavior.
    */

    fallback() external payable {
        revert("El consumo de la funcion fallo");
    }

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "No hay suficiente saldo para concretar la transaccion");

        balances[msg.sender] = 0;

        (bool success,) = msg.sender.call{value: amount}("");
        require(success, "Transferencia fallida");
    }

    receive() external payable {}
}
