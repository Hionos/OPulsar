--  Copyright (C) Your Company Name
--
--  @generated with QGen Code Generator 19.0w (20180218)
--  Command line arguments: attitude_estimator/model/Attitude_Estimator.mdl
--    --clean
--    --language ada
--    --typing attitude_estimator/model/Attitude_Estimator_types.txt
--    --matlab attitude_estimator/model/Attitude_Estimator_parameters.m
--    --output attitude_estimator/generated

pragma Style_Checks ("M999");  --  ignore long lines

with Attitude_Estimator_types; use Attitude_Estimator_types;

package Attitude_Estimator_params is
   Immobility_Threshold : constant Long_Float := 0.2;
   Immobility_Time_Confirmation : constant Long_Float := 0.5;
   Gravity_Err_Threshold : constant Long_Float := 0.01;
   FILTER_KP : constant Long_Float := 1.0;
   FILTER_KI : constant Long_Float := 0.1;
   Q_EST_INIT : constant Long_Float_Array_4 := 
(1 => 0.0, 2 => 0.0, 3 => 0.0, 4 => 1.0);
   te : constant Long_Float := 0.01;

end Attitude_Estimator_params;
--  @EOF
