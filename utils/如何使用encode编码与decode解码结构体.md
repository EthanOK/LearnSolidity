# 如何使用encode编码与decode解码 结构体

solidity:

```solidity
pragma solidity ^0.8.0;

contract MyContract {
    struct Person {
        string name;
        Address address;
    }

    struct Address {
        string street;
        string city;
    }

    function encodePerson(Person memory person) public pure returns (bytes memory) {
        return abi.encode(person);
    }
    
     function decodePerson(bytes memory data) public pure returns (Person memory) {
        return abi.decode(data, (Person));
    }
}
```

(一) ethers.js

编码 struct:

```javascript
const { defaultAbiCoder } = require('ethers').utils;

const person = {
  name: "Alice",
  address: {
    street: "123 Main St",
    city: "San Francisco"
  }
};

const encodedPerson = defaultAbiCoder.encode(
  ['string', ['string', 'string']],
  [person.name, [person.address.street, person.address.city]]
);

console.log(encodedPerson);
```



解码 struct：

```javascript
const decodedPerson = defaultAbiCoder.decode(
  ['string', ['string', 'string']],
  encodedPerson
);

console.log(decodedPerson);
```

（二）web3.js

编码 struct:

```javascript
const Web3 = require('web3');
const web3 = new Web3('http://localhost:8545');

const person = {
  name: 'Alice',
  address: {
    street: '123 Main St',
    city: 'Anytown'
  }
};

const encodedPerson = web3.eth.abi.encodeStruct(
  [
    {
      type: 'string',
      name: 'name'
    },
    {
      type: 'tuple',
      name: 'address',
      components: [
        {
          type: 'string',
          name: 'street'
        },
        {
          type: 'string',
          name: 'city'
        }
      ]
    }
  ],
  [person.name, [person.address.street, person.address.city]]
);

console.log(encodedPerson);

```

​			

解码 struct：

```javascript
const Web3 = require('web3');
const web3 = new Web3('http://localhost:8545');

const data = '0x73616d706c6520746f776e206e616d65000000000000000000000000000000006a686f6e6573207374726565740000000000000000000000000000000000000000000000000000000000000003';
const decodedPerson = web3.eth.abi.decodeParameters(
  [
    {
      type: 'string',
      name: 'name'
    },
    {
      type: 'tuple',
      name: 'address',
      components: [
        {
          type: 'string',
          name: 'street'
        },
        {
          type: 'string',
          name: 'city'
        }
      ]
    }
  ],
  data
);

console.log(decodedPerson);

```



