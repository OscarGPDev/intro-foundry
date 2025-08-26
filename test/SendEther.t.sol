pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/SendEther.sol";

contract SendEtherTest is Test {
    SendEther public sendEther;

    function setUp() public {
        sendEther = new SendEther();
    }

    function test_Owner() public {
        sendEther.setOwner(address(1));
        assertEq(sendEther.owner(), address(1));
    }

    function testRevert_NotOwner() public {
        vm.expectRevert();
        vm.prank(address(1));
        sendEther.setOwner(address(1));
    }

    function _send(uint256 amount) private {
        (bool ok,) = address(sendEther).call{value: amount}("");
        require(ok, "Send ETH failed");
    }

    function testEthBalance() public view {
        console.log("ETH Balance", address(this).balance / 1e18);
    }

    function testSendEther() public {
        uint256 bal = address(sendEther).balance;

        deal(address(1), 100);
        assertEq(address(1).balance, 100);
        deal(address(1), 10);
        assertEq(address(1).balance, 10);

        deal(address(1), 145);
        vm.prank(address(1));
        _send(145);

        hoax(address(1), 567);
        _send(567);

        assertEq(address(sendEther).balance, bal + 145 + 567);
    }

    function testRevert_NotOwner2() public {
        // Forma 1
        // vm.prank(address(1));
        // vm.expectRevert();
        // billetera.setOwner(address(1));
        // vm.prank(address(1));
        // vm.expectRevert();
        // billetera.setOwner(address(1));
        // vm.prank(address(1));
        // vm.expectRevert();
        // billetera.setOwner(address(1));

        // Forma 2

        vm.startPrank(address(1));
        vm.expectRevert();
        sendEther.setOwner(address(1));
        vm.expectRevert();
        sendEther.setOwner(address(1));
        vm.expectRevert();
        sendEther.setOwner(address(1));
        vm.expectRevert();
        sendEther.setOwner(address(1));
        vm.stopPrank();
    }
}
