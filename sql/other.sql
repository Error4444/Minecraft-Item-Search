create table other
(
    numID        int          null,
    name         varchar(16)  null,
    textID       varchar(32)  null,
    stackSize    int          null,
    craftability tinyint(1)   null,
    description  varchar(128) null,
    rarity       varchar(2)   null,
    constraint other_ibfk_1
        foreign key (rarity) references rarity (rarityID)
);

create index rarity
    on other (rarity);

INSERT INTO minecraftalpha.other (numID, name, textID, stackSize, craftability, description, rarity) VALUES (361, 'Pumpkin Seeds', 'minecraft:pumpkin_seeds', 64, 1, 'Obtained by breaking a pumpkin. Used for planting and growing pumpkins.', null);
INSERT INTO minecraftalpha.other (numID, name, textID, stackSize, craftability, description, rarity) VALUES (362, 'Melon Seeds', 'minecraft:melon_seeds', 64, 1, 'Obtained by breaking a melon. Used for planting and growing melons.', null);
INSERT INTO minecraftalpha.other (numID, name, textID, stackSize, craftability, description, rarity) VALUES (295, 'Wheat Seeds', 'minecraft:wheat_seeds', 64, 1, 'Obtained by breaking grass or harvesting wheat. Used for crafting bread.', null);
INSERT INTO minecraftalpha.other (numID, name, textID, stackSize, craftability, description, rarity) VALUES (331, 'Redstone Dust', 'minecraft:redstone', 64, 1, 'Obtained by mining redstone ore. Used for crafting redstone devices.', null);
INSERT INTO minecraftalpha.other (numID, name, textID, stackSize, craftability, description, rarity) VALUES (328, 'Minecart', 'minecraft:minecart', 1, 1, 'Crafted with 5 iron ingots. Used for transporting items or players on rails.', null);
INSERT INTO minecraftalpha.other (numID, name, textID, stackSize, craftability, description, rarity) VALUES (333, 'Boat', 'minecraft:boat', 1, 1, 'Crafted with 5 wooden planks. Used for transporting players on water.', null);
INSERT INTO minecraftalpha.other (numID, name, textID, stackSize, craftability, description, rarity) VALUES (342, 'Storage Minecart', 'minecraft:chest_minecart', 1, 1, 'Crafted with a minecart and chest. Used for transporting items on rails.', null);
INSERT INTO minecraftalpha.other (numID, name, textID, stackSize, craftability, description, rarity) VALUES (343, 'Powered Minecart', 'minecraft:furnace_minecart', 1, 1, 'Crafted with a minecart and furnace. Moves on rails when powered by fuel.', null);
