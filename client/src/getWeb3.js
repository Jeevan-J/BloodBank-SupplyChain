import Web3 from "web3";
import {getEthereum} from "./getEthereum";

export const getWeb3 = async () => {

    const ethereum = await getEthereum()
    let web3

    if (ethereum) {
        console.log("using Ethereum")
        web3 = new Web3(ethereum)
    } else if (window.web3) {
        console.log("using window.web3")
        web3 = new Web3(window.web3)
    } else {
        console.log("Using Localhost 7545")
        const provider = new Web3.providers.HttpProvider(
            "http://127.0.0.1:7545"
        );
        web3 = new Web3(provider)
    }
    console.log(web3)
    return web3
}