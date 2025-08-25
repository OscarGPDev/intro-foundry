// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0 <0.9.0;

contract Subasta {
    uint256 public inicio = block.timestamp + 1 days;
    uint256 public fin = block.timestamp + 2 days;

    function oferta() external view {
        require(block.timestamp >= inicio && block.timestamp < fin, "No se puede ofertar");
    }

    function finalizar() external view {
        require(block.timestamp >= fin, "No se puede finalizar.");
    }
}
