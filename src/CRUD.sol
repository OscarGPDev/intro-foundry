// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract UserCRUD {
    struct User {
        uint256 id;
        string name;
        uint256 age;
        bool isActive;
    }

    mapping(uint256 => User) users;
    uint256 currentId = 1;

    event UserCreated(uint256 id, string name, uint256 age);
    event UserUpdated(uint256 id, string name, uint256 age);
    event UserDeleted(uint256 id);

    function createUser(string calldata name, uint256 age) public {
        users[currentId] = User(currentId, name, age, true);
        currentId++;
        emit UserCreated(currentId, name, age);
    }

    function readUser(uint256 id) public view returns (User memory) {
        require(users[id].id != 0 && users[id].isActive != false, "User not found");
        return users[id];
    }

    function updateUser(uint256 id, string calldata name, uint256 age) public {
        require(users[id].id != 0 && users[id].isActive != false, "User not found");
        User storage user = users[id];
        user.name = name;
        user.age = age;
        emit UserUpdated(id, name, age);
    }

    function deleteUser(uint256 id) public {
        require(users[id].id != 0 && users[id].isActive != false, "User not found");
        users[id].isActive = false;
        emit UserDeleted(id);
    }

    function allActiveUsers() public view returns (User[] memory) {
        uint256 activeCount = 0;
        for (uint256 i = 1; i < currentId; i++) {
            if (users[i].isActive) {
                activeCount++;
            }
        }

        User[] memory activeUsers = new User[](activeCount);

        uint256 index = 0;
        for (uint256 i = 1; i < currentId; i++) {
            if (users[i].isActive) {
                activeUsers[index] = users[i];
                index++;
            }
        }

        return activeUsers;
    }
}
