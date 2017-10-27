%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Example which computes effective diffusvity
% tensor of an SVE. Comutations are based on
% stationary simmulations.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all
clc

addpath([pwd,'/classFiles'])
addpath([pwd,'/misc'])
warning('off','all')


% % create object
SVE = SVEclass;

% % set properties
SVE.nx                = 60;
SVE.realizationNumber = 2;
SVE.Lbox              = 4;
SVE.aggFrac           = 0.1;

% % input for 'generateSVE()'
M = dlmread('sieve-input.txt',',');
ballastRadii = M(:,1)/2/10; % [20 8 4 2]/2/10;   % Radius in [cm]. From http://www.sciencedirect.com/science/article/pii/S0168874X05001563
gravelSieve  = M(:,2)/sum(M(:,2)); % [.25 .25 .35 .15]; % Distribution in fraction. sum(gravelSieve) should be 1.0
numberOfGravel = 10;            % ballast particles are distributed inside domainFactor*LBox


% % set SVE boundary type
% % 1 = physical boundary where no aggregates cut the boundary surface
% % default value is 0 if not set by user
% SVE.boundary.x.back  = 1;
% SVE.boundary.x.front = 1;
% SVE.boundary.y.back  = 1;
% SVE.boundary.y.front = 1;
% SVE.boundary.z.back  = 1;
% SVE.boundary.z.front = 1;


% % apply methods
% SVE.setPath(); % uses current working directory
SVE.setPath('E:\MATLAB'); % if you want files to be saved elsewhere
SVE.generateSVE(ballastRadii,gravelSieve,numberOfGravel);
SVE.meshSVE();
% SVE.writeTopology();
SVE.computeEffectiveDiffusivtyTensor();
