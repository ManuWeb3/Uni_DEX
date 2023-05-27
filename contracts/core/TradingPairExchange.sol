// Main contract that keeps LP assets' reserves, LProviders' funds & money, etc.
// Consider this as the LiquidityPool contract for the TradingPair 
// Should be lean and super secure.
// (equivalent to UniswapPairv2.sol)

// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "./interfaces/ITradingPairExchange.sol";

contract TradingPairExchange is ITradingPairExchange {
    // state vars for 3 addresses
    address public factoryAddr;
    address public tokenA;
    address public tokenB;

    // set "factoryAddr" as the msg.sender inside constructor
    // means, only factoryAddr can deploy it bcz this is the LP for the TradingPair
    // custom constructor
    constructor () {
        factoryAddr = msg.sender;
    }
    
    // "external" - will be (and can only be) called by external contract = Factory
    function initialize(address _tokenA, address _tokenB) external {
        require(msg.sender == factoryAddr, "DEX: FORBIDDEN");
        tokenA = _tokenA;
        tokenB = _tokenB;
        // the address of the TP tokens will be passed in to the state vars here from Factory contract.
    }
}
// as opposed to keeping a struct (data structure) for every LP... 
// we've rather kept a contract for every LP
// Hence, DEX = combination of multiple LPs put together