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

test_that("key_value_options works", {
  expect_identical(
    key_value_options(NULL),
    setNames(character(), character())
  )

  expect_identical(
    key_value_options(c("key" = "value")),
    c("key" = "value")
  )

  expect_identical(
    key_value_options(list("key" = "value")),
    c("key" = "value")
  )

  expect_identical(
    key_value_options(list("key" = "value", "key2" = NULL)),
    c("key" = "value")
  )

  expect_error(
    key_value_options(list("value")),
    "must be named"
  )

  expect_error(
    key_value_options(setNames(list("value"), "")),
    "must be named"
  )
})

test_that("external pointer embedded environment works", {
  db <- adbc_database_init(adbc_driver_void())
  expect_identical(names(db), "driver")
  expect_identical(length(db), 1L)

  db$key <- "value"
  expect_identical(db$key, "value")

  db[["key"]] <- "value2"
  expect_identical(db[["key"]], "value2")
})

test_that("pointer mover leaves behind an invalid external pointer", {
  db <- adbc_database_init(adbc_driver_void())
  con <- adbc_connection_init(db)
  stmt <- adbc_statement_init(con)

  expect_true(adbc_xptr_is_valid(db))
  expect_true(adbc_xptr_is_valid(adbc_xptr_move(db)))
  expect_false(adbc_xptr_is_valid(db))

  expect_true(adbc_xptr_is_valid(con))
  expect_true(adbc_xptr_is_valid(adbc_xptr_move(con)))
  expect_false(adbc_xptr_is_valid(con))

  expect_true(adbc_xptr_is_valid(stmt))
  expect_true(adbc_xptr_is_valid(adbc_xptr_move(stmt)))
  expect_false(adbc_xptr_is_valid(stmt))

  stream <- nanoarrow::basic_array_stream(list(1:5))
  expect_true(adbc_xptr_is_valid(stream))
  expect_true(adbc_xptr_is_valid(adbc_xptr_move(stream)))
  expect_false(adbc_xptr_is_valid(stream))

  expect_error(
    adbc_xptr_is_valid(NULL),
    "must inherit from one of"
  )

  expect_error(
    adbc_xptr_move(NULL),
    "must inherit from one of"
  )
})
