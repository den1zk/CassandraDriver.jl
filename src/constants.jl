error_desc(rc::Cint) = unsafe_string( ccall((:cass_error_desc, libcass, Cstring, (Cint,), rc) ) )

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

abstract type IteratorType end
struct ResultIteratorType <: IteratorType end
struct RowIteratorType <: IteratorType end
struct CollectionIteratorType <: IteratorType end
struct MapIteratorType <: IteratorType end
struct TupleIteratorType <: IteratorType end
struct UserTypeFieldIteratorType <: IteratorType end
struct MetaFieldIteratorType <: IteratorType end
struct KeyspaceMetaIteratorType <: IteratorType end
struct TableMetaIteratorType <: IteratorType end
struct TypeMetaIteratorType <: IteratorType end
struct FunctionMetaIteratorType <: IteratorType end
struct AggregateMetaIteratorType <: IteratorType end
struct ColumnMetaIteratorType <: IteratorType end
struct IndexMetaIteratorType <: IteratorType end
struct MaterializedViewMetaIteratorType <: IteratorType end

IteratorTypes = Dict{Integer, IteratorType}(
                0 => ResultIteratorType(),
                1 => RowIteratorType(),
                2 => CollectionIteratorType(),
                3 => MapIteratorType(),
                4 => TupleIteratorType(),
                5 => UserTypeFieldIteratorType(),
                6 => MetaFieldIteratorType(),
                7 => KeyspaceMetaIteratorType(),
                8 => TableMetaIteratorType(),
                9 => TypeMetaIteratorType(),
                10 => FunctionMetaIteratorType(),
                11 => AggregateMetaIteratorType(),
                12 => ColumnMetaIteratorType(),
                13 => IndexMetaIteratorType(),
                14 => MaterializedViewMetaIteratorType() )

abstract type ValueType end
struct CustomValueType <: ValueType end
struct AsciiValueType <: ValueType end
struct BigintValueType <: ValueType end
struct BlobValueType <: ValueType end
struct BooleanValueType <: ValueType end
struct CounterValueType <: ValueType end
struct DecimalValueType <: ValueType end
struct DoubleValueType <: ValueType end
struct FloatValueType <: ValueType end
struct IntValueType <: ValueType end
struct TextValueType <: ValueType end
struct TimestampValueType <: ValueType end
struct UuidValueType <: ValueType end
struct VarcharValueType <: ValueType end
struct VarintValueType <: ValueType end
struct TimeuuidValueType <: ValueType end
struct InetValueType <: ValueType end
struct DateValueType <: ValueType end
struct TimeValueType <: ValueType end
struct SmallIntValueType <: ValueType end
struct TinyIntValueType <: ValueType end
struct DurationValueType <: ValueType end
struct ListValueType <: ValueType end
struct MapValueType <: ValueType end
struct SetValueType <: ValueType end
struct UdtValueType <: ValueType end
struct TupleValueType <: ValueType end

ValueTypes = Dict{Cint, ValueType}(
                Cint(0x0000) => CustomValueType(),
                Cint(0x0001) => AsciiValueType(),
                Cint(0x0002) => BigintValueType(),
                Cint(0x0003) => BlobValueType(),
                Cint(0x0004) => BlobValueType(),
                Cint(0x0005) => CounterValueType(),
                Cint(0x0006) => DecimalValueType(),
                Cint(0x0007) => DoubleValueType(),
                Cint(0x0008) => FloatValueType(),
                Cint(0x0009) => IntValueType(),
                Cint(0x000A) => TextValueType(),
                Cint(0x000B) => TimestampValueType(),
                Cint(0x000C) => UuidValueType(),
                Cint(0x000D) => VarcharValueType(),
                Cint(0x000E) => VarintValueType(),
                Cint(0x000F) => TimeuuidValueType(),
                Cint(0x0010) => InetValueType(),
                Cint(0x0011) => DateValueType(),
                Cint(0x0012) => TimeValueType(),
                Cint(0x0013) => SmallIntValueType(),
                Cint(0x0014) => TinyIntValueType(),
                Cint(0x0015) => DurationValueType(),
                Cint(0x0020) => ListValueType(),
                Cint(0x0021) => MapValueType(),
                Cint(0x0022) => SetValueType(),
                Cint(0x0030) => UdtValueType(),
                Cint(0x0031) => TupleValueType() )

#=
const ValueTypeMap = Dict{ValueType, DataType}(
                VALUE_TYPE_ASCII => String,
                VALUE_TYPE_BIGINT => Int64,
                VALUE_TYPE_BLOB => Array{UInt8, 1},
                VALUE_TYPE_BOOLEAN => Bool,
                VALUE_TYPE_COUNTER => Cint,
                VALUE_TYPE_DOUBLE => Float64,
                VALUE_TYPE_FLOAT => Float32,
                VALUE_TYPE_INT => Cint,
                VALUE_TYPE_TEXT => String,
                #VALUE_TYPE_TIMESTAMP = Cint(0x000B),
                #VALUE_TYPE_UUID = Cint(0x000C),
                VALUE_TYPE_VARCHAR => String
                #VALUE_TYPE_VARINT = Cint(0x000E),
                #VALUE_TYPE_TIMEUUID = Cint(0x000F),
                #VALUE_TYPE_INET = Cint(0x0010),
                #VALUE_TYPE_DATE = Cint(0x0011),
                #VALUE_TYPE_TIME = Cint(0x0012),
                #VALUE_TYPE_SMALL_INT = Cint(0x0013),
                #VALUE_TYPE_TINY_INT = Cint,
                #VALUE_TYPE_DURATION = Cint(0x0015),
                #VALUE_TYPE_LIST = Cint(0x0020),
                #VALUE_TYPE_MAP = Cint(0x0021),
                #VALUE_TYPE_SET = Cint(0x0022),
                #VALUE_TYPE_UDT = Cint(0x0030),
                #VALUE_TYPE_TUPLE = Cint(0x0031) )
                )
=#

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
