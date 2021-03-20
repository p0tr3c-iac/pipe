--
-- Application table indexes
--

-- index on `Disabled` and `UpdatedAt` DESC
CREATE INDEX application_disabled_updated_at_desc ON Application (Disabled, UpdatedAt DESC);

-- index on `EnvId` ASC and `UpdatedAt` DESC
ALTER TABLE Application ADD COLUMN EnvId VARCHAR(32) GENERATED ALWAYS AS (data->>"$.env_id") VIRTUAL;
CREATE INDEX application_env_id_updated_at_desc ON Application (EnvId, UpdatedAt DESC);

-- index on `Name` ASC and `UpdatedAt` DESC
ALTER TABLE Application ADD COLUMN Name VARCHAR(50) GENERATED ALWAYS AS (data->>"$.name") VIRTUAL;
CREATE INDEX application_name_updated_at_desc ON Application (Name, UpdatedAt DESC);

-- index on `Deleted` and `CreatedAt` ASC
-- TODO: Reconsider make this Deleted column as STORED GENERATED COLUMN
ALTER TABLE Application ADD COLUMN Deleted BOOL GENERATED ALWAYS AS (data->>"$.deleted") VIRTUAL;
CREATE INDEX application_deleted_created_at_asc ON Application (Deleted, CreatedAt);

-- index on `Kind` ASC and `UpdatedAt` DESC
ALTER TABLE Application ADD COLUMN Kind INT GENERATED ALWAYS AS (data->>"$.kind") VIRTUAL;
CREATE INDEX application_kind_updated_at_desc ON Application (Kind, UpdatedAt DESC);

-- index on `SyncState.Status` ASC and `UpdatedAt` DESC
ALTER TABLE Application ADD COLUMN SyncState_Status INT GENERATED ALWAYS AS (data->>"$.sync_state.status") VIRTUAL;
CREATE INDEX application_sync_state_updated_at_desc ON Application (SyncState_Status, UpdatedAt DESC);

-- index on `ProjectId` ASC and `UpdatedAt` DESC
CREATE INDEX application_project_id_updated_at_desc ON Application (ProjectId, UpdatedAt DESC);

--
-- Command table indexes
--

-- index on `Status` ASC and `CreatedAt` ASC
ALTER TABLE Command ADD COLUMN Status INT GENERATED ALWAYS AS (data->>"$.status") VIRTUAL;
CREATE INDEX command_status_created_at_asc ON Command (Status, CreatedAt);

--
-- Deployment table indexes
--

-- index on `ApplicationId` ASC and `UpdatedAt` DESC
ALTER TABLE Deployment ADD COLUMN ApplicationId VARCHAR(32) GENERATED ALWAYS AS (data->>"$.application_id") VIRTUAL;
CREATE INDEX deployment_application_id_updated_at_desc ON Deployment (ApplicationId, UpdatedAt DESC);

-- index on `ProjectId` ASC and `UpdatedAt` DESC
CREATE INDEX deployment_project_id_updated_at_desc ON Deployment (ProjectId, UpdatedAt DESC);

-- index on `EnvId` ASC and `UpdatedAt` DESC
ALTER TABLE Deployment ADD COLUMN EnvId VARCHAR(32) GENERATED ALWAYS AS (data->>"$.env_id") VIRTUAL;
CREATE INDEX deployment_env_id_updated_at_desc ON Deployment (EnvId, UpdatedAt DESC);

-- index on `Kind` ASC and `UpdatedAt` DESC
ALTER TABLE Deployment ADD COLUMN Kind INT GENERATED ALWAYS AS (data->>"$.kind") VIRTUAL;
CREATE INDEX deployment_kind_updated_at_desc ON Deployment (Kind, UpdatedAt DESC);

-- index on `Status` ASC and `UpdatedAt` DESC
ALTER TABLE Deployment ADD COLUMN Status INT GENERATED ALWAYS AS (data->>"$.status") VIRTUAL;
CREATE INDEX deployment_status_updated_at_desc ON Deployment (Status, UpdatedAt DESC);

--
-- Event table indexes
--

-- index on `ProjectId` ASC and `CreatedAt` ASC
CREATE INDEX event_project_id_created_at_asc ON Event (ProjectId, CreatedAt);

-- index on `EventKey` ASC, `Name` ASC, `ProjectId` ASC and `CreatedAt` DESC
ALTER TABLE Event ADD COLUMN EventKey VARCHAR(64) GENERATED ALWAYS AS (data->>"$.event_key") VIRTUAL, ADD COLUMN Name VARCHAR(50) GENERATED ALWAYS AS (data->>"$.name") VIRTUAL;
CREATE INDEX event_key_name_project_id_created_at_desc ON Event (EventKey, Name, ProjectId, CreatedAt DESC);