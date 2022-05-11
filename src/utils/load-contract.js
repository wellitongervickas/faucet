import getContract from "@truffle/contract";

const loadContract = async (name, provider) => {
  const Artifact = (await import(`../../public/contracts/${name}.json`))
    .default;

  const contract = getContract(Artifact);
  contract.setProvider(provider);

  return contract.deployed();
};

export default loadContract;
