// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract demo {
uint userId = 1;

    struct USER{
        uint id;
        string name;
    }

    USER[] public users;

    function insert(string memory _name)public {
        users.push(USER({
            id: userId,
            name: _name
        }));    
            userId++;
    }

    function read(uint id)public view returns(string memory,uint){
        USER storage user = users[id - 1]; 
        return (user.name, user.id);
    }

    function find(uint id)public view returns(uint) {
        require(id > 0 && id < users.length, "User does not exist!");
        return id;
    }

}



