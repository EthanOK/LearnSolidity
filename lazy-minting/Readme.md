# [lazy-minting](https://nftschool.dev/tutorial/lazy-minting/)

# EIP712Domain
```solidity
struct EIP712Domain {
string name;
string version;
uint256 chainId;
address verifyingContract;
}
```
 Define a Solidity struct :NFTVoucher
```solidity
struct NFTVoucher {
  uint256 tokenId;
  uint256 minPrice;
  string uri;
  bytes signature;
}
```
 creates signed NFT vouchers
 ```js
 async createVoucher(tokenId, uri, minPrice = 0) {
    const voucher = { tokenId, uri, minPrice }
    const domain = await this._signingDomain()
    const types = {
      NFTVoucher: [
        {name: "tokenId", type: "uint256"},
        {name: "minPrice", type: "uint256"},
        {name: "uri", type: "string"},  
      ]
    }
    const signature = await this.signer._signTypedData(domain, types, voucher)
    return {
      ...voucher,
      signature,
    }
  }
 ```
 createVoucher() 返回一个NFTVoucher结构的数据类型

