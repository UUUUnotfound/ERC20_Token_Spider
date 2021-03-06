//token_name	
//token_url	https://etherscan.io//address/0x99eec5172b0b0eb20af41bb7999f4143fa323bda#code
//spider_time	2018/07/08 12:17:03
//token_Transactions	1 txn
//token_price	

pragma solidity ^0.4.18; 
 
contract BaseCertoChainContract {
    address creator; 
    bool public isSealed;
      
    function BaseCertoChainContract() public    {   creator = msg.sender;   }
    
    modifier onlyBy(address _account)
    {
        require(msg.sender != _account);
        _;
    }
    
    
     modifier onlyIfNotSealed() //semantic when sealed is not possible to change sensible data
    {
        if (isSealed)
            throw;
        _;
    }
    
    function kill() onlyBy(creator)
    {               suicide(creator);     }
     
     function setCreator(address _creator)  onlyBy(creator)
    {           creator = _creator;     }
    
    
function setSealed()  onlyBy(creator)  { isSealed = true;  EventSealed(this);   } //seal down contract not reversible

 event EventSealed(address self); //invoked when contract is sealed

}
contract DocumentCertoChainContract   is BaseCertoChainContract    
{  
  
    string  public  Name;         //Product
    string  public  Description ; //Description
    string  public  FileName;     //ProductionData
    string  public  FileHash;     //SecuritySeal
    string  public  FileData;     //SecuritySeal
    address public  Revision; 
    address public  NextOwner; 
    address public  PrevOwner; 
    
    
    
    
   //function   DocumentCertoChainContract() public
   //{}
    
    function DocumentCertoChainContract(string _Description, string _FileName,string _FileHash,string _FileData) public
    //onlyBy(creator)
    {
          Revision=address(this);
          NextOwner=address(this);
          Description=_Description;
          FileName=_FileName;
          FileHash=_FileHash;
          FileData=_FileData;
       
    }
    
    function setRevision(address _Revision)  onlyBy(creator) onlyIfNotSealed()
    {
          Revision = _Revision;
          EventNewRevision(this);
        
    }
     
     
     function setNextOwner(address _NextOwner)  onlyBy(creator) onlyIfNotSealed()
    {
          NextOwner = _NextOwner;
          EventNewOwner(this);
    }
    
     function setPrevOwner(address _PrevOwner)  onlyBy(creator) onlyIfNotSealed()
    {
          PrevOwner = _PrevOwner;
          EventNewPrevOwner(this);
    }
     event EventNewOwner(address self);
     event EventNewPrevOwner(address self);
     event EventNewRevision(address self); 
}