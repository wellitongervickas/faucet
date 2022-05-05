// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

abstract contract Logger {
    function log() public virtual pure returns (bytes32);
}