## use java connect contract
```
contract Multicall {
    uint256 public number;

    function setNumber(uint256 number_) external {
        number = number_;
    }
    
    function getCurrentBlockTimestamp()
    public
    view
    returns (uint256 timestamp)
    {
        timestamp = block.timestamp;
    }
}
```
### 使用 Web3j 将 Solidity 代码转换为 Java 代码
`mvn web3j:generate-sources` Multicall.sol ==> Multicall.java

https://github.com/web3j/web3j-maven-plugin

windows 无法使用 0.7.2 及之后 编译

### 只查询合约
Web3j web3j = Web3j
				.build(new HttpService(RPC));
getCurrentBlockTimestamp() 

```
// Read only public function
ContractGasProvider contractGasProvider = new DefaultGasProvider();
Multicall2Test contract = Multicall2Test.load(multicallAddressEveryone, web3j,
		new ReadonlyTransactionManager(web3j, null), contractGasProvider);
BigInteger blockTimestamp = contract.getCurrentBlockTimestamp().sendAsync().get();
System.out.println("BlockTimestamp:" + blockTimestamp);
```

### 交互合约（花gas费或有权限限制）

Credentials credentials = Credentials.create(privatekey);
Web3j web3j = Web3j
		.build(new HttpService(RPC));

```
	public static void changeData(Web3j web3j, Credentials credentials, String contractAddress)
			throws Exception {
		ContractGasProvider contractGasProvider = new DefaultGasProvider();
		Multicall contract = Multicall.load(contractAddress, web3j,
				new RawTransactionManager(web3j,
						credentials),
				contractGasProvider);

		CompletableFuture<TransactionReceipt> futureReceipt = contract.setNumber(blockNumber).sendAsync();
		String txHash = futureReceipt.thenApplyAsync(TransactionReceipt::getTransactionHash).get();
		System.out.println("Transaction hash: " + txHash);
		TransactionReceipt tr = futureReceipt.get();
		if (tr.isStatusOK()) {
			// 处理成功的交易结果
			System.out.println("Success");
		} else {
			// 处理失败的交易结果
			System.out.println("Failure");
		}
```








