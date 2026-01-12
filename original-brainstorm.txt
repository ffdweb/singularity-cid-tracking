CREATE TABLE Deals ( -- from Singularity
  DealID, -- primary key
  Status, -- updated by deal tracker
  Provider, -- exactly 1
  PieceCID, -- foreign key, exactly 1 per deal
  PieceSize,
  StartEpoch,
  Price,
  Verified,
  ClientID -- foreign key, exactly 1
);

CREATE TABLE Clients ( -- manually populated by Brian
  ClientID, -- primary key (f0...)
  ClientAddress, -- long version (f1...)
  Active, -- boolean, manually set
  ClientOwner -- PA or IA, manually set
); 

CREATE TABLE Pieces ( -- aggregated from Singularity output
  PieceCID, -- primary key, content addressed
  PrepID, -- foreign key, many to many (usually one prep to many pieces)
  PieceType, -- data or dag; not present in preparations that predate implementation; may drop
  IsDag, -- boolean, from script
  StorageID, -- foreign key, from script
  RootCID,
  FileSize,
  PieceSize
);

CREATE TABLE Storages { -- from Singularity
  StorageID, -- primary key, assigned by Singularity
  StorageName,
  Type, -- internetarchive, local, union; may drop
  IsUnion, -- boolean, from script
}

CREATE TABLE Preparations ( -- from Singularity
  PrepID, -- primary key, assigned by Singularity
  PrepName,
  DeleteAfterExport,
  MaxSize,
  StorageID -- foreign key, one storage to many preps
  IsUnion, -- can come from storages table if doing that way
);

CREATE TABLE Items ( -- Populated by Brian from IA search
  Identifier, -- IA item identifier, matches IA metadata identifier, manually set based on Brian's list
  ItemSize, -- from IA list
  PreparationID, -- foreign key, many to many
  PiecesCount,
  PackedSize, -- sum of piece sizes from Singularity; used as sanity check
  TillieStatus, -- bool complete or not
  MiladStatus, 
  DCentStatus, 
);

CREATE TABLE Files (  -- Populated by Brian from IA metadata
  FileName, -- primary key
  ItemID, -- foreign key, each file should have exactly 1 Item, each Item will have 1 or more Files
);
