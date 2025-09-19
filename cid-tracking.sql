CREATE TABLE Deals ( -- from Singularity
  DealID, -- primary key
  State,
  Provider, -- exactly 1
  PieceCID, -- foreign key, 0 or more deals per piece
  PieceSize,
  StartEpoch,
  Price,
  Verified,
  ClientID -- foregin key, exactly 1
);

CREATE TABLE Clients ( -- manually populated by Brian
  ClientID -- primary key (f0...)
  ClientAddress -- long version (f1...)
  Active -- boolean, manually set
  ClientOwner -- PA or IA, manually set
); 

CREATE TABLE Pieces ( -- 
  PieceCID -- primary key
);

CREATE TABLE Storages { -- from Signularity
  
}

CREATE TABLE Preparations ( -- from Singularity
  PreparationID, -- primary key, assigned by Singularity
  PreparationName,
  DeleteAfterExport,
  MaxSize,
  Union, -- bolean
  PieceCID -- foreign key, 1 or more pieces for each preparation
);

CREATE TABLE Items ( -- populated by Brian from IA metadata
  ItemID, -- IA item identifier, matches IA metadata identifier, manually set based on Brian's list
  PreparationID -- foreign key, many to many\, an item can be in 0 or more preparations, and a prepartion can contain 1 or more Items.
);

CREATE TABLE Files (  -- Populated by Brian from IA metadata
  FileName, -- primary key
  ItemID, -- foregin key, each file should have exactly 1 Item, each Item will have 1 or more Files
)
