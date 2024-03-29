package org.web3.utils;

import java.io.IOException;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.web3j.abi.FunctionReturnDecoder;
import org.web3j.abi.TypeReference;
import org.web3j.abi.datatypes.Address;
import org.web3j.abi.datatypes.Type;
import org.web3j.abi.datatypes.generated.Bytes32;
import org.web3j.abi.datatypes.generated.Uint256;
import org.web3j.protocol.Web3j;
import org.web3j.protocol.core.DefaultBlockParameter;
import org.web3j.protocol.core.methods.request.EthFilter;
import org.web3j.protocol.core.methods.response.EthBlock.Block;
import org.web3j.protocol.core.methods.response.EthLog;
import org.web3j.protocol.core.methods.response.EthLog.LogResult;
import org.web3j.protocol.http.HttpService;
import org.web3j.utils.Numeric;

import io.github.cdimascio.dotenv.Dotenv;

public class FilterMulTopics {

    static Dotenv dotenv = Dotenv.load();

    static String RPC_URL = dotenv.get("ALCHEMY_SEPOLIA_URL");

    static Web3j web3j = Web3j.build(new HttpService(RPC_URL));

    static String ERC6551AccountCreated_Topics_0 = "0x79f19b3655ee38b1ce526556b7731a20c8f218fbda4a3990b6cc4172fdf88722";
    static String Transfer_Topics_0 = "0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef";

    public static void main(String[] args) {

        BigInteger blockNumber = new BigInteger("5529921");

        // 循环 12s 执行一次
        while (true) {
            try {
                Block block = web3j.ethGetBlockByNumber(DefaultBlockParameter.valueOf(blockNumber), false)
                        .send().getBlock();

                if (block == null) {
                    System.out.println("待打包区块: " + blockNumber);

                } else {

                    String blockHash = block.getHash();

                    System.out.println("blockNumber: " + Numeric.toBigInt(block.getNumberRaw()));

                    HanderEthFilter(blockHash, ERC6551AccountCreated_Topics_0,
                            Transfer_Topics_0);

                    // TODO：写入数据库，保存中断
                    blockNumber = blockNumber.add(BigInteger.ONE);

                }

            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();

            }

            try {
                Thread.sleep(6000);
            } catch (InterruptedException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }

        }

    }

    public static void HanderEthFilter(String blockHash, String... optionalTopics) {

        // TODO: 一次请求处理多个Topic
        EthFilter filter = new EthFilter(blockHash)
                .addOptionalTopics(optionalTopics);

        try {
            EthLog ethLog = web3j.ethGetLogs(filter).send();

            HanderEthLog(ethLog);
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

    }

    public static void HanderEthLog(EthLog ethLog) {
        // TODO: 处理ethLog

        if (ethLog.getLogs().size() > 0) {
            for (LogResult log : ethLog.getLogs()) {
                JSONObject result = new JSONObject(log.get());
                JSONArray topics = result.getJSONArray("topics");
                String topics_0 = topics.getString(0);
                String address = result.getString("address");

                if (topics_0.equalsIgnoreCase(ERC6551AccountCreated_Topics_0)) {
                    // TODO: hander ERC6551 AccountCreate

                    /*
                     * String tokenContract =
                     * FunctionReturnDecoder.decodeAddress(topics.getString(2));
                     * 
                     * BigInteger tokenId = Numeric.toBigInt(topics.getString(3));
                     * 
                     * String data = result.getString("data");
                     * 
                     * List<TypeReference<Type>> outputParameters = new ArrayList<>();
                     * outputParameters.add((TypeReference) new TypeReference<Address>() {
                     * });
                     * outputParameters.add((TypeReference) new TypeReference<Bytes32>() {
                     * });
                     * outputParameters.add((TypeReference) new TypeReference<Uint256>() {
                     * });
                     * 
                     * List<Type> decodeDatas = FunctionReturnDecoder.decode(data,
                     * outputParameters);
                     * 
                     * String account = (String) decodeDatas.get(0).getValue();
                     */

                } else if (topics_0.equalsIgnoreCase(Transfer_Topics_0)) {
                    // TODO: hander Transfer
                    if (topics.length() == 3) {

                        // hander ERC20 Transfer

                    } else if (topics.length() == 4) {
                        // hander ERC721 Transfer

                    }

                }
            }
        }

    }

}
