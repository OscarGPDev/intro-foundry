pragma solidity ^0.8.13;

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
    }
}
