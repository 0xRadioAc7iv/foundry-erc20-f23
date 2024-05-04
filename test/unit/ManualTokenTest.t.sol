// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployManualToken} from "../../script/DeployManualToken.s.sol";
import {ManualToken} from "../../src/ManualToken.sol";

contract ManualTokenTest is Test {
    ManualToken public manualToken;
    DeployManualToken public deployer;

    address bob = makeAddr("bob");

    uint256 public constant STARTING_BALANCE = 10 ether;
    uint256 public constant OWNER_STARTING_BALANCE = 100 ether;

    function setUp() public {
        deployer = new DeployManualToken();
        manualToken = deployer.run();
    }

    function testSelfBalance() public view {
        assertEq(OWNER_STARTING_BALANCE, manualToken.balanceOf(msg.sender));
    }

    function testTokenName() public view {
        assertEq(manualToken.name(), "Manual Token");
    }

    function testTokenSymbol() public view {
        assertEq(manualToken.symbol(), "MTK");
    }

    function testTokenDecimals() public view {
        assertEq(manualToken.decimals(), 18);
    }

    function testTokenTotalSupply() public view {
        assertEq(manualToken.totalSupply(), 1000000 ether);
    }

    function testTokenTransfer() public {
        vm.prank(msg.sender);
        manualToken.transfer(bob, STARTING_BALANCE);
        assertEq(STARTING_BALANCE, manualToken.balanceOf(bob));
    }

    function testTransferWithInsufficientBalance() public {
        vm.expectRevert();
        manualToken.transfer(bob, OWNER_STARTING_BALANCE + 1);
    }
}
