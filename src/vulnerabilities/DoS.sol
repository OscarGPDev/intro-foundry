// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract DoS {
    // This is is not only a vulnerability of costly operation but also could lead to DoS attacks
    function unrestrictedConsumption(uint _operations) public pure {
        uint[] memory data = new uint[](_operations);
        for (uint i = 0; i < _operations; i++) {
            data[i] = i;
        }
    }
}
contract TrES {
    uint constant REASONABLE_LIMIT = 1000;
    // This way we avoid both 
    function unrestrictedConsumption(uint _operations) public pure {
        require(_operations <= REASONABLE_LIMIT, "Too many operations");
        uint[] memory data = new uint[](_operations);
        for (uint i = 0; i < _operations; i++) {
            data[i] = i;
        }
    }
}
