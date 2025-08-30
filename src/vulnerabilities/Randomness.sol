// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

// This is a vulnerable contract as randomness is not possible because of consensus layer.
contract RandomnessVulnerable {
    uint256 private seed;
    uint256 private randomNumber;

    constructor() {
        seed = block.timestamp;
    }

    function generateRandomNumber() public {
        /*
         This is vulnerable due to predictable result, it is possible to replicate the exact number by knowing the block.timestamp and block.difficulty
         after analyzing some outputs.
        */

        randomNumber = uint256(keccak256(abi.encodePacked(block.difficulty, block.timestamp, seed)));
    }
}

interface RandomnessOracle {
    function getRandomNumber() external returns (uint256);
}

contract RandomnessImproved {
    uint256 public randomNumber;
    address private oracle;

    constructor(address _oracle) {
        oracle = _oracle;
    }
    /*
    It is better to provide a random value from an external oracle
    */

    function generateRandomNumber() public {
        require(oracle != address(0), "Oracle not set");
        randomNumber = RandomnessOracle(oracle).getRandomNumber();
    }
}
