// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

import "../interfaces/ILendingProtocol.sol";

contract StakingContract is Ownable {
    IERC20 public projectToken;

    address[] public stakers;
    address[] public allowedTokens;

    mapping(address => mapping(address => uint256)) public stakingBalance;
    mapping(address => uint256) public uniqueTokenStaked;

    ILendingProtocol public lendingProtocol;

    event TokenStaked(
        address indexed token,
        address indexed staker,
        uint256 amount
    );

    constructor(address _projectTokenAddress, address _lendingProtocol) {
        projectToken = IERC20(_projectTokenAddress);
        lendingProtocol = ILendingProtocol(_lendingProtocol);
    }

    function stakeToken(uint256 _amount, address _token) external {
        require(_amount > 0, "StakingContract: Amount must be greater than 0");
        require(
            tokenIsAllowed(_token),
            "StakingContract: Token is currently no allowed."
        );

        if (stakingBalance[_token][msg.sender] == 0) {
            uniqueTokenStaked[msg.sender] = uniqueTokenStaked[msg.sender] + 1;
        }

        stakingBalance[_token][msg.sender] = stakingBalance[_token][msg.sender] + _amount;

        if (uniqueTokenStaked[msg.sender] == 1) {
            stakers.push[msg.sender];
        }

        lendingProtocol.deposit(_token, _amount, address(this));

        emit TokenStaked(_token, msg.sender, _amount);
    }

    function tokenIsAllowed(address _token) public view returns (bool) {
        for (uint256 i = 0; i < allowedTokens.length; i++) {
            if (allowedTokens[i] == _token) {
                return true;
            }
        }
        return false;
    }
}
