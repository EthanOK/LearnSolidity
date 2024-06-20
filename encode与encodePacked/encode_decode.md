```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract AbiDecode {
    struct MyStruct {
        string name;
        uint256[2] nums;
    }

    function encode(
        uint256 x,
        address addr,
        uint256[] calldata arr,
        MyStruct calldata myStruct
    ) external pure returns (bytes memory) {
        return abi.encode(x, addr, arr, myStruct);
    }

    function decode(bytes calldata data)
        external
        pure
        returns (
            uint256 x,
            address addr,
            uint256[] memory arr,
            MyStruct memory myStruct
        )
    {
        // (uint x, address addr, uint[] memory arr, MyStruct myStruct) = ...
        (x, addr, arr, myStruct) =
            abi.decode(data, (uint256, address, uint256[], MyStruct));
    }
}

```

## 1. encode

`bytes memory encodedata = abi.encode(uint8(10), address(1))`

encodedata = `0x000000000000000000000000000000000000000000000000000000000000000a0000000000000000000000000000000000000000000000000000000000000001`

`uint8(10)` 填充 为 32 bytes，为`0x000000000000000000000000000000000000000000000000000000000000000a`

`address(1)` 填充 为 32 bytes，为`0x0000000000000000000000000000000000000000000000000000000000000001`

## 2. decode

`(uint8 x, address y) = abi.decode(encodedata, (uint8, address));`

x = `10`
y = `0x0000000000000000000000000000000000000001`
