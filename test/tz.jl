
function my_timezone(dt::DateTime)
     ut = Int(floor(Dates.datetime2unix(dt)))
     Libc.strftime("%z", ut)
end

# Usage
println( my_timezone(Dates.now()) )
