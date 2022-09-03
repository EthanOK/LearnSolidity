在Uniswap源码看到工厂合约 UniswapV2 Factory中createPair方法,使用了create2,预先知道配对合约地址,参考:https://github.com/Uniswap/v2-core/blob/master/contracts/UniswapV2Factory.sol

在之后路由合约拿配对的合约地址的时候,就不用从工厂合约里取得了,通过pairFor方法和Token地址获取.参考:https://github.com/Uniswap/v2-periphery/blob/master/contracts/libraries/UniswapV2Library.sol
