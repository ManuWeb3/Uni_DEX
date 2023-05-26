// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

// 2 main functions of a Factory Contract:
// (1). return the address of TradingPair contract if it already exists
// (2). create a TradingPair  / LiquidityPool contract if it does Not exist
interface IFactory {
    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function createPair(address tokenA, address tokenB) external returns (address pair);
}