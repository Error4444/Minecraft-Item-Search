create table consumables
(
    numID        int          null,
    name         varchar(15)  null,
    textID       varchar(32)  null,
    stackSize    int          null,
    craftability tinyint(1)   null,
    animalFodder tinyint(1)   null,
    description  varchar(128) null,
    rarityID     varchar(2)   null,
    constraint consumables_ibfk_1
        foreign key (rarityID) references rarity (rarityID)
);

create index rarity
    on consumables (rarityID);

INSERT INTO minecraftalpha.consumables (numID, name, textID, stackSize, craftability, animalFodder, description, rarityID) VALUES (363, 'Raw Beef', 'minecraft:beef', 64, 0, 0, 'Uncooked beef, can be eaten or cooked into steak for better hunger restoration.', '1');
INSERT INTO minecraftalpha.consumables (numID, name, textID, stackSize, craftability, animalFodder, description, rarityID) VALUES (364, 'Steak', 'minecraft:cooked_beef', 64, 0, 1, 'Cooked beef, restores a lot of hunger and saturation. Great for adventuring.', '1');
INSERT INTO minecraftalpha.consumables (numID, name, textID, stackSize, craftability, animalFodder, description, rarityID) VALUES (365, 'Raw Chicken', 'minecraft:chicken', 64, 0, 0, 'Uncooked chicken, may cause hunger. Best cooked before eating.', '1');
INSERT INTO minecraftalpha.consumables (numID, name, textID, stackSize, craftability, animalFodder, description, rarityID) VALUES (366, 'Cooked Chicken', 'minecraft:cooked_chicken', 64, 0, 0, 'Safe and nutritious, restores moderate hunger and saturation.', '1');
INSERT INTO minecraftalpha.consumables (numID, name, textID, stackSize, craftability, animalFodder, description, rarityID) VALUES (367, 'Rotten Flesh', 'minecraft:rotten_flesh', 64, 0, 0, 'Dropped by zombies. Can be eaten but may cause hunger.', '1');
INSERT INTO minecraftalpha.consumables (numID, name, textID, stackSize, craftability, animalFodder, description, rarityID) VALUES (360, 'Melon', 'minecraft:melon', 64, 0, 0, 'Restores little hunger. Easily farmable and stackable.', '1');
INSERT INTO minecraftalpha.consumables (numID, name, textID, stackSize, craftability, animalFodder, description, rarityID) VALUES (357, 'Cookie', 'minecraft:cookie', 64, 1, 0, 'A small snack, restores little hunger. Made from wheat and cocoa.', '1');
INSERT INTO minecraftalpha.consumables (numID, name, textID, stackSize, craftability, animalFodder, description, rarityID) VALUES (354, 'Cake', 'minecraft:cake', 1, 1, 0, 'A placeable dessert with multiple slices. Restores hunger gradually.', '1');
INSERT INTO minecraftalpha.consumables (numID, name, textID, stackSize, craftability, animalFodder, description, rarityID) VALUES (322, 'Gold Apple', 'minecraft:golden_apple', 64, 1, 0, 'Heals and gives effects. Great in combat or emergencies.', '1');
INSERT INTO minecraftalpha.consumables (numID, name, textID, stackSize, craftability, animalFodder, description, rarityID) VALUES (319, 'Raw Porkchop', 'minecraft:porkchop', 64, 0, 0, 'Uncooked pork, can be eaten or cooked for better effect.', '1');
INSERT INTO minecraftalpha.consumables (numID, name, textID, stackSize, craftability, animalFodder, description, rarityID) VALUES (320, 'Cooked Porkchop', 'minecraft:cooked_porkchop', 64, 0, 0, 'Restores a lot of hunger. One of the best meats.', '1');
INSERT INTO minecraftalpha.consumables (numID, name, textID, stackSize, craftability, animalFodder, description, rarityID) VALUES (297, 'Bread', 'minecraft:bread', 64, 1, 0, 'Simple food made from wheat. Restores decent hunger.', '1');
INSERT INTO minecraftalpha.consumables (numID, name, textID, stackSize, craftability, animalFodder, description, rarityID) VALUES (260, 'Apple', 'minecraft:apple', 64, 0, 0, 'Common fruit. Eaten raw or crafted into golden apples.', '1');
INSERT INTO minecraftalpha.consumables (numID, name, textID, stackSize, craftability, animalFodder, description, rarityID) VALUES (349, 'Raw Cod', 'minecraft:cod', 64, 0, 1, 'Raw Fish : a useful item in Minecraft with various applications.', '1');
INSERT INTO minecraftalpha.consumables (numID, name, textID, stackSize, craftability, animalFodder, description, rarityID) VALUES (350, 'Cooked Cod', 'minecraft:cooked_cod', 64, 0, 1, 'Cooked Fish : a useful item in Minecraft with various applications.', '1');
INSERT INTO minecraftalpha.consumables (numID, name, textID, stackSize, craftability, animalFodder, description, rarityID) VALUES (0, 'Cookie', 'minecraft:mob_ocelot_face', 1, 0, 0, 'Easter Egg: Daniel\'s Kater', '4');
