// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0;

contract OverflowUnderflow {
    uint8 value = 255;

    function overflow(uint8 _value) public {
        value += _value;
    }

    function underflow(uint8 _value) public {
        value -= _value;
    }
}

// No longer required on versions newer than 0.8.0(There it throws an error)
contract NonOverflowUnderflow {
    uint8 value = 255;

    function overflow(uint8 _value) public {
        uint8 result = value + _value;
        require(result <= value, "Overflow");
        value = result;
    }

    function underflow(uint8 _value) public {
        require(value <= _value, "Underflow");
        value -= _value;
    }
}
