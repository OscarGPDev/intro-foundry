// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import "forge-std/Test.sol";
contract ConsoleTest is Test {
    function testLog() public  {
        uint n=333;
        console.log("Hola Mundo", n);
        int x = -1;
        console.logInt(x);
    }
}
