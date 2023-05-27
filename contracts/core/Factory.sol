// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
import "./interfaces/IFactory.sol";
import "./TradingPairExchange.sol";

contract Factory is IFactory {
    // ideally, it should be private and return from within IFactory.getPair()
    mapping(address => mapping(address => address)) public tradingPair;
    address[] public allTradingPairs;
    // we'll make sure that this mapping is updated in createPair() in such a way
    // so that when either of the 2 token addresses are input, 
    // it should return the ContractAddress of the LP => populate both ways
    function createTradingPair(address tokenA, address tokenB) external returns (address pair) {
        // Checks and Balances before adding Liquidity
        // 1). Addresses of both the token cannot be the same
        require(tokenA != tokenB, "DEX: IDENTICAL_ADDRESSES_TOKENS");
        // 2). Addresses of both the token cannot be the same
        require(tokenA != address(0) && tokenB != address(0), "DEX: ZERO_ADDRESS_TOKEN");
        // 3). No createPair if TradingPair already exist
        require(tradingPair[tokenA][tokenB] == address(0), "DEX: PAIR_ALREADY_EXISTS");
        
        // 1). DEPLOYMENT of TradingPairExchange (UniswapPairv2):

        // after all the checks, get the CreationCode of TradingPairExchange.sol
        // to create a contact, (create Pair eventually) we need the code.
        bytes memory bytecode = type(TradingPairExchange).creationCode;
        // actual UniswapPairv2 = TradingPairExchange here.
        bytes32 salt = keccak256(abi.encodePacked(tokenA, tokenB));
        assembly {
            pair := create2(0, add(bytecode, 32), mload(bytecode), salt)
            // pair: returns the address of the LP contract (for the Trading pair in_question) here.
        }
        // 2). call INITIALIZE():

        // will be called only once for a specific TP of tokens
        // next time, it will be reverted at 3rd require() above for the same pair
        ITradingPairExchange(pair).initialize(tokenA, tokenB);
        // now, set the mapping both ways:
        tradingPair[tokenA][tokenB] = pair;
        tradingPair[tokenB][tokenA] = pair;
        // populate the trading-pairs array
        allTradingPairs.push(pair);

        emit TradingPairCreated(tokenA, tokenB);
    }

    function getTradingPair(address tokenA, address tokenB) external view returns (address pair) {
        return tradingPair[tokenA][tokenB];
    }
}
/* 
type(C).creationCode:

Memory byte array that contains the creation bytecode of the contract. 
This can be used in inline assembly to build custom creation routines, 
especially by using the create2 opcode. 
This property can not be accessed in the contract itself or any derived contract. 
It causes the bytecode to be included in the bytecode of the call site and thus circular references like that are not possible.
https://docs.soliditylang.org/en/v0.6.9/units-and-global-variables.html#type-information
*/

/* 
CREATE2:

a powerful opcode to be used with caution
a malicious actor can create a contact at the same address and...
users will "feel" that they are interacting with the correct/genuine contract as they check it with the address only
(Metamorphic smart contract exploit)
*/
