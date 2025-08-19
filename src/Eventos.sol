// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0 <0.9.0;

contract Eventos {
    event Transfer(address indexed from, address indexed to, uint256 amount);

    function transfer(address from, address to, uint256 amount) public {
        emit Transfer(from, to, amount);
    }

    function transferMany(address _from, address[] calldata _to, uint256[] calldata _amount) public {
        for (uint256 i = 0; i < _to.length; i++) {
            emit Transfer(_from, _to[i], _amount[i]);
        }
    }
}
