//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ILendingProtocol {
    event StakingContractChange(address newContract);

    function deposit(
        address _token,
        uint256 _amount,
        address _from
    ) external;

    function withdraw(
        address _token,
        uint256 _amount,
        address _to
    ) external returns (uint256);

    function drainToken(address _token) external;
}