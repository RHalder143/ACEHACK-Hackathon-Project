pragma solidity ^0.4.24;
contract insurance{
    address public owner;

    struct citizen{
    bool isuidgenerated;
    string name;
    uint amountinsured;
    }
    mapping(address => citizen) public citizenmapping;
    mapping(address => bool) public doctormapping;

    constructor(){
        owner= msg.sender;
    }
    modifier onlyowner(){
        require(owner == msg.sender);
        _; 
           }
    function setdoctor(address _address) onlyowner{
        require(!doctormapping[_address]);
        doctormapping[_address]=true;
    } 
      function setcitizendata(string _name,uint _amountinsured) onlyowner returns (address){
          address uniqueid= address(sha256(msg.sender,now));
          require(!citizenmapping[uniqueid].isuidgenerated);
          citizenmapping[uniqueid].isuidgenerated=true;
          citizenmapping[uniqueid].name= _name;
          citizenmapping[uniqueid].amountinsured= _amountinsured;
          return uniqueid;
      } 
      function useinsurance(address _uniqueid,uint _amountused) returns(string){
          require(doctormapping[msg.sender]);
          if(citizenmapping[_uniqueid].amountinsured< _amountused){
              throw;
          }
          citizenmapping[_uniqueid].amountinsured -= _amountused;
          return "Insurance has been used successfully";
      }
}