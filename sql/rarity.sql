create table rarity
(
    rarityID    varchar(2)  not null
        primary key,
    rarityName  varchar(16) null,
    description varchar(64) null
);

INSERT INTO minecraftalpha.rarity (rarityID, rarityName, description) VALUES (1, 'Common', ' Basic and easy to find, offering standard features.');
INSERT INTO minecraftalpha.rarity (rarityID, rarityName, description) VALUES (2, 'Uncommon', 'Slightly rarer with better stats or value.');
INSERT INTO minecraftalpha.rarity (rarityID, rarityName, description) VALUES (3, 'Rare', 'Harder to obtain and more powerful or unique.');
INSERT INTO minecraftalpha.rarity (rarityID, rarityName, description) VALUES (4, 'Epic', 'Very rare, exceptional, and highly desirable.');
