# LearnSolidity
Solidity [英文文档](https://docs.soliditylang.org/en/latest/) [中文文档](https://learnblockchain.cn/docs/solidity/)

[Solidity by Example](https://solidity-by-example.org/)

[Hardhat安装与使用](https://github.com/EthanOK/LearnSolidity/blob/main/xmind%E6%96%87%E4%BB%B6/md%20or%20pdf/Hardhat.md)

[Solidity多重继承](https://github.com/EthanOK/LearnSolidity/blob/main/xmind%E6%96%87%E4%BB%B6/md%20or%20pdf/Solidity%E5%A4%9A%E9%87%8D%E7%BB%A7%E6%89%BF.md)

[Solidity汇编](https://github.com/EthanOK/LearnSolidity/blob/main/xmind%E6%96%87%E4%BB%B6/md%20or%20pdf/%E5%88%9D%E8%AF%86%E6%B1%87%E7%BC%96.md)  [Solidity汇编案例](https://github.com/EthanOK/LearnSolidity/blob/main/xmind%E6%96%87%E4%BB%B6/md%20or%20pdf/%E5%88%9D%E8%AF%86%E6%B1%87%E7%BC%96.md)

[Solidity delete](https://github.com/EthanOK/LearnSolidity/blob/main/xmind%E6%96%87%E4%BB%B6/md%20or%20pdf/Solidity-delete.md)

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

