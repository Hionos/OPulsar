% Parameters for "Attiude_Estimator" component

Immobility_Threshold = 0.2; % rad/s
Immobility_Time_Confirmation = 0.5; % seconds
Gravity_Err_Threshold = 0.01; 

FILTER_KP = 1; 
FILTER_KI = 0.1; 
Q_EST_INIT = [0 0 0 1];

te = 0.01; %Sampling Period