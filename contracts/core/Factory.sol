// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
import "./interfaces/IFactory.sol";

contract Factory is IFactory {
    // ideally, it should be private and return from within IFactory.getPair()
    mapping(address => mapping(address => address)) public getPair;
    
    // we'll make sure that this mapping is updated in createPair() in such a way
    // so that when either of the 2 token addresses are input, 
    // it should return the ContractAddress of the LP => populate both ways
    function createPair(address tokenA, address tokenB) external returns (address pair) {
        
    }

}