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
with Interfaces; use Interfaces;

package Attitude_Estimator is

   procedure init;

   procedure initStates;

   procedure initOutputs;

   procedure comp
      (Imu_Acc_Increments : Float_Array_3;
       Imu_Gyro_Increments : Float_Array_3;
       Imu_Status : Unsigned_8;
       Attitude : out Float_Array_5;
       Navigation_Reference_Status : out Unsigned_8);

   procedure disable;

end Attitude_Estimator;
--  @EOF
