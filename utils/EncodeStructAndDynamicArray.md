# Java encode 结构体(动态、静态) 动态数组
## 分析
EIP712Domain 结构体包含string类型（bytes类型），在Java声明为动态结构体 DynamicStruct

Order 结构体 address和uint256类型字节数确定，在Java声明为静态结构体 StaticStruct
## solidity code
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract encodeTest {
    struct EIP712Domain {
        string name;
        string version;
        uint256 chainId;
        address verifyingContract;
    }

    struct Order {
        address account;
        uint256 amount;
    }

    function encode(
        Order[] calldata orders_,
        uint256[] calldata royaltyFees,
        uint256 endTime
    ) external view returns (bytes memory) {
        EIP712Domain memory domain = EIP712Domain({
            name: "TESTCODE",
            version: "1.0.0",
            chainId: block.chainid,
            verifyingContract: address(this)
        });
        return abi.encode(domain, orders_, royaltyFees, endTime);
    }
}

```      
## java code
```java
package com.utils;

import org.web3j.abi.datatypes.DynamicArray;
import org.web3j.abi.datatypes.DynamicStruct;
import org.web3j.abi.datatypes.StaticStruct;
import org.web3j.abi.datatypes.Utf8String;
import java.math.BigInteger;
import org.web3j.abi.datatypes.Type;
import java.util.Arrays;
import java.util.List;
import org.web3j.abi.FunctionEncoder;
import org.web3j.abi.datatypes.Address;
import org.web3j.abi.datatypes.generated.Uint256;

public class EncodeStructAndDynamicArray {
    public static void main(String[] args) {
        // 定义 DynamicStruct
        DynamicStruct eip712Domain = new DynamicStruct(
                new Utf8String("TESTCODE"), new Utf8String("1.0.0"),
                new Uint256(new BigInteger("5")),
                new Address("verifyingContract Address"));

        // 定义 StaticStruct 数组
        int len = 3;
        StaticStruct[] orders = new StaticStruct[len];
        Uint256[] royaltyFees = new Uint256[len];
        
        // Add Data
        for (int i = 0; i < len; i++) {
            orders[i] = new StaticStruct(
                    new Address("0x0987654321098765432109876543210987654325"),
                    new Uint256(i + 10));
            royaltyFees[i] = new Uint256(100 + i);
        }

        // 将 StaticStruct[] 转换为 DynamicArray<StaticStruct> 类型
        DynamicArray<StaticStruct> ordersArray = new DynamicArray<>(StaticStruct.class, orders);
        DynamicArray<Uint256> royaltyFeesArray = new DynamicArray<>(Uint256.class, royaltyFees);

        long timestamp = System.currentTimeMillis() / 1000;
        Uint256 endTime = new Uint256(timestamp + 5 * 60);

        List<Type> list = Arrays.asList(eip712Domain, ordersArray, royaltyFeesArray, endTime);
        String encodeData = FunctionEncoder.encodeConstructor(list);
        encodeData = "0x" + encodeData;
        System.out.println("encodeData: ");
        System.out.println(encodeData);
    }

}

```
