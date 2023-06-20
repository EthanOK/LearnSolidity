const { ethers } = require("ethers");

main();

function main() {
  let sender = "0x6278A1E803A76796a3A1f7F6344fE874ebfe94B2";
  let nonce = 524;
  getAddressCreate(sender, nonce);
}
function getAddressCreate(sender, nonce) {
  // from + nonce
  let address = ethers.utils.getContractAddress({ from: sender, nonce: nonce });
  console.log("Create:" + address);
  return address;
}
