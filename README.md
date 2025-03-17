# LearnSolidity

Solidity [英文文档](https://docs.soliditylang.org/en/latest/) [中文文档](https://learnblockchain.cn/docs/solidity/)

[Solidity by Example](https://solidity-by-example.org/)

[Hardhat 安装与使用](./xmind文件/md%20or%20pdf/Hardhat.md)

[Solidity 多重继承](./xmind文件/md%20or%20pdf/Solidity多重继承.md)

[Solidity 汇编](./xmind文件/md%20or%20pdf/初识汇编.md)

[Solidity 汇编案例](./xmind文件/md%20or%20pdf/Solidity汇编应用案例.md)

[Solidity delete](./xmind文件/md%20or%20pdf/Solidity-delete.md)

Solidity 智能合约基础开发 [视频](https://space.bilibili.com/1159991219/channel/collectiondetail?sid=616215) [文档](./Solidity智能合约开发.md)

[Solidity 引用拷贝与值拷贝](./xmind文件/md%20or%20pdf/引用拷贝还是值拷贝%20（x%20=%20a）.md)

[encode 与 decode](./encode与encodePacked/encode_decode.md)

[解析原始 Calldata 数据](./encode与encodePacked/解析原始Calldata数据.md)

[encode 与 encodePacked 对比](./encode与encodePacked/encode_encodePacked.md)

[UsingFor 与 用户定义值类型](./DefinedValueTypes/custom_type.md)

[Assembly log Event](https://github.com/EthanOK/assembly-log)

[如何使用 encode 编码与 decode 解码结构体](./utils/如何使用encode编码与decode解码结构体.md)

[以太坊签名 Java 版 头部加`Ethereum Signed Message`](./utils/Java版以太坊签名.md)

[Java encode 结构体（动态、静态） 动态数组; decode(data)](./utils/EncodeStructAndDynamicArray.md)

[使用 Java 访问智能合约](./utils/UseJavaCallContract.md)

[Java 实现一次请求获取多个 Topics0 合约事件](./Java/FilterMulTopicsEvent/FilterMulTopics.java)

[使用 Java 获取地址的 ENS](./Java/ENS/GetENSOfAddress.java)

[使用 ethers.js 进行 abi.encode、encodePacked 和 signature](./utils/getSignature_ethersjs.md)

[使用 EIP721 协议结构化数据](./utils/EIP712.md)

[Remix 使用`viaIR: true` 编译 配置文件](./json/compiler_config.json)

[Remix 导入指定版本的`合约库`](./utils/Remix_Library_Version.md)

## [MerkleTree](./Merkle)

白名单 空投

## Create

使用`ethers.js` 预获取 `create` 创建的合约地址

[Get Contract Address Of Create](./Create2/GetContractAddressOfCreate.js)

## [Create2](./Create2)

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

   [Get Contract Address Of Create2](./Create2/GetContractAddressOfCreate2.js)
