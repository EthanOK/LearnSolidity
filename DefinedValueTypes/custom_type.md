# using for

`using A for B (global)`

A 可以是以下之一：

- 函数列表: `using {f, g as +, h, L.t} for uint`

- 库的名称: `using L for uint`

global 关键字：用于指定某个函数或操作符可以在全局范围内使用，而不需要显式地引用其所在的库或类型。

# 用户定义值类型

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

type Currency is address;

using {greaterThan as >, equals as ==} for Currency global;

function equals(Currency currency, Currency other) pure returns (bool) {
    return Currency.unwrap(currency) == Currency.unwrap(other);
}

function greaterThan(Currency currency, Currency other) pure returns (bool) {
    return Currency.unwrap(currency) > Currency.unwrap(other);
}
```

用户定义值类型使用 type C is V 来定义，其中 C 是新引入类型的名称，而 V 必须是内置值类型（“底层类型”）。函数 C.wrap 用于从基础类型转换为自定义类型。同样，函数 C.unwrap 用于从自定义类型转换为基础类型.

目前，没有为用户定义的值类型定义运算符。特别是，即使是运算符 == 未定义。

[user-defined-value-types](https://docs.soliditylang.org/en/latest/types.html#user-defined-value-types)

# 为用户定义类型定义自定义运算符

```solidity
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;

type UFixed16x2 is uint16;

using {
    add as +,
    div as /
} for UFixed16x2 global;

uint32 constant SCALE = 100;

function add(UFixed16x2 a, UFixed16x2 b) pure returns (UFixed16x2) {
    return UFixed16x2.wrap(UFixed16x2.unwrap(a) + UFixed16x2.unwrap(b));
}

function div(UFixed16x2 a, UFixed16x2 b) pure returns (UFixed16x2) {
    uint32 a32 = UFixed16x2.unwrap(a);
    uint32 b32 = UFixed16x2.unwrap(b);
    uint32 result32 = a32 * SCALE / b32;
    require(result32 <= type(uint16).max, "Divide overflow");
    return UFixed16x2.wrap(uint16(a32 * SCALE / b32));
}

contract Math {
    function avg(UFixed16x2 a, UFixed16x2 b) public pure returns (UFixed16x2) {
        return (a + b) / UFixed16x2.wrap(200);
    }
}
```

如果你定义一个运算符（例如 using {f as +} for T global），那么:

- 类型（ T ）必须是 用户定义的值类型
- 并且定义必须是 pure 函数
- 运算符定义必须是全局的`global`

[using-for](https://docs.soliditylang.org/en/latest/contracts.html#using-for)
