from scripts.deploy_aave_lending_contract import deploy_aave_lending_contract
from scripts.helpful_scripts import (
    get_account,
    get_contract,
    CENT,
    POINT_ONE,
    ONE,
    get_verify_status,
    LOCAL_BLOCKCHAIN_ENVIRONMENTS,
)
from brownie import (
    ProjectToken,
    StakingContract,
    AaveLending,
)

import yaml
import json
import os
import shutil

def deploy_staking_contract_and_project_token(front_end_update=False):
    """
    Deploy the ERC20 token: ProjectToken
    """
    account = get_account()

def main():
    account = get_account()