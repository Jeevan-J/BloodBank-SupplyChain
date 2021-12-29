from brownie import BloodBankSupplyChain, accounts, network


def main():
    # requires brownie account to have been created
    if network.show_active()=='development':
        # add these accounts to metamask by importing private key
        owner = accounts[0]
        
    if network.show_active()=='ganache-gui':
        # add these accounts to metamask by importing private key
        owner = accounts[0]

    elif network.show_active() == 'kovan':
        # add these accounts to metamask by importing private key
        owner = accounts.load("main")
    
    BloodBankSupplyChain.deploy({'from':owner})