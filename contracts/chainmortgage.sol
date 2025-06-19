// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ChainMortgage {
    address public owner;

    struct Mortgage {
        uint256 id;
        address borrower;
        uint256 amount;
        bool isApproved;
    }

    uint256 public mortgageCount;
    mapping(uint256 => Mortgage) public mortgages;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function applyForMortgage(uint256 _amount) external {
        mortgageCount++;
        mortgages[mortgageCount] = Mortgage(mortgageCount, msg.sender, _amount, false);
    }

    function approveMortgage(uint256 _id) external onlyOwner {
        Mortgage storage m = mortgages[_id];
        require(!m.isApproved, "Already approved");
        m.isApproved = true;
    }

    function getMortgage(uint256 _id) external view returns (Mortgage memory) {
        return mortgages[_id];
    }

    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "Invalid address");
        owner = newOwner;
    }
}

