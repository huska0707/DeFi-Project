//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../interfaces/ILendingProtocol.sol";
import "@openzepplin/contracts/access/Ownable.sol";
import "@openzepplin/contracts/token/ERC20/IERC20.sol";

contract AaveLending is ILendingProtocol, Ownable {
    ILendingProtocol public pool;
    address public stakingContract;

    constructor(address _pool) {
        stakingContract = msg.sender;
        pool = ILendingPool(_pool);
    }
}
