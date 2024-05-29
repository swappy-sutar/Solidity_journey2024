// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

    struct Todo{
        string title;
        string description;
    }

    import "./todoList.sol";


    contract Todos{
        

        function use(string memory _title, string memory _description)public {
            Todo.title = _title;
            Todo.description = _description;

        }
    }