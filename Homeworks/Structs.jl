
include("Functions.jl")

abstract type AbstractRobot 
end

import HorizonSideRobots: move!, isborder, putmarker!, ismarker

move!(robot::AbstractRobot, side::HorizonSide) = HorizonSideRobots.move!(get(robot), side)
isborder(robot::AbstractRobot,  side::HorizonSide) = HorizonSideRobots.isborder(get(robot), side)
putmarker!(robot::AbstractRobot) = HorizonSideRobots.putmarker!(get(robot))
ismarker(robot::AbstractRobot) = HorizonSideRobots.ismarker(get(robot))
get(robot::AbstractRobot) = nothing

function snake(robot::AbstractRobot)
    side = Ost
    movements!(robot,side)
    while !isborder(robot, Nord)
        move!(robot,Nord)
        side = reverse_side(side)
        movements!(robot,side)
    end
end

#-------------------------------------------

mutable struct ChessRobot <: AbstractRobot
    robot::Robot
    flag::Int
    ChessRobot(robot::Robot)=new(robot, 1)
end

function move!(robot::ChessRobot, side::HorizonSide)
    move!(get(robot), side)
    robot.flag = (robot.flag - 1) * (-1) # 1 -> 0, 0 -> 1
    if robot.flag == 1
        putmarker!(robot)
    end
end

function movements!(robot::ChessRobot, side::HorizonSide)
    while !isborder(robot, side)
        move!(robot, side)
    end
end

get(robot::ChessRobot) = robot.robot

#-------------------------------------------

mutable struct Coord
    x::Int
    y::Int
    Coord() = new(0,0)
    Coord(x::Int,y::Int) = new(x,y)
end

function move!(coord::Coord, side::HorizonSide)
    if side==Nord
        coord.y += 1
    elseif side==Sud
        coord.y -= 1
    elseif side==Ost
        coord.x += 1
    else
        coord.x -= 1
    end
end

get_coord(coord::Coord) = (coord.x, coord.y)

#-------------------------------------------

mutable struct CoordRobot <: AbstractRobot
    robot::Robot
    coord::Coord
    CoordRobot(r,(x, y))=new(r,Coord(0,0))
    CoordRobot(r)=new(r,Coord())
end

get(robot::CoordRobot) = robot.robot

function move!(robot::CoordRobot, side::HorizonSide)
    move!(get(robot), side)
    move!(robot.coord, side)
end

#-------------------------------------------

abstract type AbstractCoordRobot <: AbstractRobot
end

function move!(robot::AbstractCoordRobot, side::HorizonSide)
    move!(get(robot), side)
    move!(robot.coord, side)
end

#------------------------------

struct CounterMarkersRobot <: AbstractCoordRobot 
    robot::Robot
    num_markers::Int
    CounterMarkersRobot(robot::Robot)=new(robot, if ismarker(robot) 1 else 0 end)
end

get(robot::CounterMarkersRobot)=robot.robot

function move!(robot::CounterMarkersRobot, side::HorizonSide)
    move!(get(robot), side)
    if ismarker(robot)
        robot.num_markers += 1
    end
end

#------------------------------

abstract type AbstractBorderRobot <: AbstractRobot end

try_move!(robot::AbstractBorderRobot,side::HorizonSide) = try_move!(get(robot), side)

function movements!(robot::AbstractBorderRobot, side::HorizonSide)
    n = 0
    while try_move!(robot,side)
        n += 1
    end
    return n
end

function movements!(robot::AbstractBorderRobot, side::HorizonSide, num_steps::Integer)
    for _ in 1:num_steps
        try_move!(robot,side)
    end
end

function snake(robot::AbstractBorderRobot)
    side = Ost
    movements!(robot,side)
    while !isborder(robot, Nord)
        try_move!(robot,Nord)
        # putmarker!(robot )
        side = reverse_side(side)
        movements!(robot,side)
    end
end

#------------------------------

struct PutmarkersRobot <: AbstractBorderRobot
    robot::Robot
end

function try_move!(robot::PutmarkersRobot, side::HorizonSide)
    if try_move!(get(robot),side)
        putmarker!(robot)
        return true
    end
    return false
end

get(robot::PutmarkersRobot) = robot.robot

#------------------------------

struct MarkerBorderRobot <: AbstractBorderRobot
    robot::Robot
end

function marker_to_edge!(robot::MarkerBorderRobot, side::HorizonSide)
    path = movements!(robot, side)
    putmarker!(robot)
    rside = reverse_side(side)
    movements!(robot, rside, path)
end

get(robot::MarkerBorderRobot) = robot.robot

#------------------------------

mutable struct  CountbordersRobot <: AbstractBorderRobot
    robot::Robot
    state::Bool
    count::Int
    border_side::HorizonSide
    CountbordersRobot(r, border_side=Nord) = new(r,0,0, border_side)
end

get(robot::CountbordersRobot) = robot.robot

function try_move!(robot::CountbordersRobot, side::HorizonSide)
    result = try_move!(get(robot), side) 
    if isborder(robot.robot, robot.border_side)
        if robot.state == 0
            robot.state = 1
            robot.count += 1
        end
    else
        robot.state = 0
    end
    return result
end

get_num_borders(robot::CountbordersRobot) = robot.count

#------------------------

abstract type BoundlessRobot <: AbstractRobot end

try_move!(robot::BoundlessRobot,side::HorizonSide) = try_move!(get(robot), side)

function moves!(r::BoundlessRobot, side::HorizonSide, n::Int)
    while (n > 0 && isborder(r, reverse_side(left(side))))
        move!(r, side)
        n -= 1
    end
end

function move_through_hole!(r::BoundlessRobot, side::HorizonSide)
    step = 1
    cur_step = step
    bypass_side = left(side)
    while isborder(r, side)
        moves!(r, bypass_side, cur_step)
        cur_step += step
        bypass_side = reverse_side(bypass_side)
    end
    move!(r, side)
    while isborder(r, bypass_side)
        move!(r, side)
    end
    if cur_step != 1
        for i in 0:div((cur_step + 1), 2)
            move!(r, bypass_side)
        end
    end
end

#------------------------------

struct MarkerBoundlessRobot <: BoundlessRobot
    robot::Robot
end

function movements!(r::MarkerBoundlessRobot, side::HorizonSide, n::Int)
    while (n > 0 && !ismarker(r))
        move_through_hole!(r, side)
        n -= 1
    end
end

function move!(r::MarkerBoundlessRobot, side::HorizonSide)
    if !ismarker(r)
        move!(get(r), side)
    end
end

get(robot::MarkerBoundlessRobot) = robot.robot