// Code generated by _tmpl/utils.h.tmpl. DO NOT EDIT.

// Licensed to the Apache Software Foundation (ASF) under one
// or more contributor license agreements.  See the NOTICE file
// distributed with this work for additional information
// regarding copyright ownership.  The ASF licenses this file
// to you under the Apache License, Version 2.0 (the
// "License"); you may not use this file except in compliance
// with the License.  You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

// clang-format off
//go:build driverlib
//  clang-format on

#pragma once

#include <stdlib.h>
#include "../../drivermgr/adbc.h"

AdbcStatusCode PanicDummyDatabaseNew(struct AdbcDatabase* db, struct AdbcError* err);
AdbcStatusCode PanicDummyDatabaseSetOption(struct AdbcDatabase* db, const char* key,
                                           const char* value, struct AdbcError* err);
AdbcStatusCode PanicDummyDatabaseInit(struct AdbcDatabase* db, struct AdbcError* err);
AdbcStatusCode PanicDummyDatabaseRelease(struct AdbcDatabase* db, struct AdbcError* err);
AdbcStatusCode PanicDummyConnectionNew(struct AdbcConnection* cnxn,
                                       struct AdbcError* err);
AdbcStatusCode PanicDummyConnectionSetOption(struct AdbcConnection* cnxn, const char* key,
                                             const char* val, struct AdbcError* err);
AdbcStatusCode PanicDummyConnectionInit(struct AdbcConnection* cnxn,
                                        struct AdbcDatabase* db, struct AdbcError* err);
AdbcStatusCode PanicDummyConnectionRelease(struct AdbcConnection* cnxn,
                                           struct AdbcError* err);
AdbcStatusCode PanicDummyConnectionGetInfo(struct AdbcConnection* cnxn, uint32_t* codes,
                                           size_t len, struct ArrowArrayStream* out,
                                           struct AdbcError* err);
AdbcStatusCode PanicDummyConnectionGetObjects(
    struct AdbcConnection* cnxn, int depth, const char* catalog, const char* dbSchema,
    const char* tableName, const char** tableType, const char* columnName,
    struct ArrowArrayStream* out, struct AdbcError* err);
AdbcStatusCode PanicDummyConnectionGetTableSchema(
    struct AdbcConnection* cnxn, const char* catalog, const char* dbSchema,
    const char* tableName, struct ArrowSchema* schema, struct AdbcError* err);
AdbcStatusCode PanicDummyConnectionGetTableTypes(struct AdbcConnection* cnxn,
                                                 struct ArrowArrayStream* out,
                                                 struct AdbcError* err);
AdbcStatusCode PanicDummyConnectionReadPartition(struct AdbcConnection* cnxn,
                                                 const uint8_t* serialized,
                                                 size_t serializedLen,
                                                 struct ArrowArrayStream* out,
                                                 struct AdbcError* err);
AdbcStatusCode PanicDummyConnectionCommit(struct AdbcConnection* cnxn,
                                          struct AdbcError* err);
AdbcStatusCode PanicDummyConnectionRollback(struct AdbcConnection* cnxn,
                                            struct AdbcError* err);
AdbcStatusCode PanicDummyStatementNew(struct AdbcConnection* cnxn,
                                      struct AdbcStatement* stmt, struct AdbcError* err);
AdbcStatusCode PanicDummyStatementRelease(struct AdbcStatement* stmt,
                                          struct AdbcError* err);
AdbcStatusCode PanicDummyStatementPrepare(struct AdbcStatement* stmt,
                                          struct AdbcError* err);
AdbcStatusCode PanicDummyStatementExecuteQuery(struct AdbcStatement* stmt,
                                               struct ArrowArrayStream* out,
                                               int64_t* affected, struct AdbcError* err);
AdbcStatusCode PanicDummyStatementSetSqlQuery(struct AdbcStatement* stmt,
                                              const char* query, struct AdbcError* err);
AdbcStatusCode PanicDummyStatementSetSubstraitPlan(struct AdbcStatement* stmt,
                                                   const uint8_t* plan, size_t length,
                                                   struct AdbcError* err);
AdbcStatusCode PanicDummyStatementBind(struct AdbcStatement* stmt,
                                       struct ArrowArray* values,
                                       struct ArrowSchema* schema, struct AdbcError* err);
AdbcStatusCode PanicDummyStatementBindStream(struct AdbcStatement* stmt,
                                             struct ArrowArrayStream* stream,
                                             struct AdbcError* err);
AdbcStatusCode PanicDummyStatementGetParameterSchema(struct AdbcStatement* stmt,
                                                     struct ArrowSchema* schema,
                                                     struct AdbcError* err);
AdbcStatusCode PanicDummyStatementSetOption(struct AdbcStatement* stmt, const char* key,
                                            const char* value, struct AdbcError* err);
AdbcStatusCode PanicDummyStatementExecutePartitions(struct AdbcStatement* stmt,
                                                    struct ArrowSchema* schema,
                                                    struct AdbcPartitions* partitions,
                                                    int64_t* affected,
                                                    struct AdbcError* err);
AdbcStatusCode PanicDummyDriverInit(int version, void* rawDriver, struct AdbcError* err);

static inline void PanicDummyerrRelease(struct AdbcError* error) {
  error->release(error);
}

void PanicDummy_release_error(struct AdbcError* error);
