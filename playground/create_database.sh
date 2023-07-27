#!/usr/bin/env sh

DB_NAME="db.sqlite"
SQL_COMMAND="CREATE TABLE album(
  albumartist TEXT,
  PRIMARY KEY(albumartist)
);

CREATE TABLE song(
  songartist TEXT,
  FOREIGN KEY(songartist) REFERENCES album(albumartist)
);"

# Remove old db if it exists
[ -e "$DB_NAME" ] && rm -- "$DB_NAME"

# Create new db
sqlite3 "$DB_NAME" "$SQL_COMMAND" ".exit"
