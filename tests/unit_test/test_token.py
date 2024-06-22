from brownie import network, config, ProjectToken, accounts, reverts, exceptions
from scripts.helpful_scripts import (
    LOCAL_BLOCKCHAIN_ENVIRONMENTS,
    CENT,
    get_account,
)
import pytest
from scripts.deploy_token import deploy_token

MM = 1_000_000_000_000_000_000_000_000


def test_issue_tokens():
    if network.show_active() not in LOCAL_BLOCKCHAIN_ENVIRONMENTS:
        pytest.skip("Only for local testing!")
    account = get_account()
    token = deploy_token()

    starting_balance_account = token.balanceOf(account.address)
    starting_balance_contract = token.balanceOf(token.address)

    assert starting_balance_contract == MM - CENT
    assert starting_balance_account == CENT


## transfer
def test_transfer():
    if network.show_active() not in LOCAL_BLOCKCHAIN_ENVIRONMENTS:
        pytest.skip("Only for local testing!")
    account = get_account()
    token = deploy_token()

    token.transfer(accounts[1], CENT, {"from": account})

    assert token.balanceOf(account.address) == 0
    assert token.balanceOf(accounts[1].address) == CENT


def test_insufficient_balance_transfer():
    if network.show_active() not in LOCAL_BLOCKCHAIN_ENVIRONMENTS:
        pytest.skip("Only for local testing!")
    account = get_account()
    token = deploy_token()

    with reverts():
        token.transfer(accounts[1], 2 * CENT, {"from": account})


def test_transfer_null_address():
    if network.show_active() not in LOCAL_BLOCKCHAIN_ENVIRONMENTS:
        pytest.skip("Only for local testing!")
    account = get_account()
    token = deploy_token()

    with reverts():
        token.transfer(
            "0x0000000000000000000000000000000000000000", 2 * CENT, {"from": account}
        )


def test_transfer_event():
    if network.show_active() not in LOCAL_BLOCKCHAIN_ENVIRONMENTS:
        pytest.skip("Only for local testing!")
    account = get_account()
    token = deploy_token()
    tx = token.transfer(accounts[1], CENT, {"from": account})

    assert tx.events["Transfer"].values() == [account, accounts[1], CENT]


