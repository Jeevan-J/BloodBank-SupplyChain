import React, {Component} from "react";
import {
    BrowserRouter as Router,
    Route,
    Link,
    Routes,
  } from 'react-router-dom';
import { Layout, Menu, Breadcrumb } from 'antd';

import {getWeb3} from "./getWeb3";
import {getEthereum} from "./getEthereum";

import './App.css';
import 'antd/dist/antd.css';

import Owner from "./components/Owner";
import CollectionCentre from "./components/CollectionCentre/CollectionCentre";
import Explorer from "./components/Explorer";

import logo from './logo.svg';
import map from "./artifacts/deployments/map.json";


const { Header, Content, Footer } = Layout

class App extends Component {

    state = {
        web3: null,
        accounts: null,
        chainid: null,
        bloodBankSupplyChain: null
    }

    componentDidMount = async () => {

        // Get network provider and web3 instance.
        const web3 = await getWeb3()

        // Try and enable accounts (connect metamask)
        try {
            const ethereum = await getEthereum()
            ethereum.enable()
        } catch (e) {
            console.log(`Could not enable accounts. Interaction with contracts not available.
            Use a modern browser with a Web3 plugin to fix this issue.`)
            console.log(e)
        }

        // Use web3 to get the user's accounts
        const accounts = await web3.eth.getAccounts() 
        console.log(accounts)
        // Get the current chain id
        const chainid = parseInt(await web3.eth.getChainId())

        this.setState({
            web3,
            accounts,
            chainid
        }, await this.loadInitialContracts)

    }

    loadInitialContracts = async () => {
        // <=42 to exclude Kovan, <42 to include kovan
        if (this.state.chainid < 42) {
            // Wrong Network!
            return
        }
        console.log(this.state.chainid)
        
        var _chainID = 0;
        if (this.state.chainid === 42){
            _chainID = 42;
        }
        if (this.state.chainid === 1337){
            _chainID = 1337
        }
        console.log(_chainID)
        const bloodBankSupplyChain = await this.loadContract(_chainID,"BloodBankSupplyChain")
        console.log(bloodBankSupplyChain)
        if (!bloodBankSupplyChain) {
            return
        }
        const numberOfBloodSamples = await bloodBankSupplyChain.methods.fetchSampleCount().call()
        console.log(numberOfBloodSamples)
        this.setState({
            bloodBankSupplyChain
        })
    }

    loadContract = async (chain, contractName) => {
        // Load a deployed contract instance into a web3 contract object
        const {web3} = this.state

        // Get the address of the most recent deployment from the deployment map
        let address
        console.log(map)
        console.log(chain, contractName)
        try {
            address = map[chain][contractName][0]
        } catch (e) {
            console.log(`Couldn't find any deployed contract "${contractName}" on the chain "${chain}".`)
            console.log(e)
            return undefined
        }

        // Load the artifact with the specified address
        let contractArtifact
        try {
            contractArtifact = await import(`./artifacts/deployments/${chain}/${address}.json`)
        } catch (e) {
            console.log(`Failed to load contract artifact "./artifacts/deployments/${chain}/${address}.json"`)
            return undefined
        }
        console.log(address)
        return new web3.eth.Contract(contractArtifact.abi, address)
    }

    render() {
        const {
            web3, accounts, chainid, bloodBankSupplyChain
        } = this.state

        if (!web3) {
            return <div>Loading Web3, accounts, and contracts...</div>
        }

        // <=42 to exclude Kovan, <42 to include Kovan
        if (isNaN(chainid) || chainid < 42) {
            return <div>Wrong Network! Switch to your local RPC "Localhost: 8545" in your Web3 provider (e.g. Metamask)</div>
        }

        if ( !bloodBankSupplyChain) {
            return <div>Could not find a deployed contract. Check console for details.</div>
        }

        const isAccountsUnlocked = accounts ? accounts.length > 0 : false

        
        return (
            <>
                <Router>
                    <Layout className="layout" style={{ minHeight: '100vh'}}>
                        <Header>
                            <img className="logo" src={logo}/>
                            <Menu theme="dark" mode="horizontal" defaultSelectedKeys={['Home']} style={{float:'right'}}>
                                <Menu.Item key="Home">
                                    <Link to='/'>Home</Link>
                                </Menu.Item>
                                <Menu.Item key="CollectionCentre">
                                    <Link to='/collectionCentre'>CollectionCentre</Link>
                                </Menu.Item>
                            </Menu>
                        </Header>
                        <Content style={{ padding: '0 50px', display: 'flex' }}>
                            {/* <Breadcrumb style={{ margin: '16px 0' }}>
                                <Breadcrumb.Item>Home</Breadcrumb.Item>
                                <Breadcrumb.Item>List</Breadcrumb.Item>
                                <Breadcrumb.Item>App</Breadcrumb.Item>
                            </Breadcrumb> */}
                            <div className="site-layout-content">
                                <Routes>
                                    <Route path='/owner' element={<Owner state={this.state}/>}></Route>
                                    <Route path='/collectionCentre' element={<CollectionCentre state={this.state}/>}></Route>
                                </Routes>
                            </div>
                        </Content>
                        <Footer style={{ textAlign: 'center', bottom: '0' }}>BloodBank SupplyChain ©2021 Created by Jeevan J</Footer>
                    </Layout>
                </Router>
            </>
        )
    }
}

export default App
