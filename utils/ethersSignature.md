# Ethers Signature

链上验证时，必须加以太坊前缀

## ethers v5

### keccak256(abi.encode(...))

```
    import { BigNumber, ethers, providers, utils } from "ethers";

    const signer = new ethers.Wallet(privateKey, provider);

    const type = ["address", "uint8", "uint256", "address", "uint256", "uint256"];

    const args = [ccAddress, ccType, orderId, account, amount, deadline];

    const encodedData = utils.defaultAbiCoder.encode(type, args);

    const hashData = utils.keccak256(encodedData);

    let binaryData_ = utils.arrayify(hashData);

    let signature = await signer.signMessage(binaryData_);

```

### keccak256(abi.encodePacked(...))

```
    import { BigNumber, ethers, providers, utils } from "ethers";

    const signer = new ethers.Wallet(privateKey, provider);

    const type = ["address", "uint8", "uint256", "address", "uint256", "uint256"];

    const args = [ccAddress, ccType, orderId, account, amount, deadline];

    const hashData = utils.solidityKeccak256(type, args);

    let binaryData_ = utils.arrayify(hashData);

    let signature = await signer.signMessage(binaryData_);

```

## ethers v6

### keccak256(abi.encode(...))

```
  const { ethers, AbiCoder } = require("ethers");

  const signer = new ethers.Wallet(privateKey, provider);

  const type = ["address", "uint8", "uint256", "address", "uint256", "uint256"];

  const args = [ccAddress, ccType, orderId, account, amount, deadline];

  const encodedData = AbiCoder.defaultAbiCoder().encode(type, args);

  const hashData = ethers.keccak256(encodedData);

  let binaryData_ = ethers.getBytes(hashData);

  let signature = await signer.signMessage(binaryData_);
```

### keccak256(abi.encodePacked(...))

```
  const { ethers, AbiCoder } = require("ethers");

  const signer = new ethers.Wallet(privateKey, provider);

  const type = ["address", "uint8", "uint256", "address", "uint256", "uint256"];

  const args = [ccAddress, ccType, orderId, account, amount, deadline];

  const hashData = ethers.solidityPackedKeccak256(type, args);

  let binaryData_ = ethers.getBytes(hashData);

  let signature = await signer.signMessage(binaryData_);
```
