
struct Iterator_C{T <: IteratorType}
    ptr::Ptr{Void}
    idx::Int
    typ::T
end

function Iterator_C(ptr::Ptr{Void})
    ti = ccall((:cass_iterator_type, libcass), Cint, (Ptr{Void},), ptr)
    t = IteratorTypes[ti]
    println(t)
    Iterator_C(ptr, 0, t)
end

free(it::Iterator_C) = ccall((:cass_iterator_free, libcass), Void, (Ptr{Void},), it.ptr)



from_result(r::Result) = Iterator_C(
    ccall((:cass_iterator_from_result, libcass), Ptr{Void}, (Ptr{Void},), r.cass_result) )

from_row(r::Row) = Iterator_C(
    ccall((:cass_iterator_from_result, libcass), Ptr{Void}, (Ptr{Void},), r.ptr) )

Base.start(it::Iterator_C) = 0

function Base.next(it::Iterator_C, idx)
    ptr = get_current(it.typ, it.ptr)
    (ptr, idx + 1)
end

function Base.done(it::Iterator_C, idx)
    rc = ccall((:cass_iterator_next, libcass), Cint, (Ptr{Void},), it.ptr)
    rc == 0
end

get_current(::ResultIteratorType, ptr::Ptr{Void}) =
        ccall((:cass_iterator_get_row, libcass), Ptr{Void}, (Ptr{Void},), ptr)

get_current(::RowIteratorType, ptr::Ptr{Void}) =
        ccall((:cass_iterator_get_coluwn, libcass), Ptr{Void}, (Ptr{Void},), ptr)
