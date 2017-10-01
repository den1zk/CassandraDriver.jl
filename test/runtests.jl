using Base.Test
include("../src/CassandraDriver.jl")

const contact_points = "127.0.0.1"

include("connect.jl")
include("statement.jl")
include("result_meta.jl")
include("result_iter.jl")
include("collect.jl")
