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
    // _addLiquidity: helper function for addLiquidity below:
    function _addLiquidity(address tokenA, address tokenB) 
    internal returns (uint256 amountA, uint256 amountB) {

    }
    // uses helper function
    function addLiquidity(address tokenA, address tokenB) 
    external returns (uint256 amountA, uint256 amountB) {
    // STEP # 1 - check whether the LPool for the TradingPair exists already ?
    // => run IFactory.getPair() to check the address returned
        if(IFactory(factoryAddr).getTradingPair(tokenA, tokenB) == address(0)) {
            // create TradingPair contract now
            IFactory(factoryAddr).createTradingPair(tokenA, tokenB);
        }
    // STEP # 2: check whether the tokens are of equal value
    
    // STEP # 3: actually add Liquidity now

    }
}

