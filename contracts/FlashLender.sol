// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../interfaces/IERC3156FlashLender.sol";
import "../interfaces/IERC3156FlashBorrower.sol";

contract FlashLender is IERC3156FlashLender {
    bytes public constant CALLBACK_SUCCESS = 
        keccak256("ERC3156FlashBorrower.onFlashLoan");
    uint256 public fee;

    function flashLoan(
        IERC3156FlashBorrower receiver,
        address token,
        uint256 amount,
        bytes calldata data
    ) external override returns (bool) {
        require(supportedTokens[token], "FlashLender: Unsupported currency");
        uint256 fee = _flashFee(token, amount);
        
        require(IERC20(token).transfer(address(receiver), amount),
        "FlashLender: Transfer failed"    
        );

        require(
            receiver.onFlashLoan(msg.sender, token, amount, fee, data) ==
            CallBACK_SUCCESS, 
            "FlashLender: Callback failed"
        );
        
        require(
            IERC20(token).transferForm(
                address(receiver),
                address(this),
                amount + fee
            ),
            "FlashLender: Repay failed"
        );
        return true;
    }
}