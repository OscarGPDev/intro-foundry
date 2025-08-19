// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Errores {
    error NoAutorizado();

    function throwError() external pure {
        require(false, "No autorizado");
    }

    function throwCustomError() public pure {
        revert NoAutorizado();
    }
}
