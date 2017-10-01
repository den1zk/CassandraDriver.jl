struct Session
    ptr::Ptr{Void}
    function Session()
        new( ccall((:cass_session_new, libcass), Ptr{Void},  (), ) )
    end
end

export Session, free, connect

free(s::Session) = ccall((:cass_session_free, libcass), Void, (Ptr{Void},), s.ptr)

connect(s::Session, c::Cluster) = Future_C(
        ccall((:cass_session_connect, libcass), Ptr{Void},
        (Ptr{Void}, Ptr{Void}), s.ptr, c.ptr) )
