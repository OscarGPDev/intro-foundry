// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "forge-std/Test.sol";
import "../src/CRUD.sol";

contract CRUDTest is Test {
    UserCRUD public crud;

    function setUp() public {
        crud = new UserCRUD();
    }

    function testCreateUser() public {
        crud.createUser("Alice", 25);

        UserCRUD.User memory user = crud.readUser(1);
        assertEq(user.id, 1);
        assertEq(user.name, "Alice");
        assertEq(user.age, 25);
        assertTrue(user.isActive);
    }

    function testCreateMultipleUsers() public {
        crud.createUser("Alice", 25);
        crud.createUser("Bob", 30);
        crud.createUser("Charlie", 35);

        UserCRUD.User memory user1 = crud.readUser(1);
        UserCRUD.User memory user2 = crud.readUser(2);
        UserCRUD.User memory user3 = crud.readUser(3);

        assertEq(user1.name, "Alice");
        assertEq(user2.name, "Bob");
        assertEq(user3.name, "Charlie");
    }

    function testReadUser() public {
        crud.createUser("Alice", 25);
        UserCRUD.User memory user = crud.readUser(1);

        assertEq(user.id, 1);
        assertEq(user.name, "Alice");
        assertEq(user.age, 25);
        assertTrue(user.isActive);
    }

    function testReadNonExistentUserReverts() public {
        vm.expectRevert("User not found");
        crud.readUser(999);
    }

    function testUpdateUser() public {
        crud.createUser("Alice", 25);
        crud.updateUser(1, "Alice Smith", 26);

        UserCRUD.User memory user = crud.readUser(1);
        assertEq(user.name, "Alice Smith");
        assertEq(user.age, 26);
    }

    function testUpdateNonExistentUserReverts() public {
        vm.expectRevert("User not found");
        crud.updateUser(999, "Alice", 25);
    }

    function testDeleteUser() public {
        crud.createUser("Alice", 25);
        crud.deleteUser(1);
        vm.expectRevert();
        crud.readUser(1);
    }

    function testDeleteNonExistentUserReverts() public {
        vm.expectRevert("User not found");
        crud.deleteUser(999);
    }

    function testAllActiveUsers() public {
        // Create some users
        crud.createUser("Alice", 25);
        crud.createUser("Bob", 30);
        crud.createUser("Charlie", 35);

        // Delete one user
        crud.deleteUser(2);

        UserCRUD.User[] memory activeUsers = crud.allActiveUsers();

        assertEq(activeUsers.length, 2);
        assertEq(activeUsers[0].name, "Alice");
        assertEq(activeUsers[1].name, "Charlie");
    }

    function testEvents() public {
        // Test UserCreated event
        vm.expectEmit(true, true, true, true);
        emit UserCRUD.UserCreated(1, "Alice", 25);
        crud.createUser("Alice", 25);

        // Test UserUpdated event
        vm.expectEmit(true, true, true, true);
        emit UserCRUD.UserUpdated(1, "Alice Smith", 26);
        crud.updateUser(1, "Alice Smith", 26);

        // Test UserDeleted event
        vm.expectEmit(true, true, true, true);
        emit UserCRUD.UserDeleted(1);
        crud.deleteUser(1);
    }
}
