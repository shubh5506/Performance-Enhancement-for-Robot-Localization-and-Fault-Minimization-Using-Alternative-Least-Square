%Testing Random Waypoint mobility model.
clear all;clc;close all;

s_input = struct('V_POSITION_X_INTERVAL',[-50 50],...%(m)
                 'V_POSITION_Y_INTERVAL',[-1 50],...%(m)
                 'V_SPEED_INTERVAL',[0.2 1],...%(m/s)
                 'V_PAUSE_INTERVAL',[4 5],...%pause time (s)
                 'V_WALK_INTERVAL',[4.00 6.00],...%walk time (s)
                 'V_DIRECTION_INTERVAL',[-360 360],...%(degrees)
                 'SIMULATION_TIME',100,...%(s)
                 'NB_NODES',1);
s_mobility = MobileRobot(s_input);

timeStep = 0.01;%(s)
RobotDesign(s_mobility,s_input,timeStep);