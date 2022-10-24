// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract WavePortal {
   uint256 totalWaves;

   uint256 private seed;

    event NewWave(address indexed from, uint256 timestamp, string message);

     struct Wave {
        address waver; // The address of the user who waved.
        string message; // The message the user sent.
        uint256 timestamp; // The timestamp when the user waved.
    }

    Wave[] waves;

    mapping(address => uint256) public lastWavedAt;


   constructor() payable {
  console.log("We have been constructed!");

  seed = (block.timestamp + block.difficulty) % 100;
}

    /*
     * You'll notice I changed the wave function a little here as well and
     * now it requires a string called _message. This is the message our user
     * sends us from the frontend!
     */
   function wave(string memory _message) public {
    require(lastWavedAt[msg.sender] + 30 seconds < block.timestamp, "Must wait 30 seconds before waving again.");
    totalWaves += 1;
    console.log("%s has waved!", msg.sender);

    waves.push(Wave(msg.sender, _message, block.timestamp));
    

    seed = (block.difficulty + block.timestamp + seed) % 100;

        console.log("Random # generated: %d", seed);

         if (seed < 50) {
            console.log("%s won!", msg.sender);
        }

    emit NewWave(msg.sender, block.timestamp, _message);

    uint256 prizeAmount = 0.0001 ether;
    require(
        prizeAmount <= address(this).balance,
        "Trying to withdraw more money than the contract has."
    );
    (bool success, ) = (msg.sender).call{value: prizeAmount}("");
    require(success, "Failed to withdraw money from contract.");
}

    /*
     * I added a function getAllWaves which will return the struct array, waves, to us.
     * This will make it easy to retrieve the waves from our website!
     */
    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        // Optional: Add this line if you want to see the contract print the value!
        // We'll also print it over in run.js as well.
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }
}