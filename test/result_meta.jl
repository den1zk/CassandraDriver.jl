
@testset "Meta data of a query" begin
    driver = Cass.Driver(contact_points)
    rc = Cass.connect(driver)
    @test rc == Cass.OK
    future = Cass.execute(driver, "SELECT * FROM system.size_estimates")
    result = fetch(future)
    @test result.row_count > 0
    @test length(result.fields) > 0
    println(result.fields)
    Cass.free(result)
    Cass.free(future)
    Cass.free(driver)
end
