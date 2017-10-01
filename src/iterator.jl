
struct Iterator_C{T <: Iterable}
    ptr::Ptr{Void}
    src::T
end

export Iterator_C, free, iterate

function iterator_type(ptr::Ptr{Void})
    t = ccall((:cass_iterator_type, libcass), Cint, (Ptr{Void},), ptr)
    IteratorTypes[t]
end

free(it::Iterator_C) = ccall((:cass_iterator_free, libcass), Void, (Ptr{Void},), it.ptr)

from_result(r::Result) = Iterator_C(
    ccall((:cass_iterator_from_result, libcass), Ptr{Void}, (Ptr{Void},), r.ptr), r )

from_row(r::Row) = Iterator_C(
    ccall((:cass_iterator_from_row, libcass), Ptr{Void}, (Ptr{Void},), r.ptr), r )

iterate(r::Result) = from_result(r)
iterate(r::Row) = from_row(r)

Base.start(it::Iterator_C) = 1

function Base.next(it::Iterator_C, idx)
    current = get_current(it, idx)
    (current, idx + 1)
end

function Base.done(it::Iterator_C, idx)
    rc = ccall((:cass_iterator_next, libcass), Cint, (Ptr{Void},), it.ptr)
    done = rc == 0
    done && free(it)
    done
end

function get_current(r::Iterator_C{Result}, idx)
    ptr = ccall((:cass_iterator_get_row, libcass), Ptr{Void}, (Ptr{Void},), r.ptr)
    Row(ptr, r.src.fields)
end

get_current(r::Iterator_C{Row}, idx) = get_value(r, idx)
