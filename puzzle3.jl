

function read_ints()
    [(parse(UInt16, "0b"*u) for u in eachline("input3.txt"))...]
end

function splitbit(z, i)
    x = 1 << (i - 1)
    q = (z .& x) .> 0
    (q, x)
end

majority(z, q) = (length(view(z, q)) << 1) >= length(z)
minority(z, q) = (length(view(z, q)) << 1) < length(z)

function gamma_epsilon(z, n = 12)
    γ = ϵ = 0
    for i in 1:12
        q, x = splitbit(z, i)
        g, e = majority(z, q) ? (x, zero(x)) : (zero(x), x)
        γ += g
        ϵ += e
    end
    (γ, ϵ)
end

function decode(z, n = 12; element = "oxygen")
    r = view(z, :)
    i = n
    selector = element == "oxygen" ? majority : minority
    while length(r) > 1
        q, _ = splitbit(r, i)
        r = selector(r, q) ? view(r, q) : view(r, .~q)
        i -= 1
    end
    1*only(r)
end


z = read_ints()
println(gamma_epsilon(z))
decode(z; element = "oxygen"), decode(z; element = "co2")

