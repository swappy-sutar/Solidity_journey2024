// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

    contract Car {
        uint internal wheels = 4;
        uint internal horsePower = 800;
        string internal carType = "SUV";

        function carDetails() public virtual view returns (string memory, uint, uint) {
            return (carType, wheels, horsePower);
        }
    }

    contract SuperCar is Car {
        function model() external pure returns (string memory) {
            return "Bugatti";
        }

        // Overriding carDetails function
        function carDetails() public view override returns (string memory, uint, uint) {
            return ("SuperCar", wheels, horsePower * 2);
        }
    }

    contract ElectricCar is Car {
        uint public batteryCapacity = 100;

        function carDetails() public view override returns (string memory, uint, uint) {
            return ("ElectricCar", wheels, horsePower / 2); // ElectricCar has half the horsepower
        }
    }