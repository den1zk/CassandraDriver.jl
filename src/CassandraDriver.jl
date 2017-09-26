module Cass
const libcass = "libcassandra"
Libdl.dlopen(libcass)

import Base.Random.UUID

const OK = Cint(0)
include("constants.jl")
include("cluster.jl")
include("result.jl" )
include("row.jl")
include("iterator.jl")
include("future.jl")
include("session.jl")
include("statement.jl")


export OK, Driver, connect, free

type Driver
    cluster::Cluster
    session::Session
    function Driver(contact_points::String)
        cluster = cluster_new(contact_points)
        session = session_new()
        new(cluster, session)
    end
end

function connect(drv::Driver)
    connect_future = connect(drv.session, drv.cluster)
    wait(connect_future)

    rc = error_code(connect_future)
    if rc != OK
        error(error_desc(rc))
    end
    free(connect_future)
    rc
end

function free(drv::Driver)
    free(drv.session)
    free(drv.cluster)
end

function execute(d::Driver, s::Statement)
    future = ccall((:cass_session_execute, libcass), Ptr{Void},
            (Ptr{Void}, Ptr{Void}), d.session.cass_session, s.ptr)
    free(s)
    Future_C(future)
end

function execute(d::Driver, query::String)
    stmt = Statement(query) |> build
    execute(d, stmt)
end

end  # module Cass


module CassandraDriver

using Cass

end  # module CassandraDriver
