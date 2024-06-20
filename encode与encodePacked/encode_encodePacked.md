```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Encode {
    constructor() {
        encodeStaticArrayTest();

        encodeDynamicArrayTest();
    }

    function encodeStaticArrayTest()
        public
        pure
        returns (bytes memory encodeData, bytes memory encodePackedData)
    {
        ///@dev static array
        uint16[4] memory arr;

        for (uint256 i; i < 4; ++i) {
            arr[i] = uint16(i + 1);
        }
        encodeData = abi.encode(arr);

        encodePackedData = abi.encodePacked(arr);

        console.log("encode StaticArray:");
        console.logBytes(encodeData);
        console.log("encodePacked StaticArray:");
        console.logBytes(encodePackedData);
    }

    function encodeDynamicArrayTest()
        public
        pure
        returns (bytes memory encodeData, bytes memory encodePackedData)
    {
        ///@dev dynamic array
        uint16[] memory arr = new uint16[](4);

        for (uint256 i; i < 4; ++i) {
            arr[i] = uint16(i + 1);
        }
        encodeData = abi.encode(arr);

        encodePackedData = abi.encodePacked(arr);

        console.log("encode DynamicArray:");
        console.logBytes(encodeData);
        console.log("encodePacked DynamicArray:");
        console.logBytes(encodePackedData);
    }
}

```

## 1. encode 与 encodePacked

### 1.1 Static Array

uint16[4] arr = [1,2,3,4];

encode StaticArray:
`0x0000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000030000000000000000000000000000000000000000000000000000000000000004`

encodePacked StaticArray:
`0x0000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000030000000000000000000000000000000000000000000000000000000000000004`

### 1.2 Dynamic Array

uint16[] arr = [1,2,3,4];

encode DynamicArray:
`0x000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000030000000000000000000000000000000000000000000000000000000000000004`

encodePacked DynamicArray:
`0x0000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000030000000000000000000000000000000000000000000000000000000000000004`

## 2. encode

abi.encode 编码后的字节大小是 32 的倍数。

- 1）将 abi.encode 会将基本类型的元素填充为 32 字节，然后将其串联在一起。

  abi.encode(uint16(2),address(1))=`0x00000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000001`

- 2）动态大小的类型（如 string 、 bytes 或 uint[] ）在编码时添加头信息（长度），并将数据对齐填充到 32 字节

## 3. [encodePacked](https://docs.soliditylang.org/en/latest/abi-spec.html#non-standard-packed-mode)

- 1）abi.encodePacked 会将基本类型的元素紧凑编码

abi.encodePacked(uint16(2),address(1)) = `0x00020000000000000000000000000000000000000001`

- 2）数组的编码是其元素的`编码与填充的串联`

- 3）动态大小的类型（如 string 、 bytes 或 uint[] ）在编码时没有其长度字段

注：由于缺少长度字段，一旦存在两个动态大小的元素，编码就会不明确。`abi.encodePacked("a","bc") = abi.encodePacked("ab","c")。`
