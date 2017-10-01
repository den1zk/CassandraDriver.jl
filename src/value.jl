function get_int32(ptr::Ptr{Void})
    val = Ref{Int32}(0)
    rc = ccall((:cass_value_get_int32, libcass), Cint, (Ptr{Void}, Ptr{Int32}), ptr, val)
    val.x
end

function get_int64(ptr::Ptr{Void})
    val = Ref{Int64}(0)
    rc = ccall((:cass_value_get_int64, libcass), Cint, (Ptr{Void}, Ptr{Int64}), ptr, val)
    val.x
end

function get_bool(ptr::Ptr{Void})
    val = Ref{Cint}(0)
    rc = ccall((:cass_value_get_bool, "libcassandra"), Cint, (Ptr{Void}, Ptr{Cint}), ptr, val)
    val.x == 1
end

function get_float64(ptr::Ptr{Void})
    val = Ref{Float64}(0.0)
    rc = ccall((:cass_value_get_double, libcass), Cint, (Ptr{Void}, Ptr{Float64}), ptr, val)
    val.x
end

function get_string(row::Ptr{Void}, buffer_size = 128)
    val = Array{UInt8}(buffer_size)
    ptr_val = Ref{Array{UInt8}}(val)
    len = Ref{Csize_t}(0)
    rc = ccall((:cass_value_get_string, libcass), Cint,
            (Ptr{Void}, Ptr{Void}, Ptr{Csize_t}), row, ptr_val, len)
    val = ptr_val.x
    val[len.x + 1] = 0
    unsafe_string(pointer(val))
end

get_value(::IntValue, ptr::Ptr{Void}) = get_int32(ptr)
get_value(::BigintValue, ptr::Ptr{Void}) = get_int32(ptr)
get_value(::BooleanValue, ptr::Ptr{Void}) = get_bool(ptr)
get_value(::DoubleValue, ptr::Ptr{Void}) = get_float64(ptr)
get_value(::VarcharValue, ptr::Ptr{Void}, buffer_size = 128) = get_string(ptr, buffer_size)
get_value(::AsciiValue, ptr::Ptr{Void}, buffer_size = 128) = get_string(ptr, buffer_size)
get_value(::TextValue, ptr::Ptr{Void}, buffer_size = 1024) = get_string(ptr, buffer_size)
