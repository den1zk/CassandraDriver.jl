struct Row
    ptr::Ptr{Void}
end

get_column(r::Row, idx::Int) = ccall((:ptr_get_column, libcass),
            Ptr{Void}, (Ptr{Void}, Cint), r.ptr, idx)

function get_int32(r::Row, idx::Int)
    val = Ref{Int32}(0)
    #ref = ccall((:ptr_get_column, libcass), Ptr{Void}, (Ptr{Void}, Cint), r.ptr, idx)
    col = get_column(r, idx)
    rc = ccall((:cass_value_get_int32, libcass), Cint, (Ptr{Void}, Ptr{Int32}), col, val)
    val.x
end

function get_bool(r::Row, idx::Int)
    val = Ref{Cint}(0)
    #ref = ccall((:ptr_get_column, libcass), Ptr{Void}, (Ptr{Void}, Cint), r.ptr, idx)
    col = get_column(r, idx)
    rc = ccall((:cass_value_get_bool, "libcassandra"), Cint, (Ptr{Void}, Ptr{Cint}), col, val)
    val.x == 1
end

function get_float64(r::Row, idx::Int)
    val = Ref{Float64}(0.0)
    #ref = ccall((:ptr_get_column, libcass), Ptr{Void}, (Ptr{Void}, Cint), r.ptr, idx)
    col = get_column(r, idx)
    rc = ccall((:cass_value_get_double, libcass), Cint, (Ptr{Void}, Ptr{Float64}), col, val)
    val.x
end

function get_string(row::Ptr{Void}, idx::Int, buffer_size = 128)
    val = Array{UInt8}(buffer_size)
    ptr_val = Ref{Array{UInt8}}(val)
    len = Ref{Csize_t}(0)
    #ref = ccall((:ptr_get_column, libcass), Ptr{Void}, (Ptr{Void}, Cint), r.ptr, idx)
    col = get_column(r, idx)
    rc = ccall((:cass_value_get_string, libcass), Cint,
            (Ptr{Void}, Ptr{Void}, Ptr{Csize_t}), col, ptr_val, len)
    val = ptr_val.x
    val[len.x + 1] = 0
    unsafe_string(pointer(val))
end
