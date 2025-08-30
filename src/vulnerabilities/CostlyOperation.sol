// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0 <0.9.0;

contract CostlyOperation {
    uint256 public constant MAX_ITERATIONS = 1000;

    /*
    We should be aware that loops are expensive so avoiding them when possible is important.
    */
    function CostlyOperationFunction() public pure returns (uint256 result) {
        result = 0;
        for (uint256 i = 0; i < MAX_ITERATIONS; i++) {
            result += i;
        }
    }

    function NonCostlyOperationFunction() public pure returns (uint256 result) {
        result = calculateThroughFormula(MAX_ITERATIONS);
    }

    function calculateThroughFormula(uint256 n) public pure returns (uint256) {
        return (n * (n + 1)) / 2;
    }
}
