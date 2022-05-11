import { useEffect, useState } from "react";
import Web3 from "web3";
import detectEthereumProvider from "@metamask/detect-provider";
import "./App.css";

function App() {
  const [web3Api, setWeb3Api] = useState({
    provider: null,
    web3: null,
  });

  const [account, setAccount] = useState("");

  const getAccounts = async () => {
    const accounts = await web3Api.web3.eth.getAccounts();

    setAccount(accounts[0]);
  };

  useEffect(() => {
    const loadProvider = async () => {
      let provider = await detectEthereumProvider();

      // if (window.ethereum) {
      //   provider = window.ethereum;

      //   try {
      //     await provider.request({ method: "eth_requestAccounts" });
      //   } catch (error) {
      //     console.error("User denied account access");
      //   }
      // } else if (window.web3) {
      //   provider = window.web3.currentProvider;
      // } else {
      //   provider = new Web3.providers.HttpProvider("http://localhost:7545");
      // }

      if (!provider) {
        return console.error("Please, install metamask");
      }

      setWeb3Api({
        web3: new Web3(provider),
        provider,
      });
    };

    loadProvider();
  }, []);

  return (
    <>
      <div className="faucet-wrapper">
        <div className="faucet">
          {!account ? (
            <button className="button is-primary mr-2" onClick={getAccounts}>
              Connect
            </button>
          ) : (
            <>
              <div className="mb-4">
                <h2 className="title">Account</h2>
                <p>{account}</p>
              </div>

              <div className="balance-view mb-4">
                current balance: <strong>10</strong> ETH
              </div>
              <div>
                <button className="button is-link is-light mr-2">Donate</button>
                <button className="button is-primary is-light">Withdraw</button>
              </div>
            </>
          )}
        </div>
      </div>
    </>
  );
}

export default App;
