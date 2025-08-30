// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0 <0.9.0;

contract AccessControlVulnerable {
    uint256 private secretNumber;
    // Owner should not be public because is a sensible field and it should not be possible to access it from outside.
    address public owner;

    constructor() {
        owner = msg.sender;
    }
    /*
    secretNumber is private but setter is not restricted, so anyone can change it.
    */

    function setSecretNumber(uint256 _newNumber) public {
        secretNumber = _newNumber;
    }

    function getSecretNumber() public view returns (uint256) {
        return secretNumber;
    }
}

contract AccessControlImproved {
    uint256 private secretNumber;
    address private owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }
    /*
    Now secretNumber now is only accessible by the owner.
    */

    function setSecretNumber(uint256 _newNumber) public onlyOwner {
        secretNumber = _newNumber;
    }

    function getSecretNumber() public view returns (uint256) {
        return secretNumber;
    }
}
