
using Base.Iterators: Stateful, take

struct Board
    wins
end

function cover!(b::Board, x...)
    for s in b.wins
        setdiff!(s, x)
    end
end

function complete(b::Board)
    any(isempty.(b.wins))
end


function readgame()
    splitter(s, dlm) = [(parse(UInt8, v) for v in split(s, dlm))...]
    splitter(s) = [(parse(UInt8, v) for v in split(s))...]
    lines = Stateful(eachline("input4.txt"))
    draws = splitter(take(lines, 1)..., ",")
    boards = []
    while !isempty(lines)
        collect(take(lines, 1)...)
        els = [splitter(line) for line in take(lines, 5)]
        b = Board([Set.(els); Set.(zip(els...))])
        push!(boards, b)
    end
    draws, boards
end


b, v = let
    draws, boards = readgame()
    winner = nothing
    won_on = nothing
    for d in draws
        for b in boards
            cover!(b, d)
            complete(b) && (winner = b; won_on = d)
        end
        isnothing(winner) || break
    end
    something.((winner, won_on))
end

b, v = let
    draws, boards = readgame()
    loser = nothing
    done_on = nothing
    for d in draws
        for b in boards
            cover!(b, d)
            (length(boards) == 1) && complete(b) && (loser = b; done_on = d)
        end
        boards = filter(!complete, boards)
        (length(boards) == 0) && break
    end
    something.((loser, done_on))
end

score = sum(sum.(b.wins)) >> 1
Int(score*v)




