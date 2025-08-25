//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/Subasta.sol";

contract BilleteraTest is Test {
    Subasta public subasta;
    uint256 private inicio;

    function setUp() public {
        subasta = new Subasta();
        inicio = block.timestamp;
    }

    function testOfertaAntesDeTiempo() public {
        vm.expectRevert(bytes("No se puede ofertar"));
        subasta.oferta();
    }

    function testOferta() public {
        vm.warp(inicio + 1 days);
        subasta.oferta();
    }

    function testOfertaFallaDespuesDeFin() public {
        vm.expectRevert(bytes("No se puede ofertar"));
        vm.warp(inicio + 3 days);
        subasta.oferta();
    }

    function testTimestamp() public {
        uint256 t = block.timestamp;

        // skip - incrementa el timestamp
        skip(100);
        assertEq(block.timestamp, t + 100);

        // rewind - decrementa el timestamp
        rewind(10);
        assertEq(block.timestamp, t + 90);
    }

    function testBlockNumber() public {
        vm.roll(555);
        assertEq(block.number, 555);
    }
}
