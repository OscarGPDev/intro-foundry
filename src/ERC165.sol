// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./interfaces/IERC165.sol";

abstract contract ERC165 is IERC165 {
    // Verifica si soporta una versión especifica del contrato
    function supportsInterface(bytes4 interfaceID) external pure returns (bool) {
        return interfaceID == type(IERC165).interfaceId;
    }
}
