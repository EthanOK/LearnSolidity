    使用ethers签名
```
const signer = new ethers.Wallet(
    "123456789"
  );
// 签名二进制信息
  // The 66 character hex string MUST be converted to a 32-byte array first!
  let hash =
    "0xf6896007477ab25a659f87c4f8c5e3baac32547bf305e77aa57743046e10578b";
  let binaryData_ = ethers.utils.arrayify(hash);

  let signPromise_ = signer.signMessage(binaryData_);
  signPromise_.then((sign) => {
    console.log("sign hex: " + sign);
    let adr = ethers.utils.verifyMessage(binaryData_, sign);
    console.log("signer address: " + adr);
  });
```

使用Java web3库 以太坊签名
```
package com.utils;

import org.web3j.crypto.Credentials;
import org.web3j.crypto.Hash;
import org.web3j.crypto.Sign;

import org.web3j.utils.Numeric;

public class SigningHexMessage {
    public static void main(String[] args) {

        // 1. 定义私钥和消息哈希
        String privateKeyHex = "123456789";
        String messageHashHex = "0xf6896007477ab25a659f87c4f8c5e3baac32547bf305e77aa57743046e10578b";

        // 2. 从私钥创建凭证对象
        Credentials credentials = Credentials.create(privateKeyHex);

        // 3. 从凭证对象中获取公钥和地址
        String publicKeyHex = Numeric.toHexStringWithPrefixZeroPadded(credentials.getEcKeyPair().getPublicKey(), 128);
        String address = credentials.getAddress();

        // 4. 将消息哈希转换为字节数组
        byte[] messageHash = Numeric.hexStringToByteArray(messageHashHex);
        // 加 ether signed message
        byte[] prefix = "\u0019Ethereum Signed Message:\n32".getBytes();

        byte[] prefixedHash = new byte[prefix.length + messageHash.length];
        System.arraycopy(prefix, 0, prefixedHash, 0, prefix.length);
        System.arraycopy(messageHash, 0, prefixedHash, prefix.length, messageHash.length);

        byte[] signatureHash = Hash.sha3(prefixedHash);

        // 5. 使用私钥和消息哈希生成签名
        Sign.SignatureData signatureData = Sign.signMessage(signatureHash, credentials.getEcKeyPair(), false);

        // 6. 输出地址和签名
        String signature = Numeric.toHexString(signatureData.getR())
                + Numeric.toHexStringNoPrefix(signatureData.getS())
                + Numeric.toHexStringNoPrefix(signatureData.getV());

        System.out.println("Signature: " + signature);

    }
}


```
JAVA 优化版
```
package com.utils;

import java.math.BigInteger;
import java.security.SignatureException;
import java.util.Arrays;
import org.web3j.crypto.Credentials;
import org.web3j.crypto.Keys;
import org.web3j.crypto.Sign;
import org.web3j.crypto.Sign.SignatureData;
import org.web3j.utils.Numeric;

public class SignPrefixedHexMessage {
    public static void main(String[] args) throws SignatureException {

        String privateKeyHex = "0x5c95b········868d71····························";

        // messageHashHex = keccak256(abi.encode(address, uint256))
        String messageHashHex = "0xf6896007477ab25a659f87c4f8c5e3baac32547bf305e77aa57743046e10578b";

        String signerAddress = getAddressFromPrivateKey(privateKeyHex);

        String signatureString = getEthereumSignature(messageHashHex, privateKeyHex);

        boolean verifyResult = verifyEthereumSignature(messageHashHex, signatureString, signerAddress);

        System.out.println("verifyResult:" + verifyResult);
    }

    public static SignatureData convertSignatureToData(String signatureString) {
        // 将签名字符串拆分为字节数组
        byte[] signatureBytes = Numeric.hexStringToByteArray(signatureString);
        // 将签名字节数组解析为SignatureData对象
        byte[] r = Arrays.copyOfRange(signatureBytes, 0, 32);
        byte[] s = Arrays.copyOfRange(signatureBytes, 32, 64);
        byte v = signatureBytes[64];

        return new SignatureData(v, r, s);
    }

    public static boolean verifyEthereumSignature(String messageHashHex, String signatureHashHex, String signer)
            throws SignatureException {
        byte[] messageHash = Numeric.hexStringToByteArray(messageHashHex);
        Sign.SignatureData signatureData = convertSignatureToData(signatureHashHex);
        BigInteger publicKey = Sign.signedPrefixedMessageToKey(messageHash, signatureData);

        if (publicKey != null) {
            String address = "0x" + Keys.getAddress(publicKey);
            return signer.equalsIgnoreCase(address);
        }
        return false;
    }

    public static String getEthereumSignature(String messageHashHex,
            String privateKeyHex) {
        byte[] messageHash = Numeric.hexStringToByteArray(messageHashHex);
        Credentials credentials = Credentials.create(privateKeyHex);
        Sign.SignatureData signatureData = Sign.signPrefixedMessage(messageHash, credentials.getEcKeyPair());
        String signature = Numeric.toHexString(signatureData.getR())
                + Numeric.toHexStringNoPrefix(signatureData.getS())
                + Numeric.toHexStringNoPrefix(signatureData.getV());
        return signature;
    }

    public static String getAddressFromPrivateKey(String privateKeyHex) {
        Credentials credentials = Credentials.create(privateKeyHex);
        String address = credentials.getAddress();
        return address;
    }
}

```
