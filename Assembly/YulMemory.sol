// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract YulMemory {
    event MemoryPointer(bytes32);
    event MemoryPointerV2(bytes32, bytes32);

    struct Point {
        uint256 x;
        uint256 y;
        uint256 z;
    }

    constructor() {}

    function readMemoryValue() external pure returns (bytes32 ret) {
        assembly {
            pop(mload(0xffffffffffff))
        }
    }

    function differentMstore(uint8 x)
        external
        pure
        returns (bytes1 a, bytes32 b)
    {
        assembly {
            // 一个字节
            mstore8(0x00, x)
            a := mload(0x00)
            // 32个字节
            mstore(0x00, x)
            b := mload(0x00)
        }
    }

    function structMemory() external {
        // 0x40 free point
        bytes32 pt;
        assembly {
            pt := mload(0x40) //0x80
        }
        emit MemoryPointer(pt);

        Point memory p = Point(1, 2, 3);
        assembly {
            pt := mload(0x40) //0xe0 = 0x80 + 0x60
        }
        emit MemoryPointer(pt);
    }

    function structMemory2() external {
        // 0x40 free point
        bytes32 pt;
        bytes32 size;
        assembly {
            pt := mload(0x40) //0x80
            size := msize()
        }
        emit MemoryPointerV2(pt, size);

        Point memory p = Point(1, 2, 3);
        assembly {
            pt := mload(0x40) //0xe0 = 0x80 + 0x60
            size := msize()
        }
        emit MemoryPointerV2(pt, size);
    }

    function fixedArray() external {
        // 0x40 free point
        bytes32 pt;
        bytes32 size;
        assembly {
            pt := mload(0x40) //0x80
            size := msize()
        }
        emit MemoryPointerV2(pt, size);

        uint256[2] memory a = [uint256(1), uint256(2)];
        assembly {
            pt := mload(0x40) //0xe0 = 0x80 + 0x60
            size := msize()
        }
        emit MemoryPointerV2(pt, size);
    }

    function abiEncode() external {
        // 0x40 free point
        bytes32 pt;
        bytes32 size;
        assembly {
            pt := mload(0x40) //0x80
            size := msize()
        }
        emit MemoryPointerV2(pt, size);

        abi.encode(uint256(1), uint256(2));
        assembly {
            pt := mload(0x40) //0xe0 = 0x80 + 0x60
            size := msize()
        }
        emit MemoryPointerV2(pt, size);
    }

    function abiEncodePacked() external {
        // 0x40 free point
        bytes32 pt;
        bytes32 size;
        assembly {
            pt := mload(0x40) //0x80
            size := msize()
        }
        emit MemoryPointerV2(pt, size);

        abi.encodePacked(uint256(1), uint128(2), uint8(3));
        assembly {
            pt := mload(0x40) //0xe0 = 0x80 + 0x60
            size := msize()
        }
        emit MemoryPointerV2(pt, size);
    }

    event Debug(bytes32, bytes32, bytes32, bytes32);

    function arrayValues(uint256[] memory arr) external {
        bytes32 location;
        bytes32 length;
        bytes32 valueIndex0;
        bytes32 valueIndex1;
        assembly {
            location := arr //0x80
            length := mload(location)
            // 0x20 = 32 bytes
            valueIndex0 := mload(add(location, 0x20))
            valueIndex1 := mload(add(location, 0x40))
        }
        emit Debug(location, length, valueIndex0, valueIndex1);
    }
}
