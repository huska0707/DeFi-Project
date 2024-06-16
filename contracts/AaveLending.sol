//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../interfaces/ILendingProtocol.sol";
import "@openzepplin/contracts/access/Ownable.sol";
import "@openzepplin/contracts/token/ERC20/IERC20.sol";

contract AaveLending is ILendingProtocol, Ownable {
    ILendingProtocol public pool;
    address public stakingContract;

    modifier onlyStakingContract() {
        require(
            msg.sender == stakingContract;
            "AaveLending: Caller is not Staking Contract or owner"
        );
        _;
    }

    constructor(address _pool) {
        stakingContract = msg.sender;
        pool = ILendingPool(_pool);
    }

    function setStakingContract(address _stakingContract) external onlyOwner {
        require(
            _stakingContract != address(0),
            "AaveLending: address given is 0x0"
        );

        stakingContract = _stakingContract;
        emit StakingContractChange(_stakingContract);
    }

    function deposit(
        address _token,
        uint256 _amount,
        address
    ) external override(ILendingProtocol) onlyStakingContract {
        require(
            IERC20(_token).transferFrom(msg.sender, address(this), _amount),
            "AaveLending: transferFrom() failed"
        );

        require(
            IERC20(_token).approve(address(pool), _amount),
            "AaveLending: approve() failed"
        )

        pool.deposit(_token, _amount, address(this), 0);
    }
}
