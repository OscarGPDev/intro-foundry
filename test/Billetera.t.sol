pragma solidity ^0.8.24;
import "forge-std/Test.sol";
import "../src/Billetera.sol";
contract BilleteraTest is Test {
    Billetera public billetera;

    function setUp() public {
        billetera = new Billetera();
    }
    function test_Owner() public {
        billetera.setOwner(address(1));
        assertEq(billetera.owner(), address(1));
    }
    function testRevert_NotOwner() public {
        vm.expectRevert();
        vm.prank(address(1));
        billetera.setOwner(address(1));
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
        billetera.setOwner(address(1));
        vm.expectRevert();
        billetera.setOwner(address(1));
        vm.expectRevert();
        billetera.setOwner(address(1));
        vm.expectRevert();
        billetera.setOwner(address(1));
        vm.stopPrank();
    }
}
