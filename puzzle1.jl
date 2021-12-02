
using DataStructures: CircularBuffer
using Base.Iterators: Stateful, take

struct Readings
    fname
end

function count_increases(u::Readings, n::Int)
    @assert n > 0
    incs = zero(n)
    r = Stateful((parse(Int, s) for s in eachline(u.fname)))
    b = CircularBuffer{Int}(n)
    append!(b, collect(take(r, n)))

    c0 = c1 = sum(b)
    for v in r
        c1 += v - b[1]
        (c1 > c0) && (incs += 1)
        c0 = c1
        push!(b, v)
    end
    incs
end

u = Readings("input1.txt")
@time count_increases(u, 3)
