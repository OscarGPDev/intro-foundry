pragma solidity ^0.8.13;
import "forge-std/console.sol";
contract HolaMundo {
    string private mensaje;

    constructor() {
        mensaje = "Hola Mundo";
    }

    function obtenerMensaje() public view returns (string memory) {
        return mensaje;
    }

    function actualizarMensaje(string calldata nuevoMensaje) public {
        mensaje = nuevoMensaje;
        console.log("mensaje actualizado");
    }
}
