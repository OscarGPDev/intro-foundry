// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0 .0 <0.9.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/interfaces/IERC20.sol";

contract ForkDaiTest is Test {
    IERC20 public dai;

    function setUp() public {
        dai = IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F);
    }

    function testDeposit() public {
        address dir1 = address(123);

        uint256 balanceInicial = dai.balanceOf(dir1);
        console.log("Balance inicial", balanceInicial / 1e18);

        uint256 totalInicial = dai.totalSupply();
        console.log("Total inicial", totalInicial / 1e18);

        deal(address(dai), dir1, 1e6 * 1e18, true);

        uint256 balanceFinal = dai.balanceOf(dir1);
        console.log("Balance final", balanceInicial / 1e18);

        uint256 totalFinal = dai.totalSupply();
        console.log("Total final", totalInicial / 1e18);
    }
}
