// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./ERC165.sol";
import "./interfaces/IERC721.sol";
import "./interfaces/IERC721Receiver.sol";

contract Token721 is ERC165, IERC721 {
    mapping(uint256 => address) public _owners;
    mapping(address => uint256) public _balances;
    mapping(uint256 => address) public _tokenApprovals;
    mapping(address => mapping(address => bool)) public _operatorApprovals;

    function balanceOf(address owner) external view returns (uint256) {
        require(owner != address(0), "ERC721 ERROR: Address zero");
        return _balances[owner];
    }

    function ownerOf(uint256 tokenId) public view override returns (address) {
        address owner = _owners[tokenId];
        require(owner != address(0), "ERC721 ERROR: Token not found");
        return owner;
    }

    function approve(address to, uint256 tokenId) external {
        require(to != address(0), "ERC721 ERROR: Address zero");
        address owner = _owners[tokenId];
        require(owner != address(0), "ERC721 ERROR: Token not found");
        require(to != owner, "ERC721 ERROR: The destination must be different from the owner");
        require(
            msg.sender == owner || isApprovedForAll(owner, to),
            "ERC721 ERROR: You are not the owner or you have no permits"
        );
        _approve(to, tokenId);
    }

    function _approve(address to, uint256 tokenId) internal virtual {
        _tokenApprovals[tokenId] = to;
        emit Approval(ownerOf(tokenId), to, tokenId);
    }

    function _exist(uint256 tokenId) internal view returns (bool) {
        return _owners[tokenId] != address(0);
    }

    function getApproved(uint256 tokenId) public view override returns (address) {
        require(_exist(tokenId), "ERC721 ERROR: Token not found");
        return _tokenApprovals[tokenId];
    }

    function setApprovalForAll(address operator, bool approved) public virtual override {
        require(operator != msg.sender, "ERC721 ERROR: The operator must be different from the owner");
        _operatorApprovals[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
    }

    function isApprovedForAll(address owner, address operator) public view override returns (bool) {
        return _operatorApprovals[owner][operator];
    }

    function _isApprovedOrOwner(address spender, uint256 tokenId) internal view returns (bool) {
        require(_exist(tokenId), "ERC721 ERROR: Token not found");
        address owner = ownerOf(tokenId);
        return spender == owner || getApproved(tokenId) == spender || isApprovedForAll(owner, spender);
    }

    function safeTransferFrom(address from, address to, uint256 tokenId) public virtual override {
        safeTransferFrom(from, to, tokenId, bytes(""));
    }

    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) public virtual override {
        require(
            _isApprovedOrOwner(msg.sender, tokenId), "ERC721 ERROR: You are not the owner or you have no permissions"
        );
        _safeTransfer(from, to, tokenId, data);
    }

    function _safeTransfer(address from, address to, uint256 tokenId, bytes memory data) internal virtual {
        _transfer(from, to, tokenId);
        require(
            _checkOnERC721Received(from, to, tokenId, data), "ERC721 ERROR: transfer to non ERC721Receiver implementer"
        );
    }

    function transferFrom(address from, address to, uint256 tokenId) public override {
        require(
            _isApprovedOrOwner(msg.sender, tokenId), "ERC721 ERROR: You are not the owner or you have no permissions"
        );
        _transfer(from, to, tokenId);
    }

    function _transfer(address from, address to, uint256 tokenId) internal virtual {
        require(ownerOf(tokenId) == from, "ERC721 ERROR: You are not the owner of the token");
        require(to != address(0), "ERC721 ERROR: Transfer to the zero address");
        _beforeTokenTransfer(from, to, tokenId);

        _approve(address(0), tokenId);
        _balances[from] -= 1;
        _balances[to] += 1;
        _owners[tokenId] = to;

        emit Transfer(from, to, tokenId);
    }

    function _safeMint(address to, uint256 tokenId) internal {
        _safeMint(to, tokenId, bytes(""));
    }

    function _safeMint(address to, uint256 tokenId, bytes memory data) internal {
        _mint(to, tokenId);
        require(
            _checkOnERC721Received(address(0), to, tokenId, data),
            "ERC721 ERROR: transfer to non ERC721Receiver implementer"
        );
    }

    function _mint(address to, uint256 tokenId) internal {
        require(to != address(0), "ERC721 ERROR: Mint to the zero address");
        require(!_exist(tokenId), "ERC721 ERROR: Token already minted");
        _beforeTokenTransfer(address(0), to, tokenId);

        _balances[to] += 1;
        _owners[tokenId] = to;

        emit Transfer(address(0), to, tokenId);
    }

    function _checkOnERC721Received(address from, address to, uint256 tokenId, bytes memory data)
        internal
        view
        returns (bool)
    {
        if (isContract(to)) {
            try IERC721Receiver(to).onERC721Received(msg.sender, from, tokenId, data) returns (bytes4 retval) {
                return retval == IERC721Receiver.onERC721Received.selector;
            } catch (bytes memory reason) {
                if (reason.length == 0) {
                    revert("ERC721 ERROR: transfer to non ERC721Receiver implementer");
                } else {
                    assembly {
                        revert(add(32, reason), mload(reason))
                    }
                }
            }
        } else {
            return true;
        }
    }

    function isContract(address _address) private view returns (bool) {
        uint32 size;
        assembly {
            size := extcodesize(_address)
        }
        return size > 0;
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal virtual {}
}
