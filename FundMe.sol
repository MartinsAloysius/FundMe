//Get funds from users
//Withdraw funds
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter{
    function getPrice() internal  view returns (uint256) {
     //Address 0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF
     // ABI
     AggregatorV3Interface priceFeed = AggregatorV3Interface(0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF);
     (,int256 price,,,) = priceFeed.latestRoundData();
     return uint256 (price*1e10);
   }
        
    

    function getConversionRate(uint256 ethAmount) internal  view returns (uint256){
     uint256 ethPrice = getPrice();
     uint256 ethAmountInUsd = (ethPrice* ethAmount) / 1e18;
     return ethAmountInUsd;
    }

     function getVersion() internal  view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF);
        return priceFeed.version();
    }

}



contract FundMe {
      using PriceConverter for uint256;
      uint256 public minimumUsd = 5 * 1e18;

      address[] public funders; 
      mapping(address funder => uint256 addressFunded) public addressToAmountFunded;

      address public owner;

      constructor() {
        owner = msg.sender;
      }

    function Fund() public payable  {
         
      require (msg.value.getConversionRate() >= minimumUsd, "didn't send enough ETH");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }

    function Withraw() public onlyOwner {
       for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
    }
       funders = new address[](0);
       // //transfer
      // payable(msg.sender).transfer(address(this).balance);
      
      //send
    //  bool sendSuccess = payable(msg.sender).send(address(this).balance);
      //require(sendSuccess, "Send failed");

      //call
       (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");

    }

    modifier onlyOwner() {
      require(msg.sender == owner, "only owner can withdraw funds" );
      _;
    }

    receive() external payable{
      Fund();
    }

    fallback() external payable{
      Fund();
    }

}