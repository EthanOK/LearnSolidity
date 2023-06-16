// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// array mapping
contract YulStorage3 {
    event UsedGas(uint256);

    uint256[3] fixedLenArray;
    uint256[] dynamicArray;
    uint16[] smallArray; // 2 bytes
    mapping(uint256 => uint256) public myMapping;
    mapping(uint256 => mapping(uint256 => uint256)) public myMapping2;
    mapping(address => uint256[]) public myMappingAddress;

    /*
    fixedLenArray[0] slot0
    fixedLenArray[1] slot1
    fixedLenArray[2] slot2

    dynamicArray.length slot3
    smallArray.length slot4
    myMapping slot5
    myMapping2 slot6
    myMappingAddress slot7
    */

    constructor() {
        fixedLenArray = [100, 200, 300];
        dynamicArray = [1, 2, 3, 4, 8];
        smallArray = [3, 4, 5, 6];
        myMapping[1] = 1111;
        myMapping2[1][2] = 8888;
        myMappingAddress[0x5B38Da6a701c568545dCfcB03FcB875f56beddC4] = [
            777,
            888,
            999
        ];
    }

    function readfFixedLenArray(uint256 index)
        external
        view
        returns (uint256 slot, uint256 data)
    {
        assembly {
            slot := fixedLenArray.slot
            data := sload(add(slot, index))
        }
    }

    function writefFixedLenArray(uint256 index, uint256 value) external {
        uint256 startGas = gasleft();
        assembly {
            let slot := fixedLenArray.slot
            sstore(add(slot, index), value)
        }
        emit UsedGas(startGas - gasleft());
    }

    function readDynamicArrayLength()
        external
        view
        returns (uint256 slot, uint256 length)
    {
        // 动态数组所占slot内存储的是 数组长度
        assembly {
            slot := dynamicArray.slot
            length := sload(slot)
        }
    }

    function readDynamicArray(uint256 index)
        external
        view
        returns (uint256 data)
    {
        uint256 slot;
        assembly {
            slot := dynamicArray.slot
        }
        // 动态数组真正的存储位置
        bytes32 location = keccak256(abi.encode(slot));

        assembly {
            data := sload(add(location, index))
        }
    }

    function writeDynamicArray(uint256 index, uint256 value) external {
        uint256 startGas = gasleft();
        uint256 slot;
        assembly {
            slot := dynamicArray.slot
        }
        // 动态数组真正的存储位置
        bytes32 location = keccak256(abi.encode(slot));

        assembly {
            sstore(add(location, index), value)
        }
        emit UsedGas(startGas - gasleft());
    }

    function readSmallArrayLength()
        external
        view
        returns (uint256 slot, uint256 length)
    {
        // 动态数组所占slot内存储的是 数组长度
        assembly {
            slot := smallArray.slot
            length := sload(slot)
        }
    }

    function readSmallArray(uint256 index)
        external
        view
        returns (bytes32 data)
    {
        uint256 slot;
        assembly {
            slot := smallArray.slot
        }
        // 动态数组真正的存储位置
        bytes32 location = keccak256(abi.encode(slot));

        assembly {
            data := sload(add(location, index))
        }
    }

    function getMappingValue(uint256 key)
        external
        view
        returns (uint256 value)
    {
        uint256 slot;
        assembly {
            slot := myMapping.slot
        }
        // maspping[] 真正的存储位置
        bytes32 location = keccak256(abi.encode(key, slot));
        assembly {
            value := sload(location)
        }
    }

    function getMapping2Value(uint256 key1, uint256 key2)
        external
        view
        returns (uint256 value)
    {
        // myMapping2[key1][key2]
        uint256 slot;
        assembly {
            slot := myMapping2.slot
        }
        // maspping[][] 真正的存储位置
        bytes32 location = keccak256(
            abi.encode(key2, keccak256(abi.encode(key1, slot)))
        );
        assembly {
            value := sload(location)
        }
    }

    function getmyMappingAddressListLength(address key)
        external
        view
        returns (uint256 length)
    {
        uint256 slot;
        assembly {
            slot := myMappingAddress.slot
        }
        // maspping[] 真正的存储位置
        bytes32 location = keccak256(abi.encode(key, slot));
        assembly {
            length := sload(location)
        }
    }

    function getmyMappingAddressList(address key, uint256 index)
        external
        view
        returns (uint256 value)
    {
        uint256 slot;
        assembly {
            slot := myMappingAddress.slot
        }
        // maspping[] 真正的存储位置
        bytes32 location_array = keccak256(abi.encode(key, slot));
        assembly {
            // sload(location)  uint256[] 的长度
            let length := sload(location_array)
        }
        bytes32 location2 = keccak256(abi.encode(location_array));
        assembly {
            value := sload(add(location2, index))
        }
    }
}
