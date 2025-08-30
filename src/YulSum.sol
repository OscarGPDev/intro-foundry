// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract YulExamples {
    function sum(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b;
    }

    function sumYul(uint256 a, uint256 b) public pure returns (uint256 result) {
        assembly {
            result := add(a, b)
        }
    }

    function hash(uint256 a, uint256 b) public pure returns (bytes32 result) {
        result = keccak256(abi.encodePacked(a, b));
    }

    function hashYul(uint256 a, uint256 b) public pure returns (bytes32 result) {
        assembly {
            mstore(0x00, a)
            mstore(0x20, b)
            result := keccak256(0x00, 0x40)
        }
    }

    function unckeckedPlusPlusI() public pure returns (uint256 result) {
        result = 0;
        for (uint256 i = 0; i < 10; i++) {
            result++;
            //disable overflow check
            unchecked {
                i++;
            }
        }
    }

    function assemblyLoop() public pure returns (uint256 result) {
        assembly {
            result := 0
            for { let i := 0 } lt(i, 10) { i := add(i, 0x01) } { result := add(result, 0x01) }
        }
    }

    function sub(uint256 a, uint256 b) public pure returns (uint256) {
        return a - b;
    }

    function subYul(uint256 a, uint256 b) public pure returns (uint256) {
        assembly {
            let result := sub(a, b)
            if gt(result, a) {
                mstore(0x00, "underflow")
                revert(0x00, 0x20)
            }
            mstore(0x00, result)
            return(0x00, 0x20)
        }
    }

    address owner = address(0);

    function updateOwner(address _newOwner) public {
        owner = _newOwner;
    }

    function updateOwnerYul(address _newOwner) public {
        assembly {
            sstore(owner.slot, _newOwner)
        }
    }
}
