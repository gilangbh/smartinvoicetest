module.exports = {
  networks: {
    development: {
      host: "localhost",
      port: 8545,
      network_id: "*", // Match any network id
      gas: 4000000
    },
    dnb: {
      host: "cqethe3bu.southeastasia.cloudapp.azure.com",
      port: 8545,
      from: "0x180a1da65fa5d3dd2eb4ccd35e8ecc495ca8f3c2",
      network_id: "*", // Match any network id
      gas: 4000000
    }
  }
};
