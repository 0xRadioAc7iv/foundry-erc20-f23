// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {ManualToken} from "../src/ManualToken.sol";

contract DeployManualToken is Script {
    ManualToken manualToken;

    function run() external returns (ManualToken) {
        vm.startBroadcast();
        manualToken = new ManualToken();
        vm.stopBroadcast();
        return manualToken;
    }
}
