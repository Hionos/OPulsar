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

with Attitude_Estimator_params; use Attitude_Estimator_params;
with Qgen_Functions; use Qgen_Functions;

package body Alignment_criterion is

   procedure initOutputs (Gravity_Err_OK : out Boolean) is
   begin
      Alignment_criterion.resetOutputs (Gravity_Err_OK);
   end initOutputs;

   procedure comp
      (Gravity_Err : Float_Array_3;
       Gravity_Err_OK : out Boolean)
   is
   begin
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Alignment criterion/Relational Operator'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Alignment criterion/Constant'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Alignment criterion/Sum'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Alignment criterion/Product'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Alignment criterion/Product '
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Alignment criterion/Product  '
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Alignment criterion/Sqrt'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Alignment criterion/Gravity_Err_OK'
      Gravity_Err_OK := (Float (Sqrt_Fun ((((Gravity_Err (1)) * (Gravity_Err (1))) + ((Gravity_Err (2)) * (Gravity_Err (2)))) + ((Gravity_Err (3)) * (Gravity_Err (3)))))) <= (Float (Attitude_Estimator_params.Gravity_Err_Threshold));
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Alignment criterion/Gravity_Err_OK'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Alignment criterion/Sqrt'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Alignment criterion/Product  '
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Alignment criterion/Product '
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Alignment criterion/Product'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Alignment criterion/Sum'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Alignment criterion/Constant'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Alignment criterion/Relational Operator'
   end comp;

   procedure disable (Gravity_Err_OK : in out Boolean) is
   begin
      Alignment_criterion.resetOutputs (Gravity_Err_OK);
   end disable;

   procedure resetOutputs (Gravity_Err_OK : out Boolean) is
   begin
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Alignment criterion/Gravity_Err_OK'
      Gravity_Err_OK := False;
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Alignment criterion/Gravity_Err_OK'
   end resetOutputs;
end Alignment_criterion;
--  @EOF
