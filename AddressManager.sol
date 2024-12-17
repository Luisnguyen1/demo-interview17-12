// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AddressManager {
    address[] private userAddresses;

    event AddressAdded(address indexed user);
    event AddressRemoved(address indexed user);

    // Thêm địa chỉ vào danh sách
    function addAddress(address _user) public {
        require(_user != address(0), "Dia chi khong hop le");
        userAddresses.push(_user);
        emit AddressAdded(_user);
    }

    // Xóa địa chỉ khỏi danh sách
    function removeAddress(uint _index) public {
        require(_index < userAddresses.length, "Index ngoai pham vi");
        
        address removedAddress = userAddresses[_index];
        userAddresses[_index] = userAddresses[userAddresses.length - 1];
        userAddresses.pop();
        emit AddressRemoved(removedAddress);
    }

    // Lấy danh sách địa chỉ
    function getAddresses() public view returns (address[] memory) {
        return userAddresses;
    }
}
