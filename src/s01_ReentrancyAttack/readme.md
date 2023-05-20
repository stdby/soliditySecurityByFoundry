## 重入攻击

重入攻击是智能合约最常见的一种攻击方式。当一个合约向目标合约转账时，会触发目标合约的fallback或者receive函数，此时目标合约可以回调该合约的函数，切此时的上下文为该合约。



接下来有一份Bank合约：

```solidity
contract Bank {
    mapping (address => uint256) public balanceOf;     
    function deposit() external payable {
        balanceOf[msg.sender] += msg.value;
    }

    
    function withdraw() external {
        uint256 balance = balanceOf[msg.sender]; 
        require(balance > 0, "Insufficient balance");
       
        (bool success, ) = msg.sender.call{value: balance}("");
        require(success, "Failed to send Ether");
   
        balanceOf[msg.sender] = 0;
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
```

这个bank合约有一个明显的重入漏洞，在调用withdraw()时  

(bool success, ) = msg.sender.call{value: balance}("");

如果`msg.sender` 是一个合约，那么这段代码会触发`msg.sender`的`receive`函数，此时可以在`receive`中重新进入该合约再次调用withdraw()

因为此时`balanceOf[msg.sender]`



你可以在终端输入 forge test --match-test testBack -vvvv

来查看详细细节。

