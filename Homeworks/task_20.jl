using HorizonSideRobots
include("BackPath.jl")
include("Structs.jl")

function count_borders!(robot::Robot)
    to_sud_west_corner = BackPath(r)
    robot = CountbordersRobot(robot)
    snake(robot)
    return get_num_borders(robot) - 1
end
