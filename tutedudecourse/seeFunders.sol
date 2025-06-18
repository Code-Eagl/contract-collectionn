// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.4.22 <0.9.0;

contract seeFunders {
    address public  owner;
    mapping (address=> uint256) public funders;
    constructor(){
        owner=msg.sender;
    }
   
    modifier onlyowner(){
        require(msg.sender==owner, "onluy owner can see");
        _;
    }
    function fund() public payable {
        require(msg.value >0, "cannot be zero must send some ethers");
        funders[msg.sender]=funders[msg.sender]+msg.value;

    }

    // function to withdrow thw money
    function withdrows(uint amt)public  onlyowner {
        require(address(this).balance>amt, "insufficient balance");
        // payable (owner).transfer(amt);
        (bool success,)=payable(owner).call{value:amt}("");
        require(success, "Invalid");

    }
    function getBlanc() public  view returns(uint256){
        return address(this).balance;
    }
    function getFundamt(address funder) public view returns (uint256){
        return funders[funder];
    }
}