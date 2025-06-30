create table tools
(
    numID          varchar(3)   not null
        primary key,
    name           varchar(15)  null,
    textID         varchar(32)  null,
    stackSize      int          null,
    craftability   tinyint(1)   null,
    damage         float        null,
    durability     float        null,
    enchantability tinyint(1)   null,
    fuel           tinyint(1)   null,
    description    varchar(128) null,
    rarityID       varchar(2)   null,
    constraint tools_ibfk_1
        foreign key (rarityID) references rarity (rarityID)
);

create index rarity
    on tools (rarityID);

INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarityID) VALUES ('256', 'Iron Shovel', 'minecraft:iron_shovel', 1, 1, 4.5, 250, 1, 0, 'Sturdy iron shovel for fast digging and good durability.', '1');
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarityID) VALUES ('257', 'Iron Pickaxe', 'minecraft:iron_pickaxe', 1, 1, 4, 250, 1, 0, 'Reliable iron pickaxe for mining most ores.', '1');
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarityID) VALUES ('258', 'Iron Axe', 'minecraft:iron_axe', 1, 1, 9, 250, 1, 0, 'Iron axe. Strong attack power and effective chopping.', '1');
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarityID) VALUES ('261', 'Bow', 'minecraft:bow', 1, 1, 11, 384, 1, 0, 'Basic ranged weapon. Requires arrows, good for long-distance attacks.', '1');
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarityID) VALUES ('267', 'Iron Sword', 'minecraft:iron_sword', 1, 1, 6, 250, 1, 0, 'Iron sword offers good durability and strong combat damage.', '1');
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarityID) VALUES ('268', 'Wooden Sword', 'minecraft:wooden_sword', 1, 1, 4, 59, 1, 1, 'Basic wooden sword. Weak but easy to craft for early defense.', '1');
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarityID) VALUES ('269', 'Wooden Shovel', 'minecraft:wooden_shovel', 1, 1, 2.5, 59, 1, 1, 'Basic wooden shovel. Useful for digging dirt and sand quickly.', '1');
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarityID) VALUES ('270', 'Wooden Pickaxe', 'minecraft:wooden_pickaxe', 1, 1, 2, 59, 1, 1, 'Entry-level wooden pickaxe. Needed for mining stone.', '1');
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarityID) VALUES ('271', 'Wooden Axe', 'minecraft:wooden_axe', 1, 1, 7, 59, 1, 1, 'Simple wooden axe. Low durability, good for chopping early wood.', '1');
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarityID) VALUES ('272', 'Stone Sword', 'minecraft:stone_sword', 1, 1, 5, 131, 1, 0, 'Stone sword with better strength than wood. Great early option.', '1');
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarityID) VALUES ('273', 'Stone Shovel', 'minecraft:stone_shovel', 1, 1, 3.5, 131, 1, 0, 'Stone shovel. Digging dirt is easier with this tool.', '1');
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarityID) VALUES ('274', 'Stone Pickaxe', 'minecraft:stone_pickaxe', 1, 1, 3, 131, 1, 0, 'Stone pickaxe. Needed for mining iron ore and better.', '1');
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarityID) VALUES ('275', 'Stone Axe', 'minecraft:stone_axe', 1, 1, 9, 131, 1, 0, 'Stone axe. Stronger than wood, useful in early survival.', '1');
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarityID) VALUES ('276', 'Diamond Sword', 'minecraft:diamond_sword', 1, 1, 7, 1561, 1, 0, 'Diamond sword. Powerful and durable for late-game combat.', '1');
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarityID) VALUES ('277', 'Diamond Shovel', 'minecraft:diamond_shovel', 1, 1, 5.5, 1561, 1, 0, 'Durable diamond shovel for fast and long-lasting digging.', '1');
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarityID) VALUES ('278', 'Diamond Pickaxe', 'minecraft:diamond_pickaxe', 1, 1, 5, 1561, 1, 0, 'Diamond pickaxe. Essential for mining obsidian and rare ores.', '1');
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarityID) VALUES ('279', 'Diamond Axe', 'minecraft:diamond_axe', 1, 1, 9, 1561, 1, 0, 'Diamond axe. High damage and very durable.', '1');
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarityID) VALUES ('283', 'Gold Sword', 'minecraft:golden_sword', 1, 1, 4, 32, 1, 0, 'Gold sword with high enchantability, but breaks very fast.', '1');
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarityID) VALUES ('284', 'Gold Shovel', 'minecraft:golden_shovel', 1, 1, 2.5, 32, 1, 0, 'Shovel made of gold. Very quick but wears out fast.', '1');
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarityID) VALUES ('285', 'Gold Pickaxe', 'minecraft:golden_pickaxe', 1, 1, 2, 32, 1, 0, 'Gold pickaxe. Extremely fast but breaks quickly.', '1');
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarityID) VALUES ('286', 'Gold Axe', 'minecraft:golden_axe', 1, 1, 7, 32, 1, 0, 'Golden axe. Fast mining but poor durability.', '1');
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarityID) VALUES ('290', 'Wooden Hoe', 'minecraft:wooden_hoe', 1, 1, 1, 59, 1, 1, 'Starter wooden hoe. Used to till soil for early farming.', '1');
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarityID) VALUES ('291', 'Stone Hoe', 'minecraft:stone_hoe', 1, 1, 1, 131, 1, 0, 'Stone hoe. Basic farming tool for early crops.', '1');
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarityID) VALUES ('292', 'Iron Hoe', 'minecraft:iron_hoe', 1, 1, 1, 250, 1, 0, 'Iron hoe. Useful for farming with lasting durability.', '1');
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarityID) VALUES ('293', 'Diamond Hoe', 'minecraft:diamond_hoe', 1, 1, 1, 1561, 1, 0, 'Diamond hoe. Used for farming, extremely durable.', '1');
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarityID) VALUES ('294', 'Gold Hoe', 'minecraft:golden_hoe', 1, 1, 1, 32, 1, 0, 'Gold hoe. Weak tool but enchants easily.', '1');
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarityID) VALUES ('359', 'Shears', 'minecraft:shears', 1, 1, null, null, null, null, null, '1');
