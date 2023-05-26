// SPDX-License-Identifier: MIT

// Locking the Solidity version
// excluding attack vectors / bugs creeping in due to minor differences between...
// different versions of the compiler.
// one of Uniswap's best practices
pragma solidity 0.8.17;
import "./interfaces/IRouter.sol";
import "../core/interfaces/IFactory.sol";

// Uniswap makes use of interfaces to make external contract calls
contract Router is IRouter {
    address immutable factoryAddr;

    constructor(address _factoryAddress) {
        factoryAddr = _factoryAddress;
    }

    function _addLiquidity(address tokenA, address tokenB) 
    internal returns (uint256 amountA, uint256 amountB) {

    }

    function addLiquidity(address tokenA, address tokenB) 
    external returns (uint256 amountA, uint256 amountB) {
    // STEP # 1 - check whether the LPool for the TradingPair exists already ?
    // => run IFactory.getPair() to check the address returned
        if(IFactory(factoryAddr).getPair(tokenA, tokenB) == address(0)) {
            // create TradingPair contract now
            IFactory(factoryAddr).createPair(tokenA, tokenB)
        }
    }
}

