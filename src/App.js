import { useCallback, useEffect, useState } from "react";
import Web3 from "web3";
import detectEthereumProvider from "@metamask/detect-provider";
import "./App.css";
import loadContract from "./utils/load-contract";

function App() {
  const [web3Api, setWeb3Api] = useState({
    provider: null,
    web3: null,
    contract: null,
  });

  const [reload, setReload] = useState(false);
  const [account, setAccount] = useState("");
  const [balance, setBalance] = useState(0);

  const shouldReload = useCallback(() => setReload(!reload), [reload]);

  const contractIsAvailable = web3Api.contract;

  const getAccounts = useCallback(async () => {
    const { web3 } = web3Api;
    const accounts = await web3.eth.requestAccounts();

    setAccount(accounts[0]);
  }, [setAccount, web3Api]);

  const addFunds = useCallback(async () => {
    const { contract, web3 } = web3Api;

    await contract.addFunds({
      from: account,
      value: web3.utils.toWei("1", "ether"),
    });

    shouldReload();
  }, [web3Api, account, shouldReload]);

  const withdraw = useCallback(async () => {
    const { contract, web3 } = web3Api;

    const amount = web3.utils.toWei("0.1", "ether");

    await contract.withdraw(amount, {
      from: account,
    });

    shouldReload();
  }, [web3Api, account, shouldReload]);

  const setAccountListener = (provider) => {
    provider.on("accountsChanged", ([account]) => {
      setAccount(account);
    });

    provider.on("chainChanged", () => {
      setAccount("");
      shouldReload();
    });

    // provider._jsonRpcConnection.events.on("notification", (payload) => {
    //   const { method } = payload;

    //   if (method === "metamask_unlockStateChanged") {
    //     setAccount("");
    //   }
    // });
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

      const contract = await loadContract("Faucet", provider);

      if (!contract) {
        return console.error("Please, check your network");
      }

      setAccountListener(provider);

      setWeb3Api({
        web3: new Web3(provider),
        contract,
        provider,
      });
    };

    loadProvider();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [reload]);

  useEffect(() => {
    const loadBalance = async () => {
      const { contract, web3 } = web3Api;

      const balance = await web3.eth.getBalance(contract.address);

      setBalance(web3.utils.fromWei(balance, "ether"));
    };

    web3Api.contract && loadBalance();
  }, [web3Api, reload]);

  return (
    <>
      <div className="faucet-wrapper">
        <div className="faucet">
          {!account ? (
            <button
              className="button is-primary mr-2"
              onClick={getAccounts}
              disabled={!web3Api.provider && !contractIsAvailable}
            >
              Connect
            </button>
          ) : (
            <>
              <div className="mb-4">
                <h2 className="title">Account</h2>
                <p>{account}</p>
              </div>

              <div className="balance-view mb-4">
                <h2 className="title">Contract</h2>
                <div>
                  current balance: <strong>{balance}</strong> ETH
                </div>
              </div>
              <div>
                <button
                  className="button is-link is-light mr-2"
                  onClick={addFunds}
                  disabled={!contractIsAvailable}
                >
                  Donate 1 eth
                </button>
                <button
                  className="button is-primary is-light"
                  disabled={!contractIsAvailable}
                  onClick={withdraw}
                >
                  withdraw 0.1 eth
                </button>
              </div>
            </>
          )}
        </div>
      </div>
    </>
  );
}

export default App;
