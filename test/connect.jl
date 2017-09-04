
@testset "Connect only" begin
    driver = Cass.Driver(contact_points)
    rc = Cass.connect(driver)
    @test rc == Cass.OK
    Cass.free(driver)
end
