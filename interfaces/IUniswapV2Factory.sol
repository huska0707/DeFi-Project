// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0;

//from: https://docs.uniswap.org/protocol/V2/reference/smart-contracts/factory
//import '@uniswap/v2-core/contracts/interfaces/IUniswapV2Factory.sol';

interface IUniswapV2Factory {
    event pairCreated(
        address indexed token0,
        address indexed token1,
        address pair,
        uint256
    );
    
    function getPair(address tokenA, address tokenB)
        external 
        view
        returns (address pairt);

    function allPairs(uint256) external view returns (address pair);
    function allPairsLength(uint256) external view returns (uint256);
    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);
    function createPair(address tokenA, address tokenB)
        external
        returns (address pair);
}