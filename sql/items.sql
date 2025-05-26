create table items
(
    numID        varchar(6)   null,
    name         varchar(20)  null,
    textID       varchar(50)  null,
    stackSize    int          null,
    craftability tinyint(1)   null,
    renewability tinyint(1)   null,
    description  varchar(128) null,
    rarity       varchar(2)   null,
    constraint items_ibfk_1
        foreign key (rarity) references rarity (rarityID)
);

create index rarity
    on items (rarity);

INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('344', 'Egg', 'minecraft:egg', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('345', 'Compass', 'minecraft:compass', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('346', 'Fishing Rod', 'minecraft:fishing_rod', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('347', 'Watch', 'minecraft:clock', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('348', 'Glowstone Dust', 'minecraft:glowstone_dust', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('349', 'Raw Fish', 'minecraft:fish', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('350', 'Cooked Fish', 'minecraft:cooked_fish', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('351', 'Ink Sack', 'minecraft:dye', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('351:1', 'Rose Red Dye', 'minecraft:dye', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('351:2', 'Cactus Green Dye', 'minecraft:dye', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('351:3', 'Coca Bean', 'minecraft:dye', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('351:4', 'Lapis Lazuli', 'minecraft:lapis_lazuli', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('351:5', 'Purple Dye', 'minecraft:dye', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('351:6', 'Cyan Dye', 'minecraft:dye', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('351:7', 'Light Gray Dye', 'minecraft:dye', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('351:8', 'Gray Dye', 'minecraft:dye', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('351:9', 'Pink Dye', 'minecraft:dye', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('351:10', 'Lime Dye', 'minecraft:dye', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('351:11', 'Dandelion Yellow Dye', 'minecraft:dye', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('351:12', 'Light Blue Dye', 'minecraft:dye', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('351:13', 'Magenta Dye', 'minecraft:dye', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('351:14', 'Orange Dye', 'minecraft:dye', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('351:15', 'Bone Meal', 'minecraft:bone_meal', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('352', 'Bone', 'minecraft:bone', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('353', 'Sugar', 'minecraft:sugar', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('339', 'Paper', 'minecraft:paper', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('340', 'Book', 'minecraft:book', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('341', 'Slime Ball', 'minecraft:slime_ball', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('337', 'Clay', 'minecraft:clay', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('334', 'Leather', 'minecraft:leather', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('332', 'Snowball', 'minecraft:snowball', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('329', 'Saddle', 'minecraft:saddle', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('325', 'Bucket', null, null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('326', 'Bucket', null, null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('327', 'Bucket', null, null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('318', 'Flint', 'minecraft:flint', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('296', 'Wheat', 'minecraft:wheat', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('287', 'String', 'minecraft:string', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('288', 'Feather', 'minecraft:feather', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('289', 'Gunpowder', 'minecraft:gunpowder', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('280', 'Stick', 'minecraft:stick', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('281', 'Bowl', 'minecraft:bowl', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('259', 'Flint and Steel', 'minecraft:flint_and_steel', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('262', 'Arrow', 'minecraft:arrow', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('263', 'Coal', 'minecraft:coal', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('263:1', 'Charcoal', 'minecraft:coal', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('264', 'Diamond', 'minecraft:diamond', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('265', 'Iron Ingot', 'minecraft:iron_ingot', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('266', 'Gold Ingot', 'minecraft:gold_ingot', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('358', 'Map', 'minecraft:map', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('359', 'Shears', 'minecraft:shears', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('368', 'Ender Pearl', 'minecraft:ender_pearl', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('369', 'Blaze Rod', 'minecraft:blaze_rod', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('370', 'Ghast Tear', 'minecraft:ghast_tear', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('371', 'Gold Nugget', 'minecraft:gold_nugget', null, null, null, null, null);
INSERT INTO minecraftalpha.items (numID, name, textID, stackSize, craftability, renewability, description, rarity) VALUES ('372', 'Nether Wart Seeds', 'minecraft:nether_wart_seeds', null, null, null, null, null);
