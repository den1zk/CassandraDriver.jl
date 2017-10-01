struct Result <: Iterable
    ptr::Ptr{Void}
    row_count::Int
    fields::Fields
    typ::IteratorType
    function Result(r::Ptr{Void})
        cnt, flds = meta(r)
        new(r, cnt, flds, ResultIteratorType())
    end
end

export Result, free

free(r::Result) = ccall((:cass_result_free, libcass), Void, (Ptr{Void},), r.ptr)

function meta(r::Ptr{Void})
    row_count = ccall((:cass_result_row_count, libcass), Cint, (Ptr{Void},), r)
    n = ccall((:cass_result_column_count, libcass), Cint, (Ptr{Void},), r)
    fields = Array{Tuple{String, ValueType}}(n)
    for i=1:n
        local name = get_column_name(r, i-1)
        local typ = get_column_type(r, i-1)
        fields[i] = (name, typ)
    end
    (row_count, fields)
end

function get_column_name(r::Ptr{Void}, idx::Int, buffer_size = 128)
    val = Array{UInt8}(buffer_size)
    ptr_val = Ref{Array{UInt8}}(val)
    len = Ref{Csize_t}(0)
    rc = ccall((:cass_result_column_name, libcass), Cint,
            (Ptr{Void}, Cint, Ptr{Void}, Ptr{Csize_t}), r, idx, ptr_val, len)
    val = ptr_val.x
    val[len.x + 1] = 0
    unsafe_string(pointer(val))
end

function get_column_type(r::Ptr{Void}, idx::Int)
    itype = ccall((:cass_result_column_type, libcass), Cint, (Ptr{Void}, Cint), r, idx)
    get(ValueTypes, itype, Any)
end
