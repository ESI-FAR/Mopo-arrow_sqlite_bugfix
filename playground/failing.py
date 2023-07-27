#!/usr/bin/env python3

import adbc_driver_sqlite.dbapi
import pyarrow as pa


DB_NAME="db.sqlite"

with adbc_driver_sqlite.dbapi.connect("file:"+DB_NAME) as connection:
    objects: pa.lib.RecordBatchReader = connection.adbc_get_objects()
