create table consumables
(
    numID        int          null,
    name         varchar(15)  null,
    textID       varchar(32)  null,
    stackSize    int          null,
    craftability tinyint(1)   null,
    animalFodder tinyint(1)   null,
    description  varchar(128) null,
    rarity       varchar(2)   null,
    constraint consumables_ibfk_1
        foreign key (rarity) references rarity (rarityID)
);

create index rarity
    on consumables (rarity);

INSERT INTO minecraftalpha.consumables (numID, name, textID, stackSize, craftability, animalFodder, description, rarity) VALUES (363, 'Raw Beef', null, null, null, null, null, null);
INSERT INTO minecraftalpha.consumables (numID, name, textID, stackSize, craftability, animalFodder, description, rarity) VALUES (364, 'Steak', null, null, null, null, null, null);
INSERT INTO minecraftalpha.consumables (numID, name, textID, stackSize, craftability, animalFodder, description, rarity) VALUES (365, 'Raw Chicken', null, null, null, null, null, null);
INSERT INTO minecraftalpha.consumables (numID, name, textID, stackSize, craftability, animalFodder, description, rarity) VALUES (366, 'Cooked Chicken', null, null, null, null, null, null);
INSERT INTO minecraftalpha.consumables (numID, name, textID, stackSize, craftability, animalFodder, description, rarity) VALUES (367, 'Rotten Flesh', null, null, null, null, null, null);
INSERT INTO minecraftalpha.consumables (numID, name, textID, stackSize, craftability, animalFodder, description, rarity) VALUES (360, 'Melon', null, null, null, null, null, null);
INSERT INTO minecraftalpha.consumables (numID, name, textID, stackSize, craftability, animalFodder, description, rarity) VALUES (357, 'Cookie', null, null, null, null, null, null);
INSERT INTO minecraftalpha.consumables (numID, name, textID, stackSize, craftability, animalFodder, description, rarity) VALUES (354, 'Cake', null, null, null, null, null, null);
INSERT INTO minecraftalpha.consumables (numID, name, textID, stackSize, craftability, animalFodder, description, rarity) VALUES (322, 'Gold Apple', null, null, null, null, null, null);
INSERT INTO minecraftalpha.consumables (numID, name, textID, stackSize, craftability, animalFodder, description, rarity) VALUES (319, 'Raw Porkchop', null, null, null, null, null, null);
INSERT INTO minecraftalpha.consumables (numID, name, textID, stackSize, craftability, animalFodder, description, rarity) VALUES (320, 'Cooked Porkchop', null, null, null, null, null, null);
INSERT INTO minecraftalpha.consumables (numID, name, textID, stackSize, craftability, animalFodder, description, rarity) VALUES (297, 'Bread', null, null, null, null, null, null);
INSERT INTO minecraftalpha.consumables (numID, name, textID, stackSize, craftability, animalFodder, description, rarity) VALUES (260, 'Apple', null, null, null, null, null, null);
INSERT INTO minecraftalpha.consumables (numID, name, textID, stackSize, craftability, animalFodder, description, rarity) VALUES (335, 'Bucket', null, null, null, null, null, null);
INSERT INTO minecraftalpha.consumables (numID, name, textID, stackSize, craftability, animalFodder, description, rarity) VALUES (282, 'Mushroom Stew', null, null, null, null, null, null);
