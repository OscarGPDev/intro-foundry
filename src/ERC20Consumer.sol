// SPDX-License-Identifier: MIT
import "./ERC20.sol";

contract ERC20Consumer {
    ERC20 private _token;
    address private _owner;
    address private _contractAddress;

    constructor() {
        _token = new ERC20("ExampleSample", "ESX");
        _owner = msg.sender;
        _contractAddress = address(this);
    }
    //Obtiene el precio de los tokens

    function priceTokens(uint256 _numTokens) public pure returns (uint256) {
        return _numTokens * 1 ether;
    }
    //Vende tokens

    function buyTokens(address _client, uint256 _numTokens) public payable {
        uint256 price = priceTokens(_numTokens);
        require(msg.value >= price, "Buy more tokens");
        uint256 returnValue = msg.value - price;
        payable(msg.sender).transfer(returnValue);
        _token.transfer(_client, _numTokens);
    }
    // Generar tokens

    function generateTokens(uint256 _numTokens) public {
        _token.increaseTotalSupply(_contractAddress, _numTokens);
    }
    // Obtener dirección del contrato

    function getContractAddress() public view returns (address) {
        return _contractAddress;
    }

    // Obtener el balance
    function getBalance(address _account) public view returns (uint256) {
        return _token.balanceOf(_account);
    }
    //Total de tokens en el contrato

    function getTotalSupply() public view returns (uint256) {
        return _token.totalSupply();
    }
}
