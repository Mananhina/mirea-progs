using HorizonSideRobots
include("BackPath.jl")

function left(side::HorizonSide)
    return(HorizonSide((Int(side) + 1) % 4))
end

function try_move!(r::Robot, side::HorizonSide)
    n = 0
    ort_side = left(side)
    while isborder(r, side)
        movements!(r, ort_side, n)
        n += 1
        ort_side = inverse(ort_side)
    end
    move!(r, side)
    movements!(r, ort_side, div(n+1, 2))
end

function movements!(r::Robot, side::HorizonSide, n::Int)
    while (n > 0 && !ismarker(r))
        try_move!(r, side)
        n -= 1
    end
end

function find_marker(r::Robot)
    i = 3
    keep_const = 0
    counter = 0
    while !ismarker(r)
        movements!(r, HorizonSide(i % 4), counter + keep_const)
        i += 1
        keep_const = 1 - 1 * keep_const
        counter += keep_const
    end
end
