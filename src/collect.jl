
function Base.collect(r::Result)
    names = [Symbol(x[1]) for x in r.fields]
    types = [julia_type(x[2]) for x in r.fields]
    df = DataFrame(types, names, 0)
    for row in iterate(r)
        push!(df, row.values)
    end
    df
end
