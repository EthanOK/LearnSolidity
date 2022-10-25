# Hardhat

## 安装

### 空文件夹，运行npm init

### npm install --save-dev hardhat

### 创建Hardhat项目：npx hardhat

## 编译合约

### npx hardhat compile

## 测试合约
（test文件夹）

### npx hardhat test test/Lock.ts

### 文件详解

-  import { loadFixture } from "@nomicfoundation/hardhat-network-helpers";

	- await loadFixture(函数名)；
	- 避免代码重复并提高测试性能，仅在第一次调用时运行

- import { expect } from "chai";

	- chai 断言库
	- it("Should", async function () { 
        expect();
        });

- import { ethers } from "hardhat";

	- hardhat本地测试的一个ether.js库

- expect

	- 比较：expect(a).to.equal(b);
	- 抛出异常：await expect().to.be.revertedWith("");

## 部署合约
（scripts文件夹）

###  npx hardhat run scripts/deploy.ts

-   const Lock = await ethers.getContractFactory("Lock");
  const lock = await Lock.deployTime, { value: Amount });
  await lock.deployed();

### 运行Hardhat网络

-  npx hardhat node
- npx hardhat run scripts/deploy.ts --network localhost

## ether.js交互GOERLI链

