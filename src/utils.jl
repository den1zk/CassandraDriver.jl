error_desc(rc::Cint) = unsafe_string( ccall((:cass_error_desc, libcass, Cstring, (Cint,), rc) )

function value_get_int32(row::Ptr{Void}, idx::Int)
    val = Ref{Int32}(0)
    ref = ccall((:cass_row_get_column, "libcassandra"), Ptr{Void}, (Ptr{Void}, Cint), row, idx)
    rc = ccall((:cass_value_get_int32, "libcassandra"), Cint, (Ptr{Void}, Ptr{Int32}), ref, val)
    val.x
end

function value_get_bool(row::Ptr{Void}, idx::Int)
    val = Ref{Cint}(0)
    ref = ccall((:cass_row_get_column, "libcassandra"), Ptr{Void}, (Ptr{Void}, Cint), row, idx)
    rc = ccall((:cass_value_get_bool, "libcassandra"), Cint, (Ptr{Void}, Ptr{Cint}), ref, val)
    val.x == 1
end

function value_get_float64(row::Ptr{Void}, idx::Int)
    val = Ref{Float64}(0.0)
    ref = ccall((:cass_row_get_column, "libcassandra"), Ptr{Void}, (Ptr{Void}, Cint), row, 1)
    rc = ccall((:cass_value_get_double, "libcassandra"), Cint, (Ptr{Void}, Ptr{Float64}), ref, val)
    val.x
end

function value_get_string(row::Ptr{Void}, idx::Int, buffer_size = 128)
    val = Array{UInt8}(buffer_size)
    ptr_val = Ref{Array{UInt8}}(val)
    len = Ref{Csize_t}(0)
    ref = ccall((:cass_row_get_column, "libcassandra"), Ptr{Void}, (Ptr{Void}, Cint), row, idx)
    rc = ccall((:cass_value_get_string, "libcassandra"), Cint,
            (Ptr{Void}, Ptr{Void}, Ptr{Csize_t}), ref, ptr_val, len)
    val = ptr_val.x
    val[len.x + 1] = 0
    unsafe_string(pointer(val))
end
