// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

// 2 main functions of a Factory Contract:
// (1). return the address of TradingPair contract if it already exists
// (2). create a TradingPair  / LiquidityPool contract if it does Not exist
// added event as well in the interface, emitted in factory contract
interface IFactory {
    event TradingPairCreated(address indexed, address indexed);

    function createTradingPair(address, address) external returns (address pair);
    function getTradingPair(address, address) external view returns (address pair);
}