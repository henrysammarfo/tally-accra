BEGIN;

--
-- Function: gen_random_uuid_v7()
-- Source: https://gist.github.com/kjmph/5bd772b2c2df145aa645b837da7eca74
-- License: MIT (copyright notice included on the generator source code).
--
create or replace function gen_random_uuid_v7()
returns uuid
as $$
begin
  -- use random v4 uuid as starting point (which has the same variant we need)
  -- then overlay timestamp
  -- then set version 7 by flipping the 2 and 1 bit in the version 4 string
  return encode(
    set_bit(
      set_bit(
        overlay(uuid_send(gen_random_uuid())
                placing substring(int8send(floor(extract(epoch from clock_timestamp()) * 1000)::bigint) from 3)
                from 1 for 6
        ),
        52, 1
      ),
      53, 1
    ),
    'hex')::uuid;
end
$$
language plpgsql
volatile;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "audit_event" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "organizationId" uuid NOT NULL,
    "authUserId" uuid NOT NULL,
    "action" text NOT NULL,
    "detail" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "audit_org_created_idx" ON "audit_event" USING btree ("organizationId", "createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "deposit" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "organizationId" uuid NOT NULL,
    "roomId" uuid NOT NULL,
    "guestName" text NOT NULL,
    "guestPhone" text NOT NULL,
    "nights" bigint NOT NULL,
    "amount" double precision NOT NULL,
    "currency" text NOT NULL,
    "method" text NOT NULL,
    "receptionistName" text NOT NULL,
    "receiptCode" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "deposit_org_created_idx" ON "deposit" USING btree ("organizationId", "createdAt");
CREATE UNIQUE INDEX "deposit_receipt_idx" ON "deposit" USING btree ("receiptCode");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "membership" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "organizationId" uuid NOT NULL,
    "authUserId" uuid NOT NULL,
    "role" text NOT NULL,
    "displayName" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "membership_org_user_idx" ON "membership" USING btree ("organizationId", "authUserId");
CREATE INDEX "membership_auth_user_idx" ON "membership" USING btree ("authUserId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "organization" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "name" text NOT NULL,
    "slug" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "organization_slug_idx" ON "organization" USING btree ("slug");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "room" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "organizationId" uuid NOT NULL,
    "number" text NOT NULL,
    "type" text NOT NULL,
    "rateGhs" double precision NOT NULL,
    "status" text NOT NULL,
    "guestName" text,
    "depositAmount" double precision,
    "checkInAt" timestamp without time zone,
    "nights" bigint
);

-- Indexes
CREATE UNIQUE INDEX "room_org_number_idx" ON "room" USING btree ("organizationId", "number");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "shift_close" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "organizationId" uuid NOT NULL,
    "closed" boolean NOT NULL DEFAULT false,
    "closedAt" timestamp without time zone,
    "notes" text,
    "expectedTotal" double precision,
    "countedTotal" double precision
);

-- Indexes
CREATE UNIQUE INDEX "shift_close_org_idx" ON "shift_close" USING btree ("organizationId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "audit_event"
    ADD CONSTRAINT "audit_event_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "deposit"
    ADD CONSTRAINT "deposit_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "deposit"
    ADD CONSTRAINT "deposit_fk_1"
    FOREIGN KEY("roomId")
    REFERENCES "room"("id")
    ON DELETE RESTRICT
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "membership"
    ADD CONSTRAINT "membership_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "room"
    ADD CONSTRAINT "room_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "shift_close"
    ADD CONSTRAINT "shift_close_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR tally
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('tally', '20260929112854014-till-spine', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260929112854014-till-spine', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260924105404509', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105404509', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260924105232991', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105232991', "timestamp" = now();


COMMIT;
