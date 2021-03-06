BizLicOnChain
===
## 概述
&ensp;&ensp;&ensp;&ensp;
本应用的主要功能是把营业执照放在区块链（以太坊）上。在区块链上发放营业执照的作用是，不依赖于发证机关（工商局或市场监督局）就可以证明营业执照的合法性。我们做了如下设计：1.只有指定账户（address）才可以提交营业执照；2.营业执照上有发证机关的数字签名。

## 存储设计
&ensp;&ensp;&ensp;&ensp;
存储在区块链中的营业执照，结构如下：
 |属性名|解释|
 |-----|----|
 |organCode|发证机关代码|
 |licContent|证照内容(把企业名称，法定代表人等数据项拼成json串。)|
 |sign|电子签章|
 
 &ensp;&ensp;&ensp;&ensp;
 其中证照内容的结构如下：
 |字段名|解释|
 |----|----|
 |uniScId|统一社会信用码,作为企业的唯一标识|
 |corpName|企业名称|
 |leadName|法定代表人姓名|
 |indsyCode|行业分类代码(GB/T 4754—2017)|
 |bizScope|经营范围(文字描述)|
 |regCpt|注册资金(元)|
 |provDate|核准时间(yyyy-MM-dd)|
 |limitTo|有效期至(yyyy-MM-dd)|
 |issueOrgan|发证机关(中文全称)|
 |otherInfo|其他信息|
 
 ## 如何运行本系统
 
 ### 1. 安装geth
 ### 2. 设置创世区块
 ### 3. 同步区块
 
 &ensp;&ensp;&ensp;&ensp;
 进入geth控制台的命令如下：
 ```
 geth --datadir "data" --networkid 123 --rpc --rpcaddr 0.0.0.0 --rpcport 8545 --rpcapi "eth,miner,net,personal,web3" --allow-insecure-unlock -rpccorsdomain "*" --nodiscover --ipcdisable console 2>>geth.log
 ```
 其中 --allow-insecure-unlock 参数的目的是允许解锁某个账户。

### 4. 创建账户

 &ensp;&ensp;&ensp;&ensp;
 设置挖矿地址：
```
> miner.setEtherbase('用户地址')
```
 &ensp;&ensp;&ensp;&ensp;
 查看挖矿地址：
 ```
 > eth.cornbase
 ```

### 5. 开始挖矿

### 6. 转账测试

&ensp;&ensp;&ensp;&ensp;
先解除账户锁定：
```
> personal.unlockAccount(acc0)
```
 &ensp;&ensp;&ensp;&ensp;
 转账命令如下：
```
> eth.sendTransaction({from: acc0, to: acc1, value: amount})
```
### 7. 按装 truffle
&ensp;&ensp;&ensp;&ensp;
安装完毕后，把私有链矿机的地址注册到truffle的配置文件中。即在truffle-config.js文件中增加如下内容：
```
    MyNetwork: {
      host: "192.168.xx.100";
      port: 8545,             // Custom port
      network_id: 123,       // Custom network
      gas: 8500000,           // Gas sent with each transaction (default: ~6700000)
      gasPrice: 20000000000,  // 20 gwei (in wei) (default: 100 gwei)
      //from: <address>,        // Account to send txs from (default: accounts[0])
      // websockets: true        // Enable EventEmitter interface for web3 (default: false)
    },
```

### 8. 发布电子合约
&ensp;&ensp;&ensp;&ensp;
先解锁账户 account[0]
```
personal.unlockAccount(eth.accounts[0],"********", 100000000)
```
保持私有链矿机挖矿状态。在命令行中输入以下命令：
```
truffle migrate --network MyNetwork
```
