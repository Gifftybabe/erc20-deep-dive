// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import {Script} from "forge-std/Script.sol";
import {OpenZepsToken} from "../src/OpenZepsToken.sol";

contract DeployOpenZepsToken is Script {

    uint256 public constant INITIAL_SUPPLY = 1000 ether;

    function run() external returns(OpenZepsToken) {
        vm.startBroadcast();
        OpenZepsToken ozt = new OpenZepsToken(INITIAL_SUPPLY);
        vm.stopBroadcast();
        return ozt;
    }

}