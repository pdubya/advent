

abstract type CommandMode end
struct Literal <: CommandMode
end
struct Aimed <: CommandMode
end

struct Commands{M <: CommandMode}
    fname
end

function strip_line(::Commands{Literal}, s)
    d, m = split(s)
    v = parse(Int, m)
    d == "forward" ? (0, v, 0) : (d == "up" ? (-v, 0, 0) : (v, 0, 0))
end

function strip_line(::Commands{Aimed}, s)
    d, m = split(s)
    v = parse(Int, m)
    d == "forward" ? (0, v, 0) : (d == "up" ? (0, 0, -v) : (0, 0, v))
end

function position(u::Commands)
    y, x, a = 0, 0, 0
    updater = 
    for (dy, dx, da) in (strip_line(u, s) for s in eachline(u.fname))
        a += da
        y += dy + a*dx
        x += dx
    end
    y, x
end

u1 = Commands{Literal}("input2.txt")
u2 = Commands{Aimed}("input2.txt")
@time position(u1)
println(prod(position(u1)))
println(prod(position(u2)))
