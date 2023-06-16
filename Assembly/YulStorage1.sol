// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// 读写单个存储槽(slot)单个变量 的数据
contract YulStorage1 {
    event UsedGas(uint256);
    uint256 public x;

    function setX(uint256 newX) external {
        uint256 startGas = gasleft();
        x = newX;
        emit UsedGas(startGas - gasleft());
    }

    function getX() external view returns (uint256) {
        return x;
    }

    function getXAssembly() external view returns (uint256 ret) {
        assembly {
            ret := sload(x.slot)
        }
    }

    function setXAssembly(uint256 newX) external {
        uint256 startGas = gasleft();

        assembly {
            sstore(x.slot, newX)
        }

        emit UsedGas(startGas - gasleft());
    }
}
