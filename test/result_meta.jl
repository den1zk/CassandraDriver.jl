
@testset "Meta data of a query" begin
    driver = Cass.Driver(contact_points)
    rc = Cass.connect(driver)
    @test rc == Cass.OK
    future = Cass.execute(driver, "SELECT * FROM system.size_estimates")
    result = Cass.fetch(future)
    @test result.row_count > 0
    @test length(result.fields) > 0
    println(result.fields)
    it = Cass.Iterator_C(result.cass_result)
    println(it.typ)
    @test it.typ isa Cass.CollectionIteratorType
    Cass.free(it)
    Cass.free(future)
    Cass.free(driver)
end
