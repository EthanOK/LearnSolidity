# 引用拷贝还是值拷贝
（x = a）

## x是否是成员变量（状态变量、有存储槽）

### 是

- 值拷贝

### 否

- x和a的location是否相同（x不能是calldata类型）

	- 是

		- 引用拷贝

	- 否

		- 值拷贝

