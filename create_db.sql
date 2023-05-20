CREATE DATABASE IntelligenceWorldDB;

USE IntelligenceWorldDB;


CREATE TABLE Countries(
    Id          INT AUTO_INCREMENT
                      PRIMARY KEY,
    Name        NVARCHAR(150)           NOT NULL
);


CREATE TABLE AccessLevels(
    Id          INT AUTO_INCREMENT
                         PRIMARY KEY,
    CountryId   INT                     NOT NULL,
    Name        NVARCHAR(100)           NOT NULL,
    Description NVARCHAR(400)           NULL,
    CONSTRAINT AccessLevelCountryFk
        FOREIGN KEY (CountryId) REFERENCES Countries (Id)
);


CREATE TABLE Agencies(
    Id              INT AUTO_INCREMENT
                     PRIMARY KEY,
    Name            NVARCHAR(150)           NOT NULL,
    Headquarters    NVARCHAR(150)           NULL,
    Description     NVARCHAR(300)           NOT NULL
);


CREATE TABLE Departments(
    Id              INT AUTO_INCREMENT
                        PRIMARY KEY,
    AgencyId        INT                     NOT NULL,
    Name            NVARCHAR(150)           NOT NULL,
    CONSTRAINT DepartmentAgencyFk
        FOREIGN KEY (AgencyId) REFERENCES Agencies(Id)
);


CREATE TABLE AgencyWorkers(
    Id          INT AUTO_INCREMENT
                          PRIMARY KEY,
    FullName    NVARCHAR(100)               NOT NULL
);


CREATE TABLE DepartmentHeads
(
    Id              INT
                        PRIMARY KEY,
    DepartmentId    INT                     NOT NULL,
    CONSTRAINT DepartmentHeadAgencyWorkerFk
        FOREIGN KEY (Id) REFERENCES AgencyWorkers(Id),
    CONSTRAINT DepartmentHeadDepartmentFk
        FOREIGN KEY (DepartmentId) REFERENCES Departments(Id)
);


CREATE TABLE Agents(
    Id          INT
                   PRIMARY KEY,
    CONSTRAINT AgentAgencyWorkerFk
        FOREIGN KEY (Id) REFERENCES AgencyWorkers(Id)
);


CREATE TABLE CoverEntities(
    Id          INT AUTO_INCREMENT
                          PRIMARY KEY,
    FullName    NVARCHAR(100)               NOT NULL,
    Legend      NVARCHAR(500)               NULL
);


CREATE TABLE Operations(
    Id          INT AUTO_INCREMENT
                       PRIMARY KEY,
    Name        NVARCHAR(130)               NOT NULL,
    Description NVARCHAR(300)               NULL,
    Status      NCHAR(75)                   NOT NULL
);


CREATE TABLE AgentIntelligenceActivity(
    Id              INT AUTO_INCREMENT
                            PRIMARY KEY,
    CoverEntityId   INT                     NOT NULL,
    OperationId     INT                     NOT NULL,
    AgentId         INT                     NOT NULL,
    CONSTRAINT AgentIntelligenceActivityCoverEntityFk
        FOREIGN KEY (CoverEntityId) REFERENCES CoverEntities(Id),
    CONSTRAINT AgentIntelligenceActivityOperationFk
        FOREIGN KEY (OperationId) REFERENCES Operations(Id),
    CONSTRAINT AgentIntelligenceActivityAgentFk
        FOREIGN KEY (AgentId) REFERENCES Agents(Id)
);


CREATE TABLE OperationCommanders(
    Id              INT
                        PRIMARY KEY,
    OperationId     INT                     NOT NULL,
    CONSTRAINT OperationCommandersAgencyWorkerFk
        FOREIGN KEY (Id) REFERENCES AgencyWorkers(Id),
    CONSTRAINT OperationCommandersOperationFk
        FOREIGN KEY (OperationId) REFERENCES Operations(Id)
);


CREATE TABLE StationaryWorkers(
    Id              INT
                        PRIMARY KEY,
    DepartmentId    INT                 NOT NULL,
    CONSTRAINT StationaryWorkersAgencyWorkerFk
        FOREIGN KEY (Id) REFERENCES AgencyWorkers(Id),
    CONSTRAINT StationaryWorkersDepartmentFk
        FOREIGN KEY (DepartmentId) REFERENCES Departments(Id)
);


CREATE TABLE StationaryWorkersToOperations(
    StationaryWorkerId  INT             NOT NULL,
    OperationId         INT             NOT NULL,
    AccessLevelId       INT             NOT NULL,
    CONSTRAINT StationaryWorkersToOperationsPk
        PRIMARY KEY (StationaryWorkerId, OperationId),
    CONSTRAINT StationaryWorkersToOperationsStationaryWorkerFk
        FOREIGN KEY (StationaryWorkerId) REFERENCES StationaryWorkers(Id),
    CONSTRAINT StationaryWorkersToOperationsOperationFk
        FOREIGN KEY (OperationId) REFERENCES Operations(Id),
    CONSTRAINT StationaryWorkersToOperationsAccessLevelFk
        FOREIGN KEY (AccessLevelId) REFERENCES AccessLevels(Id)
);


CREATE TABLE OperationConduction(
    CountryId       INT     NOT NULL,
    OperationId     INT     NOT NULL,
    AgencyId        INT     NOT NULL,
    CONSTRAINT OperationConductionPk
        PRIMARY KEY (CountryId, OperationId, AgencyId),
    CONSTRAINT OperationConductionCountryFk
        FOREIGN KEY (CountryId) REFERENCES Countries(Id),
    CONSTRAINT OperationConductionOperationFk
        FOREIGN KEY (OperationId) REFERENCES Operations(Id),
    CONSTRAINT OperationConductionAgencyFk
        FOREIGN KEY (AgencyId) REFERENCES Agencies(Id)
);