// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";

contract ConsoleTest is Test {
    function testLog() public {
        uint256 n = 333;
        console.log("Hola Mundo", n);
        int256 x = -1;
        console.logInt(x);
    }
}
