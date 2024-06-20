from brownie import network, StakingContract
import pytest
from scripts.helpful_scripts import (
    LOCAL_BLOCKCHAIN_ENVIRONMENTS,
    get_account,
    POINT_ONE,
    get_contract,
    TEN,
)
from scripts.deploy_staking_contract import deploy_staking_contract_and_project_token
from scripts.deploy_aave_lending_contract import drain_token
