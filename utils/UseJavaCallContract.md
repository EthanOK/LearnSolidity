https://github.com/EthanOK/myweb3_java/blob/master/src/main/java/org/web3/Main.java

## use java connect contract

```solidity
contract Multicall {
    uint256 public number;

    struct Call {
        address target;
        bytes callData;
    }

    function aggregate(Call[] calldata calls)
        public
        returns (uint256 blockNumber, bytes[] memory returnData)
    {
        blockNumber = block.number;
        returnData = new bytes[](calls.length);
        for (uint256 i = 0; i < calls.length; i++) {
            (bool success, bytes memory ret) = calls[i].target.call(
                calls[i].callData
            );
            require(success, "Multicall aggregate: call failed");
            returnData[i] = ret;
        }
    }

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

### 只查询合约

#### getCurrentBlockTimestamp()

Web3j web3j = Web3j.build(new HttpService(RPC));

```java
	// Read only public function
	ContractGasProvider contractGasProvider = new DefaultGasProvider();
	Multicall2Test contract = Multicall2Test.load(multicallAddressEveryone, web3j,
			new ReadonlyTransactionManager(web3j, null), contractGasProvider);
	BigInteger blockTimestamp = contract.getCurrentBlockTimestamp().sendAsync().get();
	System.out.println("BlockTimestamp:" + blockTimestamp);
```

### 交互合约（花 gas 费或有权限限制）

#### setNumber(uint256)

Credentials credentials = Credentials.create(privatekey);

Web3j web3j = Web3j.build(new HttpService(RPC));

```java
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

## 查询智能合约的状态 eth_call

https://docs.web3j.io/4.11.0/transactions/transactions_and_smart_contracts/#querying-the-state-of-a-smart-contract

```java
	DynamicStruct[] callDatas = new DynamicStruct[len];

	for (int i = 0; i < len; i++) {
		byte[] bytesData = Numeric.hexStringToByteArray(encodedtokenURI);
		callDatas[i] = new DynamicStruct(
						new Address(tokenAddress),
						new DynamicBytes(bytesData));
	}

	DynamicArray<DynamicStruct> callDatasArray = new DynamicArray<DynamicStruct>(DynamicStruct.class, callDatas);

	Function function = new Function("aggregate", Arrays.asList(callDatasArray),
					Arrays.asList(new TypeReference<Uint256>() {
					}, new TypeReference<DynamicArray<DynamicBytes>>() {
					}));

	String encodedFunction = FunctionEncoder.encode(function);

	EthCall ethCall = web3j.ethCall(
					Transaction.createEthCallTransaction(
									null,
									multicalladdress,
									encodedFunction),
					DefaultBlockParameterName.LATEST)
					.sendAsync().get();

	// 解析返回数据
	List<Type> response = FunctionReturnDecoder.decode(ethCall.getValue(), function.getOutputParameters());


```
