// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Eventos.sol";

contract EventosTest is Test {
    Eventos public eventos;

    event Transfer(address indexed from, address indexed to, uint256 amount);

    function setUp() public {
        eventos = new Eventos();
    }

    function testEmitTransferEvent() public {
        vm.expectEmit(true, true, false, true);
        emit Transfer(address(this), address(123), 200);
        eventos.transfer(address(this), address(123), 200);

        vm.expectEmit(true, false, false, false);
        emit Transfer(address(this), address(123), 200);
        eventos.transfer(address(this), address(125), 400);
    }

    function testEmitManyTransferEvent() public {
        address[] memory to = new address[](2);
        to[0] = address(10);
        to[1] = address(11);
        uint256[] memory amount = new uint256[](2);
        amount[0] = 100;
        amount[1] = 200;
        for (uint256 i = 0; i < to.length; i++) {
            vm.expectEmit(true, true, false, true);
            emit Transfer(address(this), to[i], amount[i]);
        }
        eventos.transferMany(address(this), to, amount);
    }
}
