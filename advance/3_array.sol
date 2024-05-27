// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

    contract array{

        uint[] public arr1;
        // uint[] public arr2 = [1,2,3,4,5];
        // uint[5] public fixSixedArr;

        function getArr()public view returns (uint[] memory){
            return arr1;
        }
        function pushElement(uint i)public{
            arr1.push(i);
        }
        function popElement()public{
            //pop removes the last elemnet from array.
            arr1.pop();
        }
        function lenghOfArr()public view returns (uint) {
            return arr1.length;
        }

          function deleteIndex(uint index)public {
            //delete does not change the array length.
            //it resets the value at index to default value == 0.
            delete arr1[index];
        }
        
        function replaceAndShiftingLastEle(uint _index)public {
            //when we deleting index value but it default store 0 and this function remove the 0
            arr1[_index] = arr1[arr1.length - 1];

            arr1.pop();
        }

        function examples() external pure {
            uint[] memory a = new uint[](5);
            //The memory keyword indicates that the array is a temporary array that exists only during the execution of the function. 
            //Arrays in memory are not stored on the blockchain and are used for temporary storage within functions.
        }
    }
   