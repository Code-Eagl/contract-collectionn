// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.4.22 <0.9.0;

 contract  eventcontract {
    struct Event{
        address organizer;
        string name;
        uint date;
        uint price;
        uint ticketcount;
        uint ticketRemain;
    }

    mapping (uint=> Event) public events;
    mapping(address=> mapping (uint=> uint))public tickets;
    uint public nextId;

    function createEvent(string memory name, uint date, uint price, uint ticketcount)external{
        require(date>block.timestamp, "You can organize event for future");
        require(ticketcount>0, "you can organixe event only if you create more then 1 ticket");
        events[nextId]= Event(msg.sender, name, date, price, ticketcount, ticketcount );
        nextId++;
    }
    function buyTicket(uint id, uint quantity)external  payable {
        require(events[id].date!=0, "This event does not exist");
        require(events[id].date>block.timestamp,"Evente is expired");
        Event storage _event = events[id];
        require(msg.value==(_event.price*quantity), "Ethers is not enough");
        require(_event.ticketRemain>=quantity, "Not enough ticket");
        _event.ticketRemain-=quantity;
        tickets[msg.sender][id]+=quantity;
    }
    function transforTicket(uint id, uint quintity, address to)external {
        require(events[id].date!=0, "Event does not exist");
        require(events[id].date>block.timestamp, "Event has already occured");
        require(tickets[msg.sender][id]>=quintity,"You do not have enough ticket");
        tickets[msg.sender][id]-=quintity;
        tickets[to][id]+=quintity;
    }
}
