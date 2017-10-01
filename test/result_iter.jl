
@testset "Query result iteration" begin
    driver = Cass.Driver(contact_points)
    rc = Cass.connect(driver)
    @test rc == Cass.OK
    future = Cass.execute(driver, "SELECT * FROM system.size_estimates")
    result = Cass.fetch(future)
    @test result.row_count > 0
    @test length(result.fields) > 0
    for row in Cass.from_result(result)
        @test length(row.fields) == length(row.values)
        #println(row.values)
    end
    Cass.free(result)
    Cass.free(future)
    Cass.free(driver)
end
