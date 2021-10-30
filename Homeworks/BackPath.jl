using HorizonSideRobots

function inverse(side::HorizonSide)
    return HorizonSide((Int(side) + 2) % 4)
end

function movements!(r::Robot, side::HorizonSide)
    n = 0
    while !isborder(r, side)
        move!(r, side)
        n += 1
    end
    return n
end

function movements!(r::Robot, side::HorizonSide, n::Int)
    while n > 0
        move!(r, side)
        n -= 1
    end
end

struct BackPath
    sides::NTuple{2,HorizonSide}
    path::Vector{Int}

    function BackPath(robot, sides::NTuple{2,HorizonSide}=(Sud,West))
        local path = Int[]
        while !isborder(robot,sides[1]) || !isborder(robot,sides[2])
            for s in sides 
                push!(path, movements!(robot, s))
            end
        end
        return new(reverse(inverse.(sides)), reverse(path))
    end
end

function back!(robot, backpath::BackPath)
    i=1
    for n in backpath.path
        movements!(robot, backpath.sides[i], n)
        i = i % 2 + 1
    end
end

#back_path = BackPath(r)
#back!(r, back_path)