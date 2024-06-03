// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

contract functions {
    function returnMany()
        public
        pure
        returns (
            uint256,
            bool,
            string memory
        )
    {
        return (10, true, "swap");
    }

    function returnManyNamed()
        public
        pure
        returns (
            uint256 a,
            bool b,
            string memory c
        )
    {
        return (10, true, "swap");
    }

    function assigned()
        public
        pure
        returns (
            uint256 a,
            bool b,
            string memory c
        )
    {
        a = 10;
        b = true;
        c = "swap";
    }

    //use destructure assignment when calling another.

    function destructureAssigned()
        public
        pure
        returns (
            uint256,
            bool,
            string memory,
            uint256,
            bool,
            string memory
        )
    {
        (uint256 a, bool b, string memory c) = returnMany();
        (uint256 x, bool y, string memory z) = (20, false, "sam");
        return (a, b, c, x, y, z);
    }


    //can not use mapp either input or output.
    //can use array for input. 
    function inputArray(uint[] memory _arr)public {
        arr = _arr;
    }

    uint[] public arr;

    //can use array for output. 
    function outputArray()public view returns (uint[] memory){
        return arr;
    }
}


contract ABC {
    function someFuncWithManyInputs(
        uint a, 
        uint b, 
        uint c, 
        address d, 
        bool e
    ) 
        public 
        pure 
        returns (uint, address, bool) 
    {
        return (a + b + c, d, e);
    }

    function callFunction() 
        external 
        pure 
        returns (uint, address, bool) 
    {
        (uint sum, address addr, bool flag) = someFuncWithManyInputs(
            1, 
            2, 
            3, 
            0x80d527dF27B22d91E1AC56868e7AA5e7Ebf4BB9B, 
            true
        );

        return (sum, addr, flag);
    }

 
}