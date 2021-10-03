struct BackPath
    sides::NTuple{2, HorizonSide}
    path::Vector{Int}
    function BackPath(robot, sides::NTuple{2, HorizonSide})
        local path=Int[]
        while !isborder(robot, sides[1]) || !isborder(robot, sides[2])
            for s in side
                push!(path, movements!(robot, s))
            end
        end
        return new(reverse(inverse.(sides)), path)
    end
end

function back(robot, backpath::BackPath)
    i = 1
    for n in backpath.path
        movemets!(robot, backpath.sides[i])
        i = i % 2 + 1
    end

#------------

back_path = BackPath(r, (Sud, West))