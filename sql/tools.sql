create table tools
(
    numID          varchar(3)   null,
    name           varchar(15)  null,
    textID         varchar(32)  null,
    stackSize      int          null,
    craftability   tinyint(1)   null,
    damage         float        null,
    durability     float        null,
    enchantability tinyint(1)   null,
    fuel           tinyint(1)   null,
    description    varchar(128) null,
    rarity         varchar(2)   null,
    constraint tools_ibfk_1
        foreign key (rarity) references rarity (rarityID)
);

create index rarity
    on tools (rarity);

INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarity) VALUES ('256', 'Iron Shovel', 'minecraft:iron_shovel', 1, 1, 4.5, 250, 1, 0, 'Sturdy iron shovel for fast digging and good durability.', null);
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarity) VALUES ('257', 'Iron Pickaxe', 'minecraft:iron_pickaxe', 1, 1, 4, 250, 1, 0, 'Reliable iron pickaxe for mining most ores.', null);
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarity) VALUES ('258', 'Iron Axe', 'minecraft:iron_axe', 1, 1, 9, 250, 1, 0, 'Iron axe. Strong attack power and effective chopping.', null);
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarity) VALUES ('261', 'Bow', 'minecraft:bow', 1, 1, 11, 384, 1, 0, 'Basic ranged weapon. Requires arrows, good for long-distance attacks.', null);
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarity) VALUES ('267', 'Iron Sword', 'minecraft:iron_sword', 1, 1, 6, 250, 1, 0, 'Iron sword offers good durability and strong combat damage.', null);
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarity) VALUES ('268', 'Wooden Sword', 'minecraft:wooden_sword', 1, 1, 4, 59, 1, 1, 'Basic wooden sword. Weak but easy to craft for early defense.', null);
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarity) VALUES ('269', 'Wooden Shovel', 'minecraft:wooden_shovel', 1, 1, 2.5, 59, 1, 1, 'Basic wooden shovel. Useful for digging dirt and sand quickly.', null);
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarity) VALUES ('270', 'Wooden Pickaxe', 'minecraft:wooden_pickaxe', 1, 1, 2, 59, 1, 1, 'Entry-level wooden pickaxe. Needed for mining stone.', null);
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarity) VALUES ('271', 'Wooden Axe', 'minecraft:wooden_axe', 1, 1, 7, 59, 1, 1, 'Simple wooden axe. Low durability, good for chopping early wood.', null);
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarity) VALUES ('272', 'Stone Sword', 'minecraft:stone_sword', 1, 1, 5, 131, 1, 0, 'Stone sword with better strength than wood. Great early option.', null);
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarity) VALUES ('273', 'Stone Shovel', 'minecraft:stone_shovel', 1, 1, 3.5, 131, 1, 0, 'Stone shovel. Digging dirt is easier with this tool.', null);
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarity) VALUES ('274', 'Stone Pickaxe', 'minecraft:stone_pickaxe', 1, 1, 3, 131, 1, 0, 'Stone pickaxe. Needed for mining iron ore and better.', null);
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarity) VALUES ('275', 'Stone Axe', 'minecraft:stone_axe', 1, 1, 9, 131, 1, 0, 'Stone axe. Stronger than wood, useful in early survival.', null);
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarity) VALUES ('276', 'Diamond Sword', 'minecraft:diamond_sword', 1, 1, 7, 1561, 1, 0, 'Diamond sword. Powerful and durable for late-game combat.', null);
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarity) VALUES ('277', 'Diamond Shovel', 'minecraft:diamond_shovel', 1, 1, 5.5, 1561, 1, 0, 'Durable diamond shovel for fast and long-lasting digging.', null);
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarity) VALUES ('278', 'Diamond Pickaxe', 'minecraft:diamond_pickaxe', 1, 1, 5, 1561, 1, 0, 'Diamond pickaxe. Essential for mining obsidian and rare ores.', null);
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarity) VALUES ('279', 'Diamond Axe', 'minecraft:diamond_axe', 1, 1, 9, 1561, 1, 0, 'Diamond axe. High damage and very durable.', null);
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarity) VALUES ('283', 'Gold Sword', 'minecraft:golden_sword', 1, 1, 4, 32, 1, 0, 'Gold sword with high enchantability, but breaks very fast.', null);
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarity) VALUES ('284', 'Gold Shovel', 'minecraft:golden_shovel', 1, 1, 2.5, 32, 1, 0, 'Shovel made of gold. Very quick but wears out fast.', null);
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarity) VALUES ('285', 'Gold Pickaxe', 'minecraft:golden_pickaxe', 1, 1, 2, 32, 1, 0, 'Gold pickaxe. Extremely fast but breaks quickly.', null);
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarity) VALUES ('286', 'Gold Axe', 'minecraft:golden_axe', 1, 1, 7, 32, 1, 0, 'Golden axe. Fast mining but poor durability.', null);
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarity) VALUES ('290', 'Wooden Hoe', 'minecraft:wooden_hoe', 1, 1, 1, 59, 1, 1, 'Starter wooden hoe. Used to till soil for early farming.', null);
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarity) VALUES ('291', 'Stone Hoe', 'minecraft:stone_hoe', 1, 1, 1, 131, 1, 0, 'Stone hoe. Basic farming tool for early crops.', null);
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarity) VALUES ('292', 'Iron Hoe', 'minecraft:iron_hoe', 1, 1, 1, 250, 1, 0, 'Iron hoe. Useful for farming with lasting durability.', null);
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarity) VALUES ('293', 'Diamond Hoe', 'minecraft:diamond_hoe', 1, 1, 1, 1561, 1, 0, 'Diamond hoe. Used for farming, extremely durable.', null);
INSERT INTO minecraftalpha.tools (numID, name, textID, stackSize, craftability, damage, durability, enchantability, fuel, description, rarity) VALUES ('294', 'Gold Hoe', 'minecraft:golden_hoe', 1, 1, 1, 32, 1, 0, 'Gold hoe. Weak tool but enchants easily.', null);
