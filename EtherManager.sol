// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherManager {
    mapping(address => uint256) private balances; // Lưu số Ether của từng người dùng
    mapping(address => bool) private hasReceivedDefault; // Kiểm tra xem user đã nhận 10 đồng chưa
    uint256 public constant DEFAULT_AMOUNT = 10; // Số đồng mặc định mỗi user nhận

    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);

    // Constructor được đánh dấu là payable
    constructor() payable {}

    // Hàm gửi Ether vào hợp đồng
    function deposit() public payable {
        require(msg.value > 0, "Must send Ether to deposit");

        // Cộng Ether vào balance của người dùng
        balances[msg.sender] += msg.value;

        // Cấp 10 đồng mặc định nếu user chưa nhận
        if (!hasReceivedDefault[msg.sender]) {
            balances[msg.sender] += DEFAULT_AMOUNT; // Cộng thêm 10 đồng
            hasReceivedDefault[msg.sender] = true; // Đánh dấu đã nhận
        }

        emit Deposit(msg.sender, msg.value);
    }

    // Hàm rút Ether từ hợp đồng
    function withdraw() public {
        uint256 userBalance = balances[msg.sender];
        require(userBalance > 0, "Insufficient balance");

        // Đặt lại số dư của người dùng về 0
        balances[msg.sender] = 0;

        // Gửi Ether trở lại ví của người dùng
        payable(msg.sender).transfer(userBalance);

        emit Withdraw(msg.sender, userBalance);
    }

    // Hàm kiểm tra số dư của người dùng
    function getBalance(address user) public view returns (uint256) {
        return balances[user];
    }
}
