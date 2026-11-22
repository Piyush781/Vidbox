-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "email" TEXT NOT NULL,
    "passwordHash" TEXT NOT NULL,
    "role" TEXT NOT NULL DEFAULT 'USER',
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "RefreshToken" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "tokenHash" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "expiresAt" DATETIME NOT NULL,
    "revokedAt" DATETIME,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "RefreshToken_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Profile" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "userId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "avatarkey" TEXT NOT NULL DEFAULT 'avatar-1',
    "isKids" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "Profile_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "WatchListItem" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "profileId" TEXT NOT NULL,
    "tmdbId" INTEGER NOT NULL,
    "mediaType" TEXT NOT NULL,
    "addedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "WatchListItem_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "WatchProgress" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "profileId" TEXT NOT NULL,
    "tmdbId" INTEGER NOT NULL,
    "mediaType" TEXT NOT NULL,
    "positionSeconds" INTEGER NOT NULL DEFAULT 0,
    "durationSeconds" INTEGER NOT NULL DEFAULT 0,
    "completed" BOOLEAN NOT NULL DEFAULT false,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "WatchProgress_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "RefreshToken_tokenHash_key" ON "RefreshToken"("tokenHash");

-- CreateIndex
CREATE INDEX "RefreshToken_userId_idx" ON "RefreshToken"("userId");

-- CreateIndex
CREATE INDEX "Profile_userId_idx" ON "Profile"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Profile_userId_name_key" ON "Profile"("userId", "name");

-- CreateIndex
CREATE INDEX "WatchListItem_profileId_addedAt_idx" ON "WatchListItem"("profileId", "addedAt");

-- CreateIndex
CREATE UNIQUE INDEX "WatchListItem_profileId_tmdbId_mediaType_key" ON "WatchListItem"("profileId", "tmdbId", "mediaType");

-- CreateIndex
CREATE INDEX "WatchProgress_profileId_updatedAt_idx" ON "WatchProgress"("profileId", "updatedAt");

-- CreateIndex
CREATE UNIQUE INDEX "WatchProgress_profileId_tmdbId_mediaType_key" ON "WatchProgress"("profileId", "tmdbId", "mediaType");
