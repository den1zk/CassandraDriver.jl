struct Session
    cass_session::Ptr{Void}
end

session_new() = Session( ccall((:cass_session_new, libcass), Ptr{Void},  (), ) )

free(s::Session) = ccall((:cass_session_free, libcass), Void, (Ptr{Void},), s.cass_session)

connect(s::Session, c::Cluster) = Future_C(
        ccall((:cass_session_connect, libcass), Ptr{Void},
        (Ptr{Void}, Ptr{Void}), s.cass_session, c.cass_cluster) )
