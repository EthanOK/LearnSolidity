// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 读写单个存储槽(slot)多个变量 的数据
contract YulStorage2 {
    event UsedGas(uint256);

    // all in a slot 0
    uint128 public a = 1; // 16 bytes
    uint96 public b = 2; // 12 bytes
    uint16 public c = 3; // 2 bytes
    uint8 public d = 4; // 1 bytes
    bool public e = true; // 1 bytes

    // 0x0104000300000000000000000000000200000000000000000000000000000001
    function getSlotBytes(uint256 slot)
        external
        view
        returns (bytes32 slotData, uint256 usedGas)
    {
        uint256 startGas = gasleft();

        assembly {
            slotData := sload(slot)
        }

        usedGas = startGas - gasleft();
    }

    function getOffsetC()
        external
        view
        returns (uint256 offset, uint256 usedGas)
    {
        uint256 startGas = gasleft();
        assembly {
            offset := c.offset
        }
        usedGas = startGas - gasleft();
    }

    function readC() external view returns (uint256 dataC, uint256 usedGas) {
        uint256 startGas = gasleft();
        assembly {
            // 0x0104000300000000000000000000000200000000000000000000000000000001
            let data_t := sload(c.slot)
            let offset := c.offset
            // shr 将数据右移几个bit位
            // 0x0000000000000000000000000000000000000000000000000000000001040003
            let data := shr(mul(offset, 8), data_t)
            // '与' 两个字节
            dataC := and(0xffff, data)
        }
        usedGas = startGas - gasleft();
    }

    function writeCAssembly(uint16 newC) external {
        // newC = 0x1234
        uint256 startGas = gasleft();
        assembly {
            // 0x0104000300000000000000000000000200000000000000000000000000000001
            let data_t := sload(c.slot)
            let offset := c.offset
            // shr 将数据右移几个bit位
            // 0x0104 0003 00000000000000000000000200000000000000000000000000000001  c
            // 0xffff 0000 ffffffffffffffffffffffffffffffffffffffffffffffffffffffff
            let clearedC := and(
                0xffff0000ffffffffffffffffffffffffffffffffffffffffffffffffffffffff,
                data_t
            )
            // 0x0104 0000 00000000000000000000000200000000000000000000000000000001  clearedC

            // newC = 0x1234 左移 几个比特位
            let shiftL := shl(mul(offset, 8), newC)
            // 0x0000 1234 00000000000000000000000000000000000000000000000000000000

            let newValue := or(clearedC, shiftL)
            // 0x0104 1234 00000000000000000000000200000000000000000000000000000001  newValue
            sstore(c.slot, newValue)
        }

        emit UsedGas(startGas - gasleft());
    }

    function writeC(uint16 newC) external {
        // newC = 0x1234
        uint256 startGas = gasleft();
        c = newC;
        emit UsedGas(startGas - gasleft());
    }
}
