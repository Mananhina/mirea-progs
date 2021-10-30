using HorizonSideRobots

function movements!(r::Robot, side::HorizonSide, n::Int)
    while (n > 0 && !ismarker(r))
        move!(r, side)
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
