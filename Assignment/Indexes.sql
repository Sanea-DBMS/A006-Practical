CREATE INDEX Accindex
ON AccountDetails(AccountID);

CREATE UNIQUE INDEX AccountIndex
ON AccountDetails(AccountID);

CREATE INDEX AccIDindex
USING HASH
ON AccountDetails(AccountID);

DROP INDEX AccIDindex
ON AccountDetails;