# Solidity多重继承

## 关键字：is

## 关键字

### virtual

### override

## 多重继承中超类顺序

### 从左到右

-  Inheritance must be ordered from “most base-like” to “most derived”.
- 继承必须从“最基类”到“最派生”排序。 
- “高辈分-低辈分”
- “兄弟之间可互换位置”

	- D is B, C
	- D is C, B

### 例子：

- B is A
- C is A
- 则：E is A, B

	- 先继承A

## C3 线性化

### 从右到左

### [继承树](https://solidity-by-example.org/super/)

- DCBA

	- 翻转：ABCD(构造函数执行)

## super

### 指的是c3序列化之后某合约的前驱，并不是该合约的超类

- C合约的前驱是B，super指的是B合约

## 存储布局

### 超类基类”一家人“，和同一合约存储关系相同

