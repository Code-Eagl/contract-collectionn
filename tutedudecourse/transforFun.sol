// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.4.22 <0.9.0;

contract transforFun{
     bool success ;
    function fund(address recipient)public payable {
        require(msg.value > 0, "Must send some ethers");
        // payable (recipient).transfer(msg.value);
        success = payable (recipient).send(msg.value);
    }
    function getBalence(address account) view public  returns (uint256){
        return account.balance;
    }
    // transfor ---->  2300 gas -----> error------> reverted
    // send ---> 2300 gas -----> bool value ----> not revert
    //call -----> flexible gas

}