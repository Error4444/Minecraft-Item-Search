create table blocktools
(
    toolID  varchar(3) null,
    blockID varchar(5) null,
    constraint blocktools_ibfk_1
        foreign key (toolID) references tools (numID),
    constraint blocktools_ibfk_2
        foreign key (blockID) references blocks (numID)
);

create index blockID
    on blocktools (blockID);

create index toolID
    on blocktools (toolID);

