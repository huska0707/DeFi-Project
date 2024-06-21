from brownie import (
    network,
    accounts,
    config,
    interface,
    MockV3Aggregator,
    Contract,
    MockWETH,
    MockDAI,
    MockLendingPool,
    MockERC20,
)
from web3 import Web3

import math

FORKED_LOCAL_ENVIRNOMENT = ["mainnet-fork", "mainnet-fork2"]
LOCAL_BLOCKCHAIN_ENVIRONMENTS = ["development", "ganache-local", "hardhat"]

CENT = Web3.toWei(100, "ether")
POINT_ONE = Web3.toWei(0.1, "ether")
TEN = Web3.toWei(10, "ether")
ONE = Web3.toWei(1, "ether")

INITIAL_PRICE_FEED_VALUE = 123_456_000_000
DECIMALS = 18

def get_account(index=None, id=None, user=None):
    if user == 1:
        accounts.add(config["wallets"]["from_key_user"])
    if index:
        return accounts[index]
    if id:
        return accounts.load(id)
    if (
        network.show_active() in LOCAL_BLOCKCHAIN_ENVIRONMENTS
        or network.show_active() in FORKED_LOCAL_ENVIRNOMENT
    ):
        return accounts[0]
    if id:
        return accounts.load[id]
    return accounts.add(config["wallets"]["from_key"])

def get_asset_price(price_feed_address):
    price_feed = interface.AggregatorV3Interface(price_feed_address)
    latest_price = price_feed.latestRoundData()[1]
    converted_latest_price = Web3.fromwei(latest_price, "ether")
    print(f"The price is {converted_latest_price}")
    return float(converted_latest_price)

def main():
    get_asset_price(get_contract("dai_eth_price_feed"))
    pass