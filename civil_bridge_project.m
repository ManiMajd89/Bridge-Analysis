% Bridge Analysis and Factor of Safety Calculation
% CIV102 Course - Civil Engineering Bridge Project
% Authors: Mani Majd, Charlie Martinez, Shreyaj Pal Choundry 
% Date: November 2024

% Description:
% This MATLAB script performs structural analysis for a bridge subjected 
% to train loading. It calculates the shear force diagram (SFD), bending 
% moment diagram (BMD), and determines the structural properties and 
% factors of safety (FOS) for various failure modes.

%% Initialize Parameters
L = 1200; % Length of bridge in mm
n = 1200; % Number of 1 mm segments
P = 400; % Total weight of the train [N]
x = linspace(0, L, n+1); % x-axis discretization

%% SFD and BMD under Train Loading
x_train = [0 176 340 516 680 856]; % Train Load Locations (relative to train start)
P_train = ones(1, length(x_train)) * P / length(x_train); % Equal distribution
n_train = 345; % Number of discrete train positions
SFDi = zeros(n_train, n+1); % Initialize SFD matrix
BMDi = zeros(n_train, n+1); % Initialize BMD matrix

% Reaction Forces and Shear/Bending Calculation
for i = 1:n_train
    ForceBy = sum(P_train .* (x_train + i - 1)) / L; % Right reaction
    ForceAy = P - ForceBy; % Left reaction
    
    % Shear Force Diagram (SFD) calculation
    for j = 1:length(x)
        SFDi(i, j) = ForceAy; % Start with left reaction
        for k = 1:length(x_train)
            if j >= i + x_train(k)
                SFDi(i, j) = SFDi(i, j) - P_train(k);
            end
        end
    end
    
    % Bending Moment Diagram (BMD) calculation
    BMDi(i, :) = cumsum(SFDi(i, :) * (L / n)); % Bending moment from shear
end

% Envelope Calculation
SFD = max(abs(SFDi)); % Shear force envelope
BMD = max(abs(BMDi)); % Bending moment envelope

%% Structural Properties and FOS Calculations
% Beam dimensions
top_flange_base = 100;
top_flange_height = 1.27;
glue_tab_thickness = 5 * 2;
glue_tab_height = 1.27;
web_thickness = 1.27 * 2;
web_height = 75 - top_flange_height;
bottom_flange_base = 80;
bottom_flange_height = 1.27;
spacing_of_diaphragms = 400;

% Centroid and Inertia
top_flange_area = top_flange_base * top_flange_height;
glue_tab_area = glue_tab_thickness * glue_tab_height;
web_area = web_thickness * web_height;
bottom_flange_area = bottom_flange_base * bottom_flange_height;

total_area = top_flange_area + glue_tab_area + web_area + bottom_flange_area;

top_flange_centroid = web_height + bottom_flange_height + top_flange_height / 2;
glue_tab_centroid = web_height + bottom_flange_height - glue_tab_height / 2;
web_centroid = web_height / 2 + bottom_flange_height;
bottom_flange_centroid = bottom_flange_height / 2;

centroid = (top_flange_area * top_flange_centroid + ...
    glue_tab_area * glue_tab_centroid + ...
    web_area * web_centroid + ...
    bottom_flange_area * bottom_flange_centroid) / total_area;

inertia = ...
    (top_flange_base * top_flange_height^3 / 12) + top_flange_area * (top_flange_centroid - centroid)^2 + ...
    (glue_tab_thickness * glue_tab_height^3 / 12) + glue_tab_area * (glue_tab_centroid - centroid)^2 + ...
    (web_thickness * web_height^3 / 12) + web_area * (web_centroid - centroid)^2 + ...
    (bottom_flange_base * bottom_flange_height^3 / 12) + bottom_flange_area * (bottom_flange_centroid - centroid)^2;

% Stress Calculations
Compressive_stress = (max(BMD) * (web_height + bottom_flange_height + top_flange_height - centroid) * 1e3) / inertia;
Tensile_stress = (max(BMD) * centroid * 1e3) / inertia;

Qcent = web_thickness * (centroid - bottom_flange_height) * (centroid - bottom_flange_height / 2);
Shear_stress_centre = max(SFD) * Qcent / (inertia * web_thickness);

Qglue = top_flange_base * top_flange_height * (web_height + bottom_flange_height + top_flange_height / 2 - centroid);
Shear_stress_glue = max(SFD) * Qglue / (inertia * (web_thickness + glue_tab_thickness));

%% Factor of Safety Calculations
FOS_Tension = 30 / Tensile_stress;
FOS_Compression = 6 / Compressive_stress;
FOS_Shear = 4 / Shear_stress_centre;
FOS_Glue = 2 / Shear_stress_glue;

%% Plotting
% Bending Moment Diagram
figure;
plot(x, BMD, 'b', 'LineWidth', 1.5);
title('Bending Moment Diagram');
xlabel('Bridge Length (mm)');
ylabel('Bending Moment (N·m)');
grid on;

% Shear Force Diagram
figure;
plot(x, SFD, 'r', 'LineWidth', 1.5);
title('Shear Force Diagram');
xlabel('Bridge Length (mm)');
ylabel('Shear Force (N)');
grid on;