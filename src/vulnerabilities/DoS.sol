// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract DoS {
    // This is is not only a vulnerability of costly operation but also could lead to DoS attacks
    function unrestrictedConsumption(uint256 _operations) public pure {
        uint256[] memory data = new uint256[](_operations);
        for (uint256 i = 0; i < _operations; i++) {
            data[i] = i;
        }
    }
}

contract TrES {
    uint256 constant REASONABLE_LIMIT = 1000;
    // This way we avoid both

    function unrestrictedConsumption(uint256 _operations) public pure {
        require(_operations <= REASONABLE_LIMIT, "Too many operations");
        uint256[] memory data = new uint256[](_operations);
        for (uint256 i = 0; i < _operations; i++) {
            data[i] = i;
        }
    }
}
