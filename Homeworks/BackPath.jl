using HorizonSideRobots
include("Functions.jl")

struct BackPath
    sides::NTuple{2,HorizonSide}
    path::Vector{Int}

    function BackPath(robot, sides::NTuple{2,HorizonSide}=(Sud,West))
        local path = Int[]
        while !isborder(robot,sides[1]) || !isborder(robot,sides[2])
            for s in sides 
                push!(path, steps_to_border!(robot, s))
            end
        end
        return new(reverse(reverse_side.(sides)), reverse(path))
    end
end

function back!(robot, backpath::BackPath)
    i=1
    for n in backpath.path
        movements!(robot, backpath.sides[i], n)
        i = i % 2 + 1
    end
end

num_steps(back_path::BackPath) = sum(back_path.path)

#back_path = BackPath(r)
#back!(r, back_path)