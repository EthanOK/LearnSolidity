# LearnSolidity
Solidity [英文文档](https://docs.soliditylang.org/en/latest/) [中文文档](https://learnblockchain.cn/docs/solidity/)
[Solidity by Example](https://solidity-by-example.org/)

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

