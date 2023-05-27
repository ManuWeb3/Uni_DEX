// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface IRouter {
    function addLiquidity(address, address) 
    external returns (uint256, uint256);
}