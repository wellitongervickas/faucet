// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Storage {
    // Order of storage var are important for memory slots

    // hash togheter: kecckat256(key + slot);
    // web3.eth.getStorageAt(contract_address, keccak256(key + slot)
    mapping(uint => uint) public aa; // slot 0
    mapping(address => uint) public bb; //slot 1

    // web3.eth.getStorageAt(contract_address, keccak256(slot) + index (decimal) of the item)
    // slot = 0000000000000000000000000000000000000000000000000000000000000002  <- 2 = slot
    // index 1 = 29102676481673041902632991033461445430619272659676223336789171408008386403022
    // index 2 = 29102676481673041902632991033461445430619272659676223336789171408008386403022 + 1 = 3 
    // index 2 = 29102676481673041902632991033461445430619272659676223336789171408008386403023 <- 3 = slot
    // index 2 (DEC -> HEX) = 0x405787FA12A823E0F2B7631CC41B3BA8828B3321CA811111FA75CD3AA3BB5ACF
    // is the same number plus 1
    
    // converting the slot to decimal + 1 and covert back to hex
    // web3.eth.getStorageAt(contract_address, "0x405787FA12A823E0F2B7631CC41B3BA8828B3321CA811111FA75CD3AA3BB5ACF")
 
    
    uint[] public cc; // slot 2
    
    // 32 bytes, all values will be stored in slot 3
    // web3.eth.getStorageAt("CONTRACT_ADDRESS", 0)
    // 0x 0f 01 f1bc2f7d6d35bdf3725863bad53a8586d0fee791 000a 07
    // -  15  1 address--------------------------------- 10  7
    uint8 public a = 7; // 1 byte
    uint16 public b = 10; // 2 bytes
    address public c = 0xF1Bc2f7d6d35BdF3725863BaD53a8586D0Fee791; // 20 bytes
    bool d = true; // 1 byte
    uint64 public e = 15; // 8 bytes

    // 32 bytes, all values will be stored in slot 4
    // 0x c8
    uint256 public f = 200; // 32 bytes

    /**
     * We can move this var after H to avoid unused spaces in memory (32 bytes)
     */
    // 32 bytes, all values will be stored in slot 5
    // 0x 28
    uint8 public g = 40; // 1 byte

    // 32 bytes, all values will be stored in slot 6
    // 0x 0315
    uint256 public h = 789; // 32 bytes (315 HEX = 789 DEC)

    // put G here...
    /** 
        Ex:
        // new slot now
        uint8 public g = 40; // 1 byte
        uint8 public i = 40; // 1 byte
        .... ultil 32 bytes and use all slots..
    */

    constructor() {
        cc.push(1);
        cc.push(10);
        cc.push(100);
        aa[2] = 4;
        aa[3] = 10;

        bb[0x2B8B9228E61573A8C46f1C9bEfa063971140F12C] = 100;
    }
}