
@testset "Build Statement" begin
    cql = "select * from abc where a=? and b=?"
    s = Cass.Statement(cql) |> Cass.bind() |> Cass.bind(Int8(23)) |> Cass.build
    @test s.ptr isa Ptr
    Cass.free(s)

    cql1 = "select * from abc where a=?"
    s1 = Cass.Statement(cql1) |> Cass.bind(Int16(23)) |> Cass.build
    @test s1.ptr isa Ptr
    Cass.free(s1)

    s1 |> Cass.bind(Int32(23)) |> Cass.build
    @test s1.ptr isa Ptr
    Cass.free(s1)

    s1 |> Cass.bind(UInt32(23)) |> Cass.build
    @test s1.ptr isa Ptr
    Cass.free(s1)

    s1 |> Cass.bind(Int64(23)) |> Cass.build
    @test s1.ptr isa Ptr
    Cass.free(s1)

    s1 |> Cass.bind(Float32(23.8)) |> Cass.build
    @test s1.ptr isa Ptr
    Cass.free(s1)

    s1 |> Cass.bind(23.8) |> Cass.build
    @test s1.ptr isa Ptr
    Cass.free(s1)

    s1 |> Cass.bind(true) |> Cass.build
    @test s1.ptr isa Ptr
    Cass.free(s1)

    s1 |> Cass.bind("test") |> Cass.build
    @test s1.ptr isa Ptr
    Cass.free(s1)

end
