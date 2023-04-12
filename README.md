# LearnSolidity
Solidity [英文文档](https://docs.soliditylang.org/en/latest/) [中文文档](https://learnblockchain.cn/docs/solidity/)

[Solidity by Example](https://solidity-by-example.org/)

[Hardhat安装与使用](https://github.com/EthanOK/LearnSolidity/blob/main/xmind%E6%96%87%E4%BB%B6/md%20or%20pdf/Hardhat.md)

[Solidity多重继承](https://github.com/EthanOK/LearnSolidity/blob/main/xmind%E6%96%87%E4%BB%B6/md%20or%20pdf/Solidity%E5%A4%9A%E9%87%8D%E7%BB%A7%E6%89%BF.md)

[Solidity汇编](https://github.com/EthanOK/LearnSolidity/blob/main/xmind%E6%96%87%E4%BB%B6/md%20or%20pdf/%E5%88%9D%E8%AF%86%E6%B1%87%E7%BC%96.md)  [Solidity汇编案例](https://github.com/EthanOK/LearnSolidity/blob/main/xmind%E6%96%87%E4%BB%B6/md%20or%20pdf/%E5%88%9D%E8%AF%86%E6%B1%87%E7%BC%96.md)

[Solidity delete](https://github.com/EthanOK/LearnSolidity/blob/main/xmind%E6%96%87%E4%BB%B6/md%20or%20pdf/Solidity-delete.md)

Solidity智能合约基础开发 [视频](https://space.bilibili.com/1159991219/channel/collectiondetail?sid=616215)        [文档](https://github.com/EthanOK/LearnSolidity/blob/main/Solidity%E6%99%BA%E8%83%BD%E5%90%88%E7%BA%A6%E5%BC%80%E5%8F%91.md)

[Solidity引用拷贝与值拷贝](https://github.com/EthanOK/LearnSolidity/blob/main/xmind%E6%96%87%E4%BB%B6/md%20or%20pdf/%E5%BC%95%E7%94%A8%E6%8B%B7%E8%B4%9D%E8%BF%98%E6%98%AF%E5%80%BC%E6%8B%B7%E8%B4%9D%20%EF%BC%88x%20%3D%20a%EF%BC%89.md)

[如何使用encode编码与decode解码结构体](https://github.com/EthanOK/LearnSolidity/blob/main/utils/%E5%A6%82%E4%BD%95%E4%BD%BF%E7%94%A8encode%E7%BC%96%E7%A0%81%E4%B8%8Edecode%E8%A7%A3%E7%A0%81%E7%BB%93%E6%9E%84%E4%BD%93.md)

[以太坊签名Java版 头部加`Ethereum Signed Message`](https://github.com/EthanOK/LearnSolidity/blob/main/utils/Java%E7%89%88%E4%BB%A5%E5%A4%AA%E5%9D%8A%E7%AD%BE%E5%90%8D.md)

[Java ende 动态 结构体数组](https://github.com/EthanOK/LearnSolidity/blob/main/utils/EncodeStaticStructDynamicArray.md)

[使用ethers.js 进行 abi.encode 和 signature](https://github.com/EthanOK/LearnSolidity/blob/main/utils/getSignature_ethersjs.md)

## [MerkleTree](https://github.com/EthanOK/LearnSolidity/tree/main/Merkle)
白名单 空投

## [Create2](https://github.com/EthanOK/LearnSolidity/tree/main/Create2)
预先计算出智能合约的地址
```solidity
//getBytecodeGet() bytecode of contract to be deployed
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

