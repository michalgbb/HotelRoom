// SPDX-License-Identifier: Unlicense
pragma solidity >=0.7.0 <0.9.0;

contract HotelRoom {

    address payable public owner;

    event Occupy(address _occupant, uint _value);

    enum Statuses {Vacant, Occupied}
    Statuses public currentStatus; 

    constructor() {
        owner = payable(msg.sender); // dodane payable inaczej bład
        currentStatus = Statuses.Vacant;
    }

    modifier onlyWhileVacant {
        require(currentStatus == Statuses.Vacant, "Currently occupied.");
        _;
    }

    modifier valueCost(uint _amount) {
        require(msg.value >= _amount, "not enough ether provided");
        _;
    }

    function book() payable public onlyWhileVacant valueCost(2 ether) {
        currentStatus = Statuses.Occupied;
        // owner.transfer(msg.value); <--  zastepujemy linia ponizej
        (bool sent, bytes memory data) = owner.call{value: msg.value}("");
        require(true);
        emit Occupy(msg.sender, msg.value);
    }


}