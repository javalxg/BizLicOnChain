pragma solidity ^0.4.25;

contract BaseBizLicOnChain {
    /**
     * 工商局
     */
    struct AicOrgan{
        string organCode;//机关代码
        string organName;//机关名称
        bytes publicKey;//公钥
        bool isUserd;
    }
}
