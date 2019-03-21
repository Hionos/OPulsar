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

package Alignment_criterion is

   procedure initOutputs (Gravity_Err_OK : out Boolean);

   procedure comp
      (Gravity_Err : Float_Array_3;
       Gravity_Err_OK : out Boolean);

   procedure disable (Gravity_Err_OK : in out Boolean);

   procedure resetOutputs (Gravity_Err_OK : out Boolean);

end Alignment_criterion;
--  @EOF
