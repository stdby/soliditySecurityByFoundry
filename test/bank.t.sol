// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/s01_ReentrancyAttack/bank.sol";

contract BankTest is Test{
    Bank bank;
    address player;
    function setUp() public {
        bank = new Bank();
        player = makeAddr("player");
        vm.deal(address(bank),10 ether);
    }
    function testBank() public {
        vm.startPrank(player);

    }
}



