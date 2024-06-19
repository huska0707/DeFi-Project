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

    function unstakeTokens(address _token) external {
        //check token to unstake
        uint256 balance = stakingBalance[_token][msg.sender];
        require(balance > 0, "StakingContract: Staking balance already 0!");
        //update token to claim
        _updateOneTokenToClaim(msg.sender, _token);
        // update contract data
        stakingBalance[_token][msg.sender] = 0;
        uniqueTokensStaked[msg.sender] = uniqueTokensStaked[msg.sender] - 1;
        if (uniqueTokensStaked[msg.sender] == 0) {
            for (uint256 i = 0; i < stakers.length; i++) {
                if (stakers[i] == msg.sender) {
                    stakers[i] = stakers[stakers.length - 1];
                    stakers.pop();
                    break;
                }
            }
        }

        require(
            lendingProtocol.withdraw(_token, balance, msg.sender) > 0,
            "StakingContract: withdraw error"
        );
        emit TokenUnstaked(_token, msg.sender, balance);
    }

    function tokenIsAllowed(address _token) public view returns (bool) {
        for (uint256 i = 0; i < allowedTokens.length; i++) {
            if (allowedTokens[i] == _token) {
                return true;
            }
        }
        return false;
    }

    function claimToken() external {
        _updateTokenToClaim(msg.sender);
        uint256 amount = tokenToClaim[msg.sender];
        tokenToClaim[msg.sender] = 0;
        require(
            projectToken.transfer(msg.sender, amount),
            "StakingContract: transfer failed"
        );
    }

    function updateClaimToken(address _user) internal {
        for (uint256 i = 0; i < allowedTokens.length; i ++) {
            if (stakingBalance[allowedTokens[i]][_user] > 0) {
                _updateOneTokenClaim(_user, allowedTokens[i]);
            }
        }
    }
}
