// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Storage {
    // Order of storage var are important for memory slots

    mapping(uint => uint) public aa; // slot 0
    mapping(address => uint) public bb; //slot 1

    // hash togheter: kecckat256(slot) + index;
    // web3.eth.getStorageAt(contract_address, keccak256(slot) + index (decimal) of the item)
    // slot = 0x0000000000000000000000000000000000000000000000000000000000000002 => to HEX + (index)
 
    
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