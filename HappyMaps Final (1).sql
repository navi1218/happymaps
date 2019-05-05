/* The purpose of our database is to maintain Happy Map’s data which is used to build an
alternative cartography of a city weighted by human emotions. */

CREATE DATABASE HappyMaps;
GO

USE HappyMaps;

CREATE MASTER KEY ENCRYPTION BY 
PASSWORD = 'T3stP@ssword'
GO

CREATE CERTIFICATE TestCert
	WITH SUBJECT = 'Blurb Encryption';
GO
 
CREATE SYMMETRIC KEY HappyKey
    WITH ALGORITHM = DES
    ENCRYPTION BY CERTIFICATE TestCert;
GO

OPEN SYMMETRIC KEY HappyKey
   DECRYPTION BY CERTIFICATE TestCert;

CREATE TABLE dbo.Roads
	(
	RoadID int IDENTITY NOT NULL PRIMARY KEY,
	RoadName varchar(30),
	RoadType varchar(50) NOT NULL,
	StartLat float NOT NULL,
	StartLong float NOT NULL,
	EndLat float NOT NULL,
	EndLong float NOT NULL,
	Distance float NOT NULL, /*ft*/
	Speed int,
	Sidewalk bit,
	Bikelane bit,
	HappyScore float,
	BeautyScore float,
	PeaceScore float
	);

CREATE TABLE dbo.Traffic
	(
	RoadID int NOT NULL PRIMARY KEY
		CONSTRAINT Traffic_RoadID FOREIGN KEY (RoadID) REFERENCES dbo.Roads(RoadID),
	AmountofTime int/*number of minutes delay*/
	);

CREATE TABLE dbo.Crime
	(
	RoadID int NOT NULL PRIMARY KEY
		CONSTRAINT Crime_RoadID FOREIGN KEY (RoadID) REFERENCES dbo.Roads(RoadID),
	CrimeScore int NOT NULL
	);

CREATE TABLE dbo.Accessibility
	(
	RoadID int NOT NULL PRIMARY KEY
		CONSTRAINT AcessRoadID FOREIGN KEY (RoadID) REFERENCES dbo.Roads(RoadID),
	Elevation int,
	AccessScore float NOT NULL,
	WalkScore float NOT NULL,
	BikeScore float NOT NULL
	);

CREATE TABLE dbo.HashtagReactions
	(
	RoadID int NOT NULL PRIMARY KEY
		CONSTRAINT Hashtag_RoadID FOREIGN KEY (RoadID) REFERENCES dbo.Roads(RoadID),
	HappyPoints float NOT NULL,
	BeautyPoints float NOT NULL,
	PeacePoints float NOT NULL,
	HashtagScore float NOT NULL
	);

CREATE TABLE dbo.Intersections
	(
	IntersectionID int IDENTITY NOT NULL PRIMARY KEY,
	Lat float NOT NULL,
	Long float NOT NULL
	)

CREATE TABLE dbo.RoadsIntersection
	(
	RoadID int NOT NULL
		CONSTRAINT RoadID FOREIGN KEY (RoadID) REFERENCES dbo.Roads(RoadID),
	IntersectionID int NOT NULL
		CONSTRAINT IntersectionID FOREIGN KEY (IntersectionID) REFERENCES dbo.Intersections(IntersectionID)
	);

INSERT dbo.Roads (RoadName, RoadType, StartLat, StartLong, EndLat, EndLong, Distance, Speed, Sidewalk, Bikelane, HappyScore, BeautyScore, PeaceScore) VALUES
	('Rosy Avenue', 'Primary', 43.781386, -99.180080, 43.780422, -99.180085, 348, 25, 1, 1, 0, 0, 0),
	('Rosy Avenue', 'Primary', 43.780422, -99.180085, 43.779419, -99.180035, 371, 25, 1, 1, 0, 0, 0),
	('Sunny Street', 'Secondary', 43.779419, -99.180035, 43.779397, -99.180816, 203, 10, 1, 1, 0, 0, 0),
	('Sunny Street', 'Secondary', 43.779397, -99.180816, 43.779397, -99.182185, 358, 10, 1, 1, 0, 0, 0),
	('Sunny Street', 'Secondary', 43.779397, -99.182185, 43.779403, -99.183168, 259, 10, 1, 1, 0, 0, 0),
	('Pleasant Lane', 'Primary', 43.779403, -99.183168, 43.780414, -99.183189, 364, 25, 1, 1, 0, 0, 0),
	('Pleasant Lane', 'Primary', 43.780414, -99.183189, 43.781410, -99.183208, 367, 25, 1, 1, 0, 0, 0),
	('Honeybunch Road', 'Tertiary', 43.781410, -99.183208, 43.781419, -99.182204, 266, 10, 1, 1, 0, 0, 0),
	('Honeybunch Road', 'Tertiary', 43.781419, -99.182204, 43.781423, -99.180816, 367, 10, 1, 1, 0, 0, 0),
	('Honeybunch Road', 'Tertiary', 43.781423, -99.180816, 43.781386, -99.180080, 203, 10, 1, 1, 0, 0, 0),
	('Harmony Court', 'Primary', 43.781423, -99.180816, 43.780428, -99.180832, 364, 25, 1, 1, 0, 0, 0),
	('Harmony Court', 'Primary', 43.780428, -99.180832, 43.779405, -99.180816, 377, 25, 1, 1, 0, 0, 0),
	('Chirpy Street', 'Secondary', 43.780432, -99.180065, 43.780436, -99.180821, 194, 10, 1, 1, 0, 0, 0),
	('Chirpy Street', 'Secondary', 43.780418, -99.180818, 43.780422, -99.182197, 358, 10, 1, 1, 0, 0, 0),
	('Chirpy Street', 'Secondary', 43.780422, -99.182197, 43.780409, -99.183199, 266, 10, 1, 1, 0, 0, 0), 
	('Bright Boulevard', 'Primary', 43.781434, -99.182203, 43.780400, -99.182187, 371, 25, 1, 1, 0, 0, 0),
	('Bright Boulevard', 'Primary', 43.780400, -99.182187, 43.779410, -99.182183, 371, 25, 1, 1, 0, 0, 0);

INSERT dbo.Crime (RoadID, CrimeScore) VALUES
	(1, 2),
	(2, 1),
	(3, 3),
	(4, 4),
	(5, 2),
	(6, 1), 
	(7, 1),
	(8, 2),
	(9, 1),
	(10, 1),
	(11, 1),
	(12, 1), 
	(13, 2),
	(14, 2),
	(15, 2),
	(16, 2),
	(17, 1);

INSERT dbo.Traffic (RoadID, AmountofTime) VALUES
	(1, 4),
	(2, 2),
	(3, 0),
	(4, 1),
	(5, 0),
	(6, 10), 
	(7, 8),
	(8, 2),
	(9, 1),
	(10, 0),
	(11, 5),
	(12, 6), 
	(13, 0),
	(14, 2),
	(15, 1),
	(16, 3),
	(17, 3);

INSERT dbo.Accessibility (RoadID, Elevation, AccessScore, WalkScore, BikeScore) VALUES
	(1, 7, 4, 7, 8),
	(2, 8, 4, 7, 8),
	(3,-2,6,8,9),
	(4,-4,6,8,9),
	(5,5,6,8,10),
	(6,6,8,9,9), 
	(7,2,7,9,10),
	(8,1,10,10,10),
	(9,0,10,10,10),
	(10,-3,7,9,10),
	(11,-2,8,9,10),
	(12,0,9,10,10), 
	(13,1,8,10,10),
	(14,3,8,10,10),
	(15,2,9,10,10),
	(16,1,9,10,10),
	(17,0,10,10,10);

INSERT dbo.HashtagReactions(RoadID, HappyPoints, BeautyPoints, PeacePoints, HashtagScore) VALUES
	(1,7,9,6,6),
	(2,6,10,6,7),
	(3,9,6,5,8),
	(4,10,7,7,3),
	(5,10,5,4,8),
	(6,6,4,9,1),
	(7,7,6,9,4),
	(8,9,7,4,5),
	(9,8,6,6,10),
	(10,9,5,4,9),
	(11,7,4,7,4),
	(12,8,3,8,9),
	(13,9,7,2,8),
	(14,10,7,1,7),
	(15,9,8,3,6),
	(16,10,8,4,3),
	(17,10,9,6,4);

INSERT dbo.Intersections(Lat, Long) VALUES
	(43.781405, -99.180099),
	(43.780429, -99.180094),
	(43.779422, -99.180056),
	(43.779422, -99.180056),
	(43.779393, -99.182182),
	(43.779412, -99.183158),
	(43.780415, -99.183201),
	(43.781416, -99.183211),
	(43.781420, -99.182189),
	(43.781420, -99.180810),
	(43.780428, -99.180821),
	(43.780413, -99.182184);

INSERT dbo.RoadsIntersection(RoadID, IntersectionID) VALUES
	(1, 1),
	(1, 2),
	(2, 2),
	(2, 3),
	(3, 3),
	(3, 4),
	(4, 4),
	(4, 5),
	(5, 5),
	(5, 6),
	(6, 6),
	(6, 7),
	(7, 7),
	(7, 8),
	(8, 8),
	(8, 9),
	(9, 9),
	(9, 10),
	(10, 10),
	(10, 1),
	(11, 10),
	(11, 11),
	(12, 11),
	(12, 4),
	(13, 2),
	(13, 11),
	(14, 11),
	(14, 12),
	(15, 7),
	(15, 12),
	(16, 9),
	(16, 12),
	(17, 12),
	(17, 5);

/* Parent table for multiple entities */
CREATE TABLE dbo.MapEntity
	(
	SiteID int NOT NULL,
	RoadID int
		REFERENCES Roads(RoadID),
	EntityName varchar(60),
	Lat float,
	Long float,
	SiteType varchar(30),
	HappyPoints int,
	BeautyPoints int,
	PeacePoints int,
	Blurb varchar(120),
	EncryptedBlurb varchar(200),
	);

/* Pieces of art that add an element of playfulness and wonder */
CREATE TABLE dbo.PublicArt
	(
	SiteID int NOT NULL,
	ArtType varchar(30),
	Artist varchar(60)
	);

/* Fountains, beaches, pools, splash fountains, streams and waterfalls all contribute to a more alluring urban route */
CREATE TABLE dbo.WaterFeatures
	(
	SiteID int NOT NULL,
	WaterFeatureType varchar(30)
	);

/*Beautiful view */
CREATE TABLE dbo.ScenicSite
(
SiteID int NOT NULL,
WaterView bit,
CityView bit,
Mountainview bit,
SunriseSunset bit,
);

/* Includes oddities that may adds an element of quirkiness and surprise to one’s route */
CREATE TABLE dbo.Miscellaneous
(
SiteID int NOT NULL,
Commercial varchar(30)
);

/* Passing by historical landmarks, sites and buildings can make a route more interesting. */
CREATE TABLE dbo.HistoricalSites
(
SiteID int NOT NULL,
DateEstablished date,
HistoricalType varchar(30),
Architect varchar(60)
);

/* Takes into account architecturally beautiful buildings along one’s route. Includes all buildings so that
users can use it to route from place to place */
CREATE TABLE dbo.Buildings
(
SiteID int NOT NULL,
BuildingType varchar(30)
);

/* Environment friendly spaces */
CREATE TABLE dbo.GreenSpaces
(
SiteID int NOT NULL,
GreenType varchar(30),
Indoor bit,
Playground bit
);

ALTER TABLE dbo.MapEntity WITH NOCHECK
ADD CONSTRAINT PK_MapEntity PRIMARY KEY CLUSTERED
(SiteID)
GO

ALTER TABLE dbo.PublicArt WITH NOCHECK
ADD CONSTRAINT PK_PublicArt PRIMARY KEY CLUSTERED
(SiteID)
GO

ALTER TABLE dbo.PublicArt WITH CHECK
ADD CONSTRAINT FK_PublicArt FOREIGN KEY
(SiteID)
REFERENCES dbo.MapEntity(SiteID)
GO

ALTER TABLE dbo.WaterFeatures WITH NOCHECK
ADD CONSTRAINT PK_WaterFeatures PRIMARY KEY CLUSTERED
(SiteID)
GO

ALTER TABLE dbo.WaterFeatures WITH CHECK
ADD CONSTRAINT FK_WaterFeatures FOREIGN KEY
(SiteID)
REFERENCES dbo.MapEntity(SiteID)
GO

ALTER TABLE dbo.ScenicSite WITH NOCHECK
ADD CONSTRAINT PK_ScenicSite PRIMARY KEY CLUSTERED
(SiteID)
GO

ALTER TABLE dbo.ScenicSite WITH CHECK
ADD CONSTRAINT FK_ScenicSite FOREIGN KEY
(SiteID)
REFERENCES dbo.MapEntity(SiteID)
GO

ALTER TABLE dbo.Miscellaneous WITH NOCHECK
ADD CONSTRAINT PK_Miscellaneous PRIMARY KEY CLUSTERED
(SiteID)
GO

ALTER TABLE dbo.Miscellaneous WITH CHECK
ADD CONSTRAINT FK_Miscellaneous FOREIGN KEY
(SiteID)
REFERENCES dbo.MapEntity(SiteID)
GO

ALTER TABLE HistoricalSites WITH NOCHECK
ADD CONSTRAINT PK_HistoricalSites PRIMARY KEY CLUSTERED
(SiteID)
GO

ALTER TABLE HistoricalSites WITH CHECK
ADD CONSTRAINT FK_HistoricalSites FOREIGN KEY
(SiteID)
REFERENCES dbo.MapEntity(SiteID)
GO

ALTER TABLE dbo.Buildings WITH NOCHECK
ADD CONSTRAINT PK_Buildings PRIMARY KEY CLUSTERED
(SiteID)
GO

ALTER TABLE dbo.Buildings WITH CHECK
ADD CONSTRAINT FK_Buildings FOREIGN KEY
(SiteID)
REFERENCES dbo.MapEntity(SiteID)
GO

ALTER TABLE dbo.GreenSpaces WITH NOCHECK
ADD CONSTRAINT PK_GreenSpaces PRIMARY KEY CLUSTERED
(SiteID)
GO

ALTER TABLE dbo.GreenSpaces WITH CHECK
ADD CONSTRAINT FK_GreenSpaces FOREIGN KEY
(SiteID)
REFERENCES dbo.MapEntity(SiteID)
GO

INSERT dbo.MapEntity (SiteID, RoadID, EntityName, Lat, Long, SiteType, HappyPoints, BeautyPoints, PeacePoints, Blurb) VALUES 
	(2000, 15, 'Folk Style', 43.781506, -99.182901, 'PublicArt', 8, 7, 3, 'Folky style'),
	(2111, 13, 'Merry Graffiti', 43.781506, -99.182901, 'PublicArt', 9, 8, 8, 'Unique street art'),
	(2222, 2, 'Lovely Graphic', 43.781506, -99.182901, 'PublicArt', 5, 7, 9, 'Unlike any other'),
	(2333, 10, 'Flowy Illustration', 43.779950, -99.181066, 'PublicArt', 2, 5, 8, 'Like a meadow'),
	(2444, 13, 'Mosaic Power', 43.779532, -99.181560, 'PublicArt', 3, 6, 9, 'What better power is there?'),
	(2555, 4, 'Alps at Night', 43.779981, -99.182300, 'PublicArt', 7, 3, 9, 'Peaceful nature'),
	(2666, 8, 'Fragile Water', 43.779292, -99.181184, 'PublicArt', 10, 8, 8, 'Please do not break'),
	(2777, 5, 'Ceramic Candy', 43.779292, -99.181184, 'PublicArt', 5, 7, 3, 'Why make candy you can not eat?'),
	(2888, 17, 'Ballet Slippers', 43.780012, -99.183340, 'PublicArt', 8, 10, 1, 'Simply graceful'),
	(2999, 13, 'Mini Sistine Chapel', 43.779842, -99.182321, 'PublicArt', 9, 10, 8, 'Our very own replica'),
	(3000, 7, 'Blue Lake', 43.779284, -99.180411, 'WaterFeatures', 8, 8, 8, 'No other lake this blue'),
	(3111, 5, 'Bubbly Stream', 43.779878, -99.179900, 'WaterFeatures', 4, 9, 2, 'Sounds like a babbling brook'),
	(3222, 12, 'Blue Sea', 43.780498, -99.180415, 'WaterFeatures', 7, 7, 7, 'There is a Red Sea and here is the Blue Sea'),
	(3333, 13, 'The Fountain', 43.779514, -99.181509, 'WaterFeatures', 5, 5, 5, 'Not just any fountain'),
	(3444, 1, 'Fall of Truth', 43.779344, -99.182957, 'WaterFeatures', 3, 5, 8, 'But is it?'),
	(3555, 5, 'Babbling Brook', 43.780057, -99.181712, 'WaterFeatures', 7, 7, 7, 'Sounds like a bubbly stream'),
	(3666, 10, 'Fountain 1', 43.779848, -99.182667, 'WaterFeatures', 6, 9, 4, 'Looks like the creator ran out of names'),
	(3777, 11, 'Old Pond', 43.780290, -99.183493, 'WaterFeatures', 5, 5, 5, 'Older than the new pond'),
	(3888, 11, 'Oldest Pond', 43.780608, -99.182796, 'WaterFeatures', 6, 1, 9, 'Even older pond. Where is the new one?'),
	(3999, 16, 'Tiny Dam', 43.781274, -99.181562, 'WaterFeatures', 4, 5, 8, 'Wanted a dam, did not have space'),
	(4000, 5, 'WaterRise', 43.780902, -99.183364, 'ScenicSite', 5, 5, 5, 'Water and Sun'),
	(4111, 12, 'Just the Sun', 43.780205, -99.181830, 'ScenicSite', 7, 7, 7, 'Check name'),
	(4222, 17, 'City with da Water', 43.779283, -99.180585, 'ScenicSite', 9, 9, 9, 'Water and City view'),
	(4333, 4, 'CityRise',43.779283, -99.180585, 'ScenicSite', 3, 8, 5, 'Like water but city'),
	(4444, 3, 'View of the World', 43.781148, -99.181776, 'ScenicSite', 2, 8, 6, 'Not actually view of the world'),
	(4555, 15, 'Not a mountain', 43.781520, -99.180027, 'ScenicSite', 9, 10, 10,'View of everything but the mountain'),
	(4666, 16, 'Oh the view', 43.780691, -99.181636, 'ScenicSite', 3, 6, 8, 'Great'),
	(4777, 11, 'Sunset point',43.779537, -99.182441, 'ScenicSite', 10, 10, 10, 'View of the Sunset'),
	(4888, 2, 'Point of points', 43.779514, -99.181132, 'ScenicSite', 2, 2, 2, 'Just and ok point'),
	(4999, 9, 'La La Point', 43.779932, -99.182248, 'ScenicSite', 4, 8, 4, 'Named after La La Land'),
	(5000, 10, 'Cat Cafe', 43.780110, -99.182613, 'Miscellaneous', 8, 5, 8, 'Cafe with cats'),
	(5111, 4, 'Hedgehog Park', 43.779297, -99.180896, 'Miscellaneous', 3, 4, 6, 'Filled with hedgehogs'),
	(5222, 7, 'Arcade', 43.779289, -99.182098, 'Miscellaneous', 6, 4, 8, 'Games'),
	(5333, 15, 'Hippo Zoo', 43.779467, -99.183064, 'Miscellaneous', 3, 6, 8, 'Everything but hippos'),
	(5444, 1, 'Mystery Spot', 43.779490, -99.183311, 'Miscellaneous', 4, 4, 4, 'Boo'),
	(5555, 6, 'Underground Pub', 43.779327, -99.183021, 'Miscellaneous', 5, 6, 3, 'Best Pub'),
	(5666, 8, 'Helipad', 43.779335, -99.182088, 'Miscellaneous', 6, 4, 8, 'Helicopters'),
	(5777, 3, 'Gum Wall', 43.779482, -99.180747, 'Miscellaneous', 4, 7, 5, 'Have Gum?'),
	(5888, 12, 'Candy Cart', 43.779451, -99.180929, 'Miscellaneous', 3, 3, 3, 'Not suspicious'),
	(5999, 11, 'Sports Area', 43.779319, -99.180897, 'Miscellaneous', 3, 7, 9, 'Fit Life, good life'),
	(6000, 5, 'Museum of Hop Scotch', 43.779327, -99.180747, 'HistoricalSites', 3, 7, 4, 'Hop your way around'),
	(6111, 8, 'Running Castle', 43.779482, -99.180146, 'HistoricalSites', 7, 8, 10, 'Ever seen a castle with legs?'),
	(6222, 1, 'Golden Gate Bridge 2', 43.779381, -99.179996, 'HistoricalSites', 5, 3, 8, 'We got the second one'),
	(6333, 16, 'Museum overflow', 43.780456, -99.180016, 'HistoricalSites', 4, 6, 5, 'Peter has another museum'),
	(6444, 17, 'The Statue', 43.780354, -99.180193, 'HistoricalSites', 4, 2, 9, 'A statue'),
	(6555, 6, 'Elizabeth Memorial', 43.780354, -99.180193, 'HistoricalSites', 4, 2, 9, 'For her mother'),
	(6666, 8, 'Parliament', 43.780504, -99.180153, 'HistoricalSites', 5, 8, 8, 'Why not one here'),
	(6777, 2, 'Supreme Court', 43.780360, -99.180178, 'HistoricalSites', 6, 7, 7, 'Bob wanted one'),
	(6888, 13, 'The Town Hall', 43.780496, -99.180747, 'HistoricalSites', 8, 8, 8, 'Town hall for the city'),
	(6999, 13, 'Palace of the people', 43.780353, -99.180940, 'HistoricalSites', 2, 6, 6, 'Not for royalty'),
	(7000, 17, 'Pukwana University', 43.780270, -99.181886, 'Buildings', 7, 7, 2, 'Where/what is Pukwana?'),
	(7111, 8, 'House 1', 43.780975, -99.182905, 'Buildings', 2, 2, 6, 'A House'),
	(7222, 14, 'Corgi Stadium', 43.780789, -99.181585, 'Buildings', 6, 7, 6, 'Cute'),
	(7333, 11, 'Post Office', 43.780789, -99.181585, 'Buildings', 5, 6, 7, 'Send mail'),
	(7444, 10, 'Library', 43.779599, -99.181175, 'Buildings', 5, 6, 9, 'Books books and more books'),
	(7555, 7, 'Police Station', 43.780118, -99.181787, 'Buildings', 3, 3, 3, 'Sirens all around'),
	(7666, 1, 'Winery', 43.781094, -99.183439, 'Buildings', 3, 7, 7, 'Yum'),
	(7777, 9, 'Opera House', 43.781497, -99.183342, 'Buildings', 4, 7, 7, 'Power of the voice'),
	(7888, 14, 'House 3', 43.781621, -99.182548, 'Buildings', 5, 8, 3, 'There is no house 2'),
	(7999, 16, 'Apartment Block', 43.780885, -99.182956, 'Buildings', 3, 2, 8, 'Extends a mile high'),
	(8000, 3, 'Dog Park', 43.781319, -99.181947, 'GreenSpaces', 3, 8, 8, 'Woof Woof'),
	(8111, 12, 'Walking Trail', 43.780792, -99.182634, 'GreenSpaces', 4, 6, 7, 'Beware of Bears'),
	(8222, 9,'Meditation Center', 43.779762, -99.182795, 'GreenSpaces', 5, 3, 10, 'Zen'),
	(8333, 15, 'Park', 43.779289, -99.181486, 'GreenSpaces', 6, 7, 7, 'Regular Park'),
	(8444, 4, 'Tulip Farm', 43.779862, -99.180209, 'GreenSpaces', 3, 7, 8, 'Look at all the pretty flowers'),
	(8555, 6, 'Farm', 43.779862, -99.180209, 'GreenSpaces', 5, 7, 8, 'Carrots can taste good'),
	(8666, 11,'Community Garden', 43.780829, -99.183355, 'GreenSpaces', 5, 7, 8, 'More carrots'),
	(8777, 1, 'Training Facility', 43.781325, -99.181681, 'GreenSpaces', 2, 3, 1, 'Train'),
	(8888, 1, 'Happy Park',  43.781674, -99.181906, 'GreenSpaces', 4, 6, 7, 'Parks are good'),
	(8999, 2, 'Urban Park', 43.781101, -99.182045, 'GreenSpaces', 4, 6, 1, 'The place for parkour');

INSERT dbo.PublicArt (SiteID, ArtType, Artist) VALUES 
	(2000, 'Folk', 'Jack'), 
	(2111, 'Graffiti', 'Mary'), 
	(2222, 'Graphic', 'Mark'), 
	(2333, 'Illustration', 'Lucy'), 
	(2444, 'Mosaic', 'John'), 
	(2555, 'Photography', 'Jennifer'), 
	(2666, 'Glass', 'Brad'), 
	(2777, 'Ceramic', 'Angelo'), 
	(2888, 'Contemporary', 'Lisa'), 
	(2999, 'Religious', 'Paul');

INSERT dbo.WaterFeatures (SiteID, WaterFeatureType) VALUES 
	(3000, 'Lake'), 
	(3111, 'Stream'), 
	(3222, 'Sea'), 
	(3333, 'Fountain'), 
	(3444, 'Waterfall'), 
	(3555, 'Brook'), 
	(3666, 'Fountain'), 
	(3777, 'Pond'), 
	(3888, 'Pond'), 
	(3999, 'Dam');

INSERT dbo.ScenicSite (SiteID, WaterView, CityView, Mountainview, SunriseSunset) VALUES 
	(3000, 1, 0, 0, 1), 
	(3111, 0, 0, 0, 1), 
	(3222, 1, 1, 0, 1), 
	(3333, 0, 1, 0, 1), 
	(3444, 0, 1, 1, 0), 
	(3555, 1, 1, 0, 1), 
	(3666, 1, 0, 0, 0), 
	(3777, 1, 0, 1, 1), 
	(3888, 1, 0, 1, 0), 
	(3999, 1, 1, 1, 1);

INSERT dbo.Miscellaneous (SiteID, Commercial) VALUES 
	(5000, 'Cat Cafe'), 
	(5111, 'Theme Pak'), 
	(5222, 'Arcade'), 
	(5333, 'Zoo'), 
	(5444, 'Mystery Spot'), 
	(5555, 'Underground Pub'),
	(5666, 'Helipad'), 
	(5777, 'Gum Wall'), 
	(5888, 'Candy Cart'), 
	(5999, 'Sports Area');

INSERT dbo.HistoricalSites (SiteID, DateEstablished, HistoricalType, Architect) VALUES 
	(6000, '1901/07/03', 'Museum', 'Peter'), 
	(6111, '1932/08/14', 'Castle', 'Gary'), 
	(6222, '1979/11/08', 'Bridge', 'Dan'), 
	(6333, '1927/12/28', 'Museum', 'Peter'), 
	(6444, '1894/07/03', 'Statue', 'Suzanne'), 
	(6555, '1949/06/16', 'Memorial', 'Elizabeth'), 
	(6666, '1995/05/30', 'Parliament', 'Tony'), 
	(6777, '1985/09/26', 'Supreme Court', 'Bob'), 
	(6888, '1901/07/03', 'Town Hall', 'Barack'), 
	(6999, '1923/11/08', 'Palace', 'Theresa')

INSERT dbo.Buildings (SiteID, BuildingType) VALUES 
	(7000, 'University'), 
	(7111, 'House'), 
	(7222, 'Stadium'), 
	(7333, 'Post Office'), 
	(7444, 'Library'), 
	(7555, 'Police Station'), 
	(7666, 'Winery'), 
	(7777, 'Opera House'), 
	(7888, 'House'), 
	(7999, 'Apartment Block');

INSERT dbo.GreenSpaces (SiteID, GreenType, Indoor, Playground) VALUES 
	(8000, 'Dog Park', 0, 1), 
	(8111, 'Walking Trail', 0, 0), 
	(8222, 'Meditation Center', 1, 0), 
	(8333, 'Park', 0, 1), 
	(8444, 'Tulip Farm', 0, 0), 
	(8555, 'Farm', 0, 0), 
	(8666, 'Community Garden', 0, 1), 
	(8777, 'Training Facility', 1, 1), 
	(8888, 'Happy Park', 1, 1), 
	(8999, 'Urban Park', 0, 0);

UPDATE dbo.MapEntity
   SET [EncryptedBlurb] = EncryptByKey(Key_GUID('HappyKey'), Blurb);
GO

/* View to see entities found on each road*/
GO
CREATE VIEW entities_found_on_roads AS
SELECT r.RoadID, r.StartLat, r.StartLong, r.EndLat, r.EndLong, m.EntityName, m.Lat, m.Long, m.SiteType, m.Blurb
FROM Roads r LEFT JOIN MapEntity m ON r.RoadID = m.RoadID;
GO

SELECT * FROM entities_found_on_roads;

/*View created to see entities along Sunny Street*/
GO
CREATE VIEW stroll_down_sunny_street AS
SELECT r.RoadName, m.EntityName, m.SiteType, m.Blurb
FROM Roads r Left join MapEntity m on r.RoadID = m.RoadID
WHERE r.RoadName = 'Sunny Street';

GO
SELECT * FROM stroll_down_sunny_street;