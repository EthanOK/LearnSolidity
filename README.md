# LearnSolidity

Solidity [英文文档](https://docs.soliditylang.org/en/latest/) [中文文档](https://learnblockchain.cn/docs/solidity/)

[Solidity by Example](https://solidity-by-example.org/)

[Hardhat 安装与使用](https://github.com/EthanOK/LearnSolidity/blob/main/xmind%E6%96%87%E4%BB%B6/md%20or%20pdf/Hardhat.md)

[Solidity 多重继承](https://github.com/EthanOK/LearnSolidity/blob/main/xmind%E6%96%87%E4%BB%B6/md%20or%20pdf/Solidity%E5%A4%9A%E9%87%8D%E7%BB%A7%E6%89%BF.md)

[Solidity 汇编](https://github.com/EthanOK/LearnSolidity/blob/main/xmind%E6%96%87%E4%BB%B6/md%20or%20pdf/%E5%88%9D%E8%AF%86%E6%B1%87%E7%BC%96.md) [Solidity 汇编案例](https://github.com/EthanOK/LearnSolidity/blob/main/xmind%E6%96%87%E4%BB%B6/md%20or%20pdf/%E5%88%9D%E8%AF%86%E6%B1%87%E7%BC%96.md)

[Solidity delete](https://github.com/EthanOK/LearnSolidity/blob/main/xmind%E6%96%87%E4%BB%B6/md%20or%20pdf/Solidity-delete.md)

Solidity 智能合约基础开发 [视频](https://space.bilibili.com/1159991219/channel/collectiondetail?sid=616215) [文档](https://github.com/EthanOK/LearnSolidity/blob/main/Solidity%E6%99%BA%E8%83%BD%E5%90%88%E7%BA%A6%E5%BC%80%E5%8F%91.md)

[Solidity 引用拷贝与值拷贝](https://github.com/EthanOK/LearnSolidity/blob/main/xmind%E6%96%87%E4%BB%B6/md%20or%20pdf/%E5%BC%95%E7%94%A8%E6%8B%B7%E8%B4%9D%E8%BF%98%E6%98%AF%E5%80%BC%E6%8B%B7%E8%B4%9D%20%EF%BC%88x%20%3D%20a%EF%BC%89.md)

[如何使用 encode 编码与 decode 解码结构体](https://github.com/EthanOK/LearnSolidity/blob/main/utils/%E5%A6%82%E4%BD%95%E4%BD%BF%E7%94%A8encode%E7%BC%96%E7%A0%81%E4%B8%8Edecode%E8%A7%A3%E7%A0%81%E7%BB%93%E6%9E%84%E4%BD%93.md)

[以太坊签名 Java 版 头部加`Ethereum Signed Message`](https://github.com/EthanOK/LearnSolidity/blob/main/utils/Java%E7%89%88%E4%BB%A5%E5%A4%AA%E5%9D%8A%E7%AD%BE%E5%90%8D.md)

[Java encode 结构体（动态、静态） 动态数组; decode(data)](https://github.com/EthanOK/LearnSolidity/blob/main/utils/EncodeStructAndDynamicArray.md)

[使用 Java 访问智能合约](https://github.com/EthanOK/LearnSolidity/blob/main/utils/UseJavaCallContract.md)

[Java 实现一次请求获取多个 Topics0 合约事件](https://github.com/EthanOK/LearnSolidity/blob/main/Java/FilterMulTopicsEvent/FilterMulTopics.java)

[使用 Java 获取地址的 ENS](https://github.com/EthanOK/LearnSolidity/blob/main/Java/ENS/GetENSOfAddress.java)

[使用 ethers.js 进行 abi.encode、encodePacked 和 signature](https://github.com/EthanOK/LearnSolidity/blob/main/utils/getSignature_ethersjs.md)

[使用 EIP721 协议结构化数据](https://github.com/EthanOK/LearnSolidity/blob/main/utils/EIP712.md)

[Remix 使用`viaIR: true` 编译 配置文件](https://github.com/EthanOK/LearnSolidity/blob/main/json/compiler_config.json)

[Remix 导入指定版本的`合约库`](https://github.com/EthanOK/LearnSolidity/blob/main/utils/Remix_Library_Version.md)

## [MerkleTree](https://github.com/EthanOK/LearnSolidity/tree/main/Merkle)

白名单 空投

## Create

使用`ethers.js` 预获取 `create` 创建的合约地址

[Get Contract Address Of Create](https://github.com/EthanOK/LearnSolidity/blob/main/Create2/GetContractAddressOfCreate.js)

## [Create2](https://github.com/EthanOK/LearnSolidity/tree/main/Create2)

1. 预先计算出智能合约的地址(solidity code)

```solidity
// Get bytecode of contract to be deployed

function getBytecode()
        public
        view
        returns (bytes memory)
    {
        bytes memory bytecode = type(SimpleWallet).creationCode;
        // creationCode + parameter（constructor）
        return abi.encodePacked(bytecode, abi.encode(msg.sender));
    }

function getAddress(uint256 _salt)
        public
        view
        returns (address)
    {
        // Get a hash concatenating args passed to encodePacked
        bytes32 hash = keccak256(
            abi.encodePacked(
                bytes1(0xff), // 0
                address(this), // address of factory contract
                _salt, // a random salt
                keccak256(getBytecode()) // the wallet contract bytecode
            )
        );
        // Cast last 20 bytes of hash to address
        return address(uint160(uint256(hash)));
    }
```

2. 使用`ethers.js` 获取 `create2` 创建的合约地址

   [Get Contract Address Of Create2](https://github.com/EthanOK/LearnSolidity/blob/main/Create2/GetContractAddressOfCreate2.js)
