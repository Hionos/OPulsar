--  Copyright (C) Your Company Name
--
--  @generated with QGen Code Generator 19.0w (20180218)
--  Command line arguments: model/Flight_Control.mdl
--    --clean
--    --language ada
--    --typing model/Flight_Control_types.txt
--    --matlab model/Flight_Control_parameters.m
--    --output ./generated

pragma Style_Checks ("M999");  --  ignore long lines

package Flight_Control_params is
   Kp_roll_angle : constant Long_Float := 4.0;
   Kp_Roll : constant Long_Float := 3.84;
   Kd_Roll : constant Long_Float := 0.037;
   Ki_Roll : constant Long_Float := 5.0;
   Kb_Roll : constant Long_Float := 4.0;
   Kp_pitch_angle : constant Long_Float := 4.0;
   Kp_Pitch : constant Long_Float := 3.84;
   Kd_Pitch : constant Long_Float := 0.037;
   Ki_Pitch : constant Long_Float := 5.0;
   Kb_Pitch : constant Long_Float := 4.0;
   Kp_Yaw : constant Long_Float := 8.16;
   Kd_Yaw : constant Long_Float := 0.1;
   Ki_Yaw : constant Long_Float := 5.0;
   Kb_Yaw : constant Long_Float := 4.0;
   te : constant Long_Float := 0.01;

end Flight_Control_params;
--  @EOF
