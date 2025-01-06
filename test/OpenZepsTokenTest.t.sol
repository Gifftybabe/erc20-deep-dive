// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import {Test} from "forge-std/Test.sol";
import {DeployOpenZepsToken} from "../script/DeployOpenZepsToken.s.sol";
import {OpenZepsToken} from "../src/OpenZepsToken.sol";

contract OpenZepsTokenTest is Test {
    OpenZepsToken public zepsToken;
    DeployOpenZepsToken public deployer;

    address bob = makeAddr("bob");
    address alice = makeAddr("alice");

    uint256 public constant STARTING_BALANCE = 100 ether;

    function setUp() public {
        deployer = new DeployOpenZepsToken();
        zepsToken = deployer.run();

        vm.prank(msg.sender);
        zepsToken.transfer(bob, STARTING_BALANCE);

    }

    function testBobBalance() public {
        assertEq(STARTING_BALANCE, zepsToken.balanceOf(bob));
    }

    function testAllowancesWork() public {
        uint256 initialAllowance = 1000;

        // Bob approves Alice to spend tokens on his behalf
        vm.prank(bob);
        zepsToken.approve(alice, initialAllowance);

        uint256 transferAmount = 500;

        vm.prank(alice);
        zepsToken.transferFrom(bob, alice, transferAmount);
    }
}