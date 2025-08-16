pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/HolaMundo.sol";

contract HolaMundoTest is Test {
    HolaMundo public holaMundo;

    function setUp() public {
        holaMundo = new HolaMundo();
    }

    function test_ObtenerMensaje() public view {
        assertEq(holaMundo.obtenerMensaje(), "Hola Mundo");
    }

    function test_ActualizarMensaje() public {
        string memory nuevoMensaje = "mensaje de prueba";
        holaMundo.actualizarMensaje(nuevoMensaje);
        assertEq(holaMundo.obtenerMensaje(), nuevoMensaje);
    }
}
