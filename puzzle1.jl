
using DataStructures: CircularBuffer
using Base.Iterators: Stateful, take

struct Readings
    fname
end

function Base.iterate(r::Readings, h)
    u = readline(h)
    parse(Int, u), eof(h) ? nothing : h
end

Base.iterate(r::Readings, ::Nothing) = nothing
Base.length(r::Readings) = countlines(r.fname)

function Base.iterate(r::Readings)
    iterate(r, open(r.fname))
end

incs = let incs = 0
    r = Stateful(Readings("input1.txt"))
    b = CircularBuffer{typeof(incs)}(3)
    append!(b, collect(take(r, 3)))

    c0 = c1 = sum(b)
    for v in r
        c1 += v - b[1]
        (c1 > c0) && (incs += 1)
        c0 = c1
        push!(b, v)
    end
    println(incs)
    incs
end
println(incs)
