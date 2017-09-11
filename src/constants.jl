
@enum BOOL FALSE=Cint(0) TRUE=Cint(1)

UNKNOWN = Cint(0xFFFF)

@enum(Consistency,
                CONSISTENCY_ANY          = Cint(0x0000),
                CONSISTENCY_ONE          = Cint(0x0001),
                CONSISTENCY_TWO          = Cint(0x0002),
                CONSISTENCY_THREE        = Cint(0x0003),
                CONSISTENCY_QUORUM       = Cint(0x0004),
                CONSISTENCY_ALL          = Cint(0x0005),
                CONSISTENCY_LOCAL_QUORUM = Cint(0x0006),
                CONSISTENCY_EACH_QUORUM  = Cint(0x0007),
                CONSISTENCY_SERIAL       = Cint(0x0008),
                CONSISTENCY_LOCAL_SERIAL = Cint(0x0009),
                CONSISTENCY_LOCAL_ONE    = Cint(0x000A) )

@enum(WriteType,
                WRITE_TYPE_UKNOWN,
                WRITE_TYPE_SIMPLE,
                WRITE_TYPE_BATCH,
                WRITE_TYPE_UNLOGGED_BATCH,
                WRITE_TYPE_COUNTER,
                WRITE_TYPE_BATCH_LOG,
                WRITE_TYPE_CAS )

@enum(ColumnType,
                COLUMN_TYPE_REGULAR,
                COLUMN_TYPE_PARTITION_KEY,
                COLUMN_TYPE_CLUSTERING_KEY,
                COLUMN_TYPE_STATIC,
                COLUMN_TYPE_COMPACT_VALUE )

@enum(IndexType,
                INDEX_TYPE_UNKNOWN,
                INDEX_TYPE_KEYS,
                INDEX_TYPE_CUSTOM,
                INDEX_TYPE_COMPOSITES )

@enum(IteratorType,
                ITERATOR_TYPE_RESULT,
                ITERATOR_TYPE_ROW,
                ITERATOR_TYPE_COLLECTION,
                ITERATOR_TYPE_MAP,
                ITERATOR_TYPE_TUPLE,
                ITERATOR_TYPE_USER_TYPE_FIELD,
                ITERATOR_TYPE_META_FIELD,
                ITERATOR_TYPE_KEYSPACE_META,
                ITERATOR_TYPE_TABLE_META,
                ITERATOR_TYPE_TYPE_META,
                ITERATOR_TYPE_FUNCTION_META,
                ITERATOR_TYPE_AGGREGATE_META,
                ITERATOR_TYPE_COLUMN_META,
                ITERATOR_TYPE_INDEX_META,
                ITERATOR_TYPE_MATERIALIZED_VIEW_META )

@enum(ValueType,
                VALUE_TYPE_CUSTOM = Cint(0x0000),
                VALUE_TYPE_ASCII = Cint(0x0001),
                VALUE_TYPE_BIGINT = Cint(0x0002),
                VALUE_TYPE_BLOB = Cint(0x0003),
                VALUE_TYPE_BOOLEAN = Cint(0x0004),
                VALUE_TYPE_COUNTER = Cint(0x0005),
                VALUE_TYPE_DECIMAL = Cint(0x0006),
                VALUE_TYPE_DOUBLE = Cint(0x0007),
                VALUE_TYPE_FLOAT = Cint(0x0008),
                VALUE_TYPE_INT = Cint(0x0009),
                VALUE_TYPE_TEXT = Cint(0x000A),
                VALUE_TYPE_TIMESTAMP = Cint(0x000B),
                VALUE_TYPE_UUID = Cint(0x000C),
                VALUE_TYPE_VARCHAR = Cint(0x000D),
                VALUE_TYPE_VARINT = Cint(0x000E),
                VALUE_TYPE_TIMEUUID = Cint(0x000F),
                VALUE_TYPE_INET = Cint(0x0010),
                VALUE_TYPE_DATE = Cint(0x0011),
                VALUE_TYPE_TIME = Cint(0x0012),
                VALUE_TYPE_SMALL_INT = Cint(0x0013),
                VALUE_TYPE_TINY_INT = Cint(0x0014),
                VALUE_TYPE_DURATION = Cint(0x0015),
                VALUE_TYPE_LIST = Cint(0x0020),
                VALUE_TYPE_MAP = Cint(0x0021),
                VALUE_TYPE_SET = Cint(0x0022),
                VALUE_TYPE_UDT = Cint(0x0030),
                VALUE_TYPE_TUPLE = Cint(0x0031) )

@enum(ClusteringOrder,
                CLUSTERING_ORDER_NONE,
                CLUSTERING_ORDER_ASC,
                CLUSTERING_ORDER_DESC )

@enum(CollectionType,
                COLLECTION_TYPE_LIST = Cint(0x0020),
                COLLECTION_TYPE_MAP = Cint(0x9921),
                COLLECTION_TYPE_SET = Cint(0x0022) )

@enum(SslVerifyFlags,
                SSL_VERIFY_NONE              = Cint(0x00),
                SSL_VERIFY_PEER_CERT         = Cint(0x01),
                SSL_VERIFY_PEER_IDENTITY     = Cint(0x02),
                SSL_VERIFY_PEER_IDENTITY_DNS = Cint(0x04) )

@enum(ProtocolVersion,
                PROTOCOL_VERSION_V1    = Cint(0x01),
                PROTOCOL_VERSION_V2    = Cint(0x02),
                PROTOCOL_VERSION_V3    = Cint(0x03),
                PROTOCOL_VERSION_V4    = Cint(0x04) )

@enum(ErrorSource,
                ERROR_SOURCE_NONE,
                ERROR_SOURCE_LIB,
                ERROR_SOURCE_SERVER,
                ERROR_SOURCE_SSL,
                ERROR_SOURCE_COMPRESSION)

@enum(BatchType,
                BATCH_TYPE_LOGGED = Cint(0x00),
                BATCH_TYPE_UNLOGGED = Cint(0x01),
                BATCH_TYPE_COUNTER = Cint(0x02) )

@enum(LogLevel,
                LOG_DISABLED,
                LOG_CRITICAL,
                LOG_ERROR,
                LOG_WARN,
                LOG_INFO,
                LOG_DEBUG,
                LOG_TRACE )
