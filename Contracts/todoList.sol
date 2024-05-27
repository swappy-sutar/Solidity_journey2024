// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ToDoList {
    struct Todo {
        string title;
        string description;
    }
    
    // Array of Todo structs
    Todo[] private todos;

    // Function to create a new todo item
    function createList(string calldata _title, string calldata _description) public {
        todos.push(Todo({
            title: _title,
            description: _description
        }));
    }

    // Function to get a todo item by index
    function getList(uint _index) public view returns (string memory, string memory) {
        require(_index < todos.length, "Index out of bounds");
        Todo storage todo = todos[_index];
        return (todo.title, todo.description);
    }


    function deleteList(uint _index) public {
        require(_index < todos.length, "Index not found");
        
        todos[_index] = todos[todos.length - 1];
        // Remove the last element
        todos.pop();
    }

   function getAllList() public view returns (string[] memory, string[] memory) {
        string[] memory titles = new string[](todos.length);
        string[] memory descriptions = new string[](todos.length);

        for (uint i = 0; i < todos.length; i++) {
            Todo storage todo = todos[i];
            titles[i] = todo.title;
            descriptions[i] = todo.description;
        }

        return (titles, descriptions);
    }
}
