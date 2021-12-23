using HorizonSideRobots
include("BackPath.jl")
include("Structs.jl")

function mark_field(r::Robot)
    back_path = BackPath(r)
    putmarkers_robot=PutmarkersRobot(r)
    putmarker!(putmarkers_robot)
    snake(putmarkers_robot)
    movements!(r,West)
    movements!(r,Sud)
    back!(r, back_path)
end
