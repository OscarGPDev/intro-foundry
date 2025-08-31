// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "forge-std/Test.sol";
import "../src/YulSum.sol";

contract YulSumTest is Test {
    YulExamples yulExamples;

    function setUp() public {
        yulExamples = new YulExamples();
    }

    function testSum() public view {
        assertEq(yulExamples.sum(1, 2), 3);
    }

    function testSumYul() public view {
        assertEq(yulExamples.sumYul(1, 2), 3);
    }

    function testHash() public view {
        bytes32 expected = keccak256(abi.encodePacked(uint256(1), uint256(2)));
        assertEq(yulExamples.hash(1, 2), expected);
    }

    function testHashYul() public view {
        bytes32 expected = keccak256(abi.encodePacked(uint256(1), uint256(2)));
        assertEq(yulExamples.hashYul(1, 2), expected);
    }

    function testAssemblyLoop() public view {
        assertEq(yulExamples.assemblyLoop(), 10);
    }

    function testSub() public view {
        assertEq(yulExamples.sub(5, 3), 2);
    }

    function testSubYul() public view {
        assertEq(yulExamples.subYul(5, 3), 2);
    }

    function testUpdateOwner() public {
        address newOwner = address(0x1234567890123456789012345678901234567890);
        yulExamples.updateOwner(newOwner);
        assertEq(yulExamples.owner(), newOwner);
    }

    function testUpdateOwnerYul() public {
        address newOwner = address(0x1234567890123456789012345678901234567890);
        yulExamples.updateOwnerYul(newOwner);
        assertEq(yulExamples.owner(), newOwner);
    }
}
