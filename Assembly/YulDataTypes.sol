// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract YulDataTypes {
    function getUint256() external pure returns (uint256) {
        uint256 value;
        assembly {
            value := 100
        }
        return value;
    }

    function demoString() external pure returns (string memory) {
        //会将任何数据强制解释为bytes32
        bytes32 value;
        assembly {
            value := "Hello"
        }
        return string(abi.encode(value));
    }

    function demoAddAssembly()
        external
        view
        returns (
            uint256,
            uint256,
            uint256
        )
    {
        uint256 startGas = gasleft();
        uint256 totalFee;

        uint256 totalPayment;

        assembly {
            totalFee := add(200, 2000)
            totalPayment := 100
        }

        uint256 endGas = gasleft();
        return (totalFee, totalPayment, startGas - endGas);
    }

    function demoAdd()
        external
        view
        returns (
            uint256,
            uint256,
            uint256
        )
    {
        uint256 startGas = gasleft();
        uint256 totalFee;

        uint256 totalPayment;

        totalFee = 200 + 2000;
        totalPayment = 100;

        uint256 endGas = gasleft();
        return (totalFee, totalPayment, startGas - endGas);
    }

    function demoForAssembly() external view returns (uint256, uint256) {
        uint256 startGas = gasleft();
        uint256 result;
        assembly {
            for {
                let i := 0
            } lt(i, 10) {
                i := add(i, 2)
            } {
                result := add(result, i)
            }
        }

        uint256 endGas = gasleft();
        return (result, startGas - endGas);
    }

    function demoFor() external view returns (uint256, uint256) {
        uint256 startGas = gasleft();
        uint256 result;
        {
            for (uint256 i = 0; i < 10; ) {
                unchecked {
                    result = result + i;
                    i = i + 2;
                }
            }
        }

        uint256 endGas = gasleft();
        return (result, startGas - endGas);
    }
}
