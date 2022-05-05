// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./IFaucet.sol";
import "./Owned.sol";
import "./Logger.sol";

contract Faucet is Owned, Logger, IFaucet {
  uint public numOfFunders;
  mapping(address => bool) private funders;
  mapping(uint => address) private lutFunders;

  // private -> can be accesible only within the smart contract
  // internal -> can be acessible within smart contract and also derived smart contract
  
  receive() external payable {}

  modifier limitWithdraw(uint withdrawAmount) {
    require(withdrawAmount <= 100000000000000000, "Cannot witdraw more than 0.1 ether");
    _;
  }

  function transferOwnership(address newOwner) external onlyOwner {
    owner = newOwner;
  }

  // override for abstracts
  // pure cant modify state
  function log() public override pure returns (bytes32) {
    return "Faucet";
  }


  function addFunds() external override payable {
    address funder = msg.sender;
    
    if (!funders[funder]) {
      uint index = numOfFunders++;

      funders[funder] = true;
      lutFunders[index] = funder;
    }
  }

  /**
    truffle migrate --reset
    truffle console
    const instance = await Faucet.deployed()
    instance.addFunds({ from: accounts[0], value: "5000000000000000000"})
    instance.withdraw("1000000000000000000", { from: accounts[0] })
    instance.withdraw("100000000000000000", { from: accounts[0] })
   */

  function withdraw(uint withdrawAmount) override external onlyOwner limitWithdraw(withdrawAmount) {
    payable(msg.sender).transfer(withdrawAmount);
  }

  function getAllFunders() external view returns(address[] memory) {
    address[] memory _funders = new address[](numOfFunders);

    for (uint i = 0; i < numOfFunders; i++) {
      _funders[i] = lutFunders[i];
    }

    return _funders;
  }

  function getFunderAtIndex(uint8 index) external view returns(address) {
    return lutFunders[index];
  }
}