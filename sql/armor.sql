create table armor
(
    numID          int          null,
    name           varchar(20)  null,
    textID         varchar(32)  null,
    stackSize      int          null,
    craftability   tinyint(1)   null,
    armorPoints    float        null,
    durability     float        null,
    enchantability tinyint(1)   null,
    description    varchar(128) null,
    rarity         varchar(2)   null,
    constraint armor_ibfk_1
        foreign key (rarity) references rarity (rarityID)
);

create index rarity
    on armor (rarity);

INSERT INTO minecraftalpha.armor (numID, name, textID, stackSize, craftability, armorPoints, durability, enchantability, description, rarity) VALUES (298, 'Leather Helmet', 'minecraft:leather_helmet', 1, 1, 0.5, 55, 1, 'Basic leather helmet. Low durability, easy to craft, offers minimal protection.', null);
INSERT INTO minecraftalpha.armor (numID, name, textID, stackSize, craftability, armorPoints, durability, enchantability, description, rarity) VALUES (299, 'Leather Chestplate', 'minecraft:leather_chestplate', 1, 1, 1.5, 80, 1, 'Simple chest armor made of leather. Light, early-game defense.', null);
INSERT INTO minecraftalpha.armor (numID, name, textID, stackSize, craftability, armorPoints, durability, enchantability, description, rarity) VALUES (300, 'Leather Leggings', 'minecraft:leather_leggings', 1, 1, 1, 75, 1, 'Basic leather leggings. Lightweight with minimal protection.', null);
INSERT INTO minecraftalpha.armor (numID, name, textID, stackSize, craftability, armorPoints, durability, enchantability, description, rarity) VALUES (301, 'Leather Boots', 'minecraft:leather_boots', 1, 1, 0.5, 65, 1, 'Entry-level boots offering low protection, good for early survival.', null);
INSERT INTO minecraftalpha.armor (numID, name, textID, stackSize, craftability, armorPoints, durability, enchantability, description, rarity) VALUES (302, 'Chainmail Helmet', 'minecraft:chainmail_helmet', 1, 0, 1, 165, 1, 'Rare helmet made of chains. Mid-tier defense, not craftable.', null);
INSERT INTO minecraftalpha.armor (numID, name, textID, stackSize, craftability, armorPoints, durability, enchantability, description, rarity) VALUES (303, 'Chainmail Chestplate', 'minecraft:chainmail_chestplate', 1, 0, 2.5, 240, 1, 'Solid chestplate with decent durability. Cannot be crafted.', null);
INSERT INTO minecraftalpha.armor (numID, name, textID, stackSize, craftability, armorPoints, durability, enchantability, description, rarity) VALUES (304, 'Chainmail Leggings', 'minecraft:chainmail_leggings', 1, 0, 2, 225, 1, 'Interlocked chain leggings. Medium protection, rare gear.', null);
INSERT INTO minecraftalpha.armor (numID, name, textID, stackSize, craftability, armorPoints, durability, enchantability, description, rarity) VALUES (305, 'Chainmail Boots', 'minecraft:chainmail_boots', 1, 0, 0.5, 195, 1, 'Durable boots made of chain links. Better than gold or leather.', null);
INSERT INTO minecraftalpha.armor (numID, name, textID, stackSize, craftability, armorPoints, durability, enchantability, description, rarity) VALUES (306, 'Iron Helmet', 'minecraft:iron_helmet', 1, 1, 1, 165, 1, 'Strong metal helmet offering solid protection for early combat.', null);
INSERT INTO minecraftalpha.armor (numID, name, textID, stackSize, craftability, armorPoints, durability, enchantability, description, rarity) VALUES (307, 'Iron Chestplate', 'minecraft:iron_chestplate', 1, 1, 3, 240, 1, 'Durable iron chestplate. Balanced defense and durability.', null);
INSERT INTO minecraftalpha.armor (numID, name, textID, stackSize, craftability, armorPoints, durability, enchantability, description, rarity) VALUES (308, 'Iron Leggings', 'minecraft:iron_leggings', 1, 1, 2.5, 225, 1, 'Heavy iron leggings. Reliable for surviving tougher fights.', null);
INSERT INTO minecraftalpha.armor (numID, name, textID, stackSize, craftability, armorPoints, durability, enchantability, description, rarity) VALUES (309, 'Iron Boots', 'minecraft:iron_boots', 1, 1, 1, 195, 1, 'Iron boots built for adventuring. Sturdy and protective.', null);
INSERT INTO minecraftalpha.armor (numID, name, textID, stackSize, craftability, armorPoints, durability, enchantability, description, rarity) VALUES (310, 'Diamond Helmet', 'minecraft:diamond_helmet', 1, 1, 1.5, 363, 1, 'High-tier helmet with great durability and strong defense.', null);
INSERT INTO minecraftalpha.armor (numID, name, textID, stackSize, craftability, armorPoints, durability, enchantability, description, rarity) VALUES (311, 'Diamond Chestplate', 'minecraft:diamond_chestplate', 1, 1, 4, 528, 1, 'The best chestplate. Extremely durable, top defense.', null);
INSERT INTO minecraftalpha.armor (numID, name, textID, stackSize, craftability, armorPoints, durability, enchantability, description, rarity) VALUES (312, 'Diamond Leggings', 'minecraft:diamond_leggings', 1, 1, 3, 495, 1, 'Premium leggings made of diamond. Very long-lasting.', null);
INSERT INTO minecraftalpha.armor (numID, name, textID, stackSize, craftability, armorPoints, durability, enchantability, description, rarity) VALUES (313, 'Diamond Boots', 'minecraft:diamond_boots', 1, 1, 1.5, 429, 1, 'Tough and durable boots. Excellent protection for any biome.', null);
INSERT INTO minecraftalpha.armor (numID, name, textID, stackSize, craftability, armorPoints, durability, enchantability, description, rarity) VALUES (314, 'Gold Helmet', 'minecraft:gold_helmet', 1, 1, 1, 77, 1, 'Shiny gold helmet. Low durability but enchantable and stylish.', null);
INSERT INTO minecraftalpha.armor (numID, name, textID, stackSize, craftability, armorPoints, durability, enchantability, description, rarity) VALUES (315, 'Gold Chestplate', 'minecraft:gold_chestplate', 1, 1, 2.5, 112, 1, 'Decorative gold chestplate. Looks great, breaks quickly.', null);
INSERT INTO minecraftalpha.armor (numID, name, textID, stackSize, craftability, armorPoints, durability, enchantability, description, rarity) VALUES (316, 'Gold Leggings', 'minecraft:gold_leggings', 1, 1, 1.5, 105, 1, 'Flashy gold leggings with low durability, good for enchantments.', null);
INSERT INTO minecraftalpha.armor (numID, name, textID, stackSize, craftability, armorPoints, durability, enchantability, description, rarity) VALUES (317, 'Gold Boots', 'minecraft:gold_boots', 1, 1, 0.5, 91, 1, 'Gold boots with high enchantability but weak durability.', null);
