# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

test_that("adbcsqlite() works", {
  expect_s3_class(adbcsqlite(), "adbc_driver")
})

test_that("default options can open a database and execute a query", {
  db <- adbcdrivermanager::adbc_database_init(adbcsqlite())
  expect_s3_class(db, "adbcsqlite_database")

  con <- adbcdrivermanager::adbc_connection_init(db)
  expect_s3_class(con, "adbcsqlite_connection")

  stmt <- adbcdrivermanager::adbc_statement_init(con)
  expect_s3_class(stmt, "adbcsqlite_statement")

  adbcdrivermanager::adbc_statement_set_sql_query(
    stmt,
    "CREATE TABLE crossfit (exercise TEXT, difficulty_level INTEGER)"
  )
  adbcdrivermanager::adbc_statement_execute_query(stmt)
  adbcdrivermanager::adbc_statement_release(stmt)

  stmt <- adbcdrivermanager::adbc_statement_init(con)
  adbcdrivermanager::adbc_statement_set_sql_query(
    stmt,
    "INSERT INTO crossfit values
      ('Push Ups', 3),
      ('Pull Ups', 5),
      ('Push Jerk', 7),
      ('Bar Muscle Up', 10);"
  )
  adbcdrivermanager::adbc_statement_execute_query(stmt)
  adbcdrivermanager::adbc_statement_release(stmt)

  stmt <- adbcdrivermanager::adbc_statement_init(con)
  adbcdrivermanager::adbc_statement_set_sql_query(
    stmt,
    "SELECT * from crossfit"
  )

  stream <- nanoarrow::nanoarrow_allocate_array_stream()
  adbcdrivermanager::adbc_statement_execute_query(stmt, stream)

  expect_identical(
    as.data.frame(stream),
    data.frame(
      exercise = c("Push Ups", "Pull Ups", "Push Jerk", "Bar Muscle Up"),
      difficulty_level = c(3, 5, 7, 10),
      stringsAsFactors = FALSE
    )
  )

  adbcdrivermanager::adbc_statement_release(stmt)
  adbcdrivermanager::adbc_connection_release(con)
  adbcdrivermanager::adbc_database_release(db)
})

test_that("read/write/execute SQL work with sqlite connections", {
  skip_if_not(packageVersion("nanoarrow") >= "0.1.0.9000")

  db <- adbc_database_init(adbcsqlite())
  con <- adbc_connection_init(db)

  df <- data.frame(x = as.double(1:10))
  expect_identical(adbcdrivermanager::write_adbc(df, con, "df"), df)

  stream <- adbcdrivermanager::read_adbc(con, "SELECT * from df")
  expect_identical(as.data.frame(stream), df)
  stream$release()

  expect_identical(
    adbcdrivermanager::execute_adbc(
      con,
      "UPDATE df SET x = x + ?",
      bind = data.frame(2)
    ),
    con
  )

  stream <- adbcdrivermanager::read_adbc(con, "SELECT * from df")
  expect_identical(as.data.frame(stream), data.frame(x = as.double(3:12)))
  stream$release()
})

test_that("read/write/execute SQL work with sqlite databases", {
  skip_if_not(packageVersion("nanoarrow") >= "0.1.0.9000")

  temp_db <- tempfile()
  on.exit(unlink(temp_db))

  db <- adbc_database_init(adbcsqlite(), uri = temp_db)

  df <- data.frame(x = as.double(1:10))
  expect_identical(adbcdrivermanager::write_adbc(df, db, "df"), df)

  stream <- adbcdrivermanager::read_adbc(db, "SELECT * from df")
  expect_identical(as.data.frame(stream), df)
  stream$release()

  expect_identical(
    adbcdrivermanager::execute_adbc(
      db,
      "UPDATE df SET x = x + ?",
      bind = data.frame(2)
    ),
    db
  )

  stream <- adbcdrivermanager::read_adbc(db, "SELECT * from df")
  expect_identical(as.data.frame(stream), data.frame(x = as.double(3:12)))
  stream$release()
})
