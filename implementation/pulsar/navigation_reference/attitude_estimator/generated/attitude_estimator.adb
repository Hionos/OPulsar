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

with Alignment_criterion; use Alignment_criterion;
with Attitude_Estimator_params; use Attitude_Estimator_params;
with Qgen_Functions; use Qgen_Functions;

package body Attitude_Estimator is
   Alignment_criterion_Gravity_Err_OK : Boolean;
   Q_Est_Previous_memory : Float_Array_4;
   Discrete_Time_Integrator_1_in_memory : Float;
   Discrete_Time_Integrator_1_out_memory : Float;
   Discrete_Time_Integrator_1_Reset : Boolean;
   Alignment_criterion_enabled : Boolean;
   Unit_Delay_memory : Boolean;
   Discrete_Time_Integrator_in_memory : Float_Array_3;
   Discrete_Time_Integrator_out_memory : Float_Array_3;

   procedure init is
   begin
      Attitude_Estimator.initStates;
      Attitude_Estimator.initOutputs;
   end init;

   procedure initStates is
   begin
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Q_Est_Previous'

      for i in 1 .. 4 loop
         Q_Est_Previous_memory (i) := Float (Attitude_Estimator_params.Q_EST_INIT (i));
      end loop;

      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Q_Est_Previous'

      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Compute_Immobility/Discrete-Time Integrator'
      Discrete_Time_Integrator_1_in_memory := 0.0E+00;
      Discrete_Time_Integrator_1_out_memory := 0.0E+00;
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Compute_Immobility/Discrete-Time Integrator'

      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Alignment criterion'
      Alignment_criterion_enabled := True;
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Alignment criterion'

      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Unit Delay'
      Unit_Delay_memory := False;
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Unit Delay'

      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute correction  on gyroscopes/Discrete-Time Integrator'

      for i in 1 .. 3 loop
         Discrete_Time_Integrator_in_memory (i) := 0.0E+00;
      end loop;

      for i in 1 .. 3 loop
         Discrete_Time_Integrator_out_memory (i) := 0.0E+00;
      end loop;

      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute correction  on gyroscopes/Discrete-Time Integrator'
   end initStates;

   procedure initOutputs is
   begin
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Alignment criterion'
      Alignment_criterion.initOutputs (Alignment_criterion_Gravity_Err_OK);
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Alignment criterion'
   end initOutputs;

   procedure comp
      (Imu_Acc_Increments : Float_Array_3;
       Imu_Gyro_Increments : Float_Array_3;
       Imu_Status : Unsigned_8;
       Attitude : out Float_Array_5;
       Navigation_Reference_Status : out Unsigned_8)
   is
      Mux_1_out1 : Float_Array_3;
      Selector_out1 : Float_Array_3;
      Selector_out1_1 : Float_Array_3;
      Sqrt_out1 : Float;
      Switch_out1 : Float;
      Divide_out1 : Float_Array_3;
      Selector_out1_2 : Float_Array_3;
      Selector_out1_3 : Float_Array_3;
      Sum_1_out1 : Float_Array_3;
      Discrete_Time_Integrator_1_out1 : Float;
      Relational_Operator1_out1 : Boolean;
      Logical_Operator2_out1 : Boolean;
      Switch_1_out1 : Float;
      Discrete_Time_Integrator_out1 : Float_Array_3;
      Subtract_out1 : Float_Array_3;
      Mux_1_1_out1 : Float_Array_4;
      Add_out1 : Float_Array_4;
      Sqrt1_out1 : Float;
      Switch_2_out1 : Float;
      Divide_1_out1 : Float_Array_4;
      Math_Function_out1 : Float_Array_4;
      Mux_2_out1 : Float_Array_2;
      Mux_out1 : Float_Array_5;
      Switch1_out1 : Unsigned_8;
      Multiport_Switch1_out1 : Unsigned_8;
      Selector_map1 : Long_Float_Array_3 := 
(1 => 1.0, 2 => 2.0, 3 => 0.0);
      Selector_map1_1 : Long_Float_Array_3 := 
(1 => 2.0, 2 => 0.0, 3 => 1.0);
      Selector_map1_2 : Long_Float_Array_3 := 
(1 => 1.0, 2 => 2.0, 3 => 0.0);
      Selector_map1_3 : Long_Float_Array_3 := 
(1 => 2.0, 2 => 0.0, 3 => 1.0);
   begin
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute estimated direction  of gravity/Subtract'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute estimated direction  of gravity/Product1'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute estimated direction  of gravity/Product'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute estimated direction  of gravity/Subtract2'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute estimated direction  of gravity/Product4'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute estimated direction  of gravity/Product5'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute estimated direction  of gravity/Constant'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute estimated direction  of gravity/Subtract1'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute estimated direction  of gravity/Product2'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute estimated direction  of gravity/Product3'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute estimated direction  of gravity/Mux'
      Mux_1_out1 (1) := ((Q_Est_Previous_memory (2)) * (Q_Est_Previous_memory (4))) - ((Q_Est_Previous_memory (1)) * (Q_Est_Previous_memory (3)));
      Mux_1_out1 (2) := ((Q_Est_Previous_memory (1)) * (Q_Est_Previous_memory (2))) + ((Q_Est_Previous_memory (3)) * (Q_Est_Previous_memory (4)));
      Mux_1_out1 (3) := (((Q_Est_Previous_memory (1)) * (Q_Est_Previous_memory (1))) + ((Q_Est_Previous_memory (4)) * (Q_Est_Previous_memory (4)))) - (5.0E-01);
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute estimated direction  of gravity/Mux'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute estimated direction  of gravity/Product3'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute estimated direction  of gravity/Product2'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute estimated direction  of gravity/Subtract1'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute estimated direction  of gravity/Constant'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute estimated direction  of gravity/Product5'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute estimated direction  of gravity/Product4'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute estimated direction  of gravity/Subtract2'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute estimated direction  of gravity/Product'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute estimated direction  of gravity/Product1'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute estimated direction  of gravity/Subtract'

      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute error terms/Cross Product/Selector'

      for Idx1 in 1 .. 3 loop
         Selector_out1 (Idx1) := Mux_1_out1 ((Integer (Selector_map1 (Idx1))) + (1));
      end loop;

      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute error terms/Cross Product/Selector'

      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute error terms/Cross Product/Selector  '

      for Idx1 in 1 .. 3 loop
         Selector_out1_1 (Idx1) := Mux_1_out1 ((Integer (Selector_map1_1 (Idx1))) + (1));
      end loop;

      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute error terms/Cross Product/Selector  '

      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute Acc_Norm/Normalize 3D Vector/Vect 3D Norm/Sum'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute Acc_Norm/Normalize 3D Vector/Vect 3D Norm/Product'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute Acc_Norm/Normalize 3D Vector/Vect 3D Norm/Product '
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute Acc_Norm/Normalize 3D Vector/Vect 3D Norm/Product  '
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute Acc_Norm/Normalize 3D Vector/Vect 3D Norm/Sqrt'
      Sqrt_out1 := Float (Sqrt_Fun ((((Imu_Acc_Increments (1)) * (Imu_Acc_Increments (1))) + ((Imu_Acc_Increments (2)) * (Imu_Acc_Increments (2)))) + ((Imu_Acc_Increments (3)) * (Imu_Acc_Increments (3)))));
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute Acc_Norm/Normalize 3D Vector/Vect 3D Norm/Sqrt'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute Acc_Norm/Normalize 3D Vector/Vect 3D Norm/Product  '
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute Acc_Norm/Normalize 3D Vector/Vect 3D Norm/Product '
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute Acc_Norm/Normalize 3D Vector/Vect 3D Norm/Product'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute Acc_Norm/Normalize 3D Vector/Vect 3D Norm/Sum'

      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute Acc_Norm/Normalize 3D Vector/Compare To Constant'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute Acc_Norm/Normalize 3D Vector/Constant'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute Acc_Norm/Normalize 3D Vector/Switch'

      if (Sqrt_out1) = (0.0E+00) then
         Switch_out1 := 1.0E+00;
      else
         Switch_out1 := Sqrt_out1;
      end if;

      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute Acc_Norm/Normalize 3D Vector/Switch'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute Acc_Norm/Normalize 3D Vector/Constant'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute Acc_Norm/Normalize 3D Vector/Compare To Constant'

      --  Block 'Attitude_Estimator/Imu.Acc_Increments'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute Acc_Norm/Normalize 3D Vector/Divide'

      for i in 1 .. 3 loop
         Divide_out1 (i) := (Imu_Acc_Increments (i)) / (Switch_out1);
      end loop;

      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute Acc_Norm/Normalize 3D Vector/Divide'
      --  End Block 'Attitude_Estimator/Imu.Acc_Increments'

      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute error terms/Cross Product/ Selector '

      for Idx1 in 1 .. 3 loop
         Selector_out1_2 (Idx1) := Divide_out1 ((Integer (Selector_map1_2 (Idx1))) + (1));
      end loop;

      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute error terms/Cross Product/ Selector '

      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute error terms/Cross Product/Selector '

      for Idx1 in 1 .. 3 loop
         Selector_out1_3 (Idx1) := Divide_out1 ((Integer (Selector_map1_3 (Idx1))) + (1));
      end loop;

      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute error terms/Cross Product/Selector '

      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute error terms/Cross Product/Product '
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute error terms/Cross Product/Product'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute error terms/Cross Product/Sum'

      for i in 1 .. 3 loop
         Sum_1_out1 (i) := ((Selector_out1 (i)) * (Selector_out1_3 (i))) - ((Selector_out1_1 (i)) * (Selector_out1_2 (i)));
      end loop;

      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute error terms/Cross Product/Sum'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute error terms/Cross Product/Product'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute error terms/Cross Product/Product '

      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Compute_Immobility/Logical Operator'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Compute_Immobility/Constant'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Compute_Immobility/Sqrt'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Compute_Immobility/Product  '
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Compute_Immobility/Product '
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Compute_Immobility/Product'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Compute_Immobility/Sum'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Compute_Immobility/Relational Operator'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Compute_Immobility/Discrete-Time Integrator'
      Discrete_Time_Integrator_1_Reset := not ((Float (Sqrt_Fun ((((Imu_Gyro_Increments (1)) * (Imu_Gyro_Increments (1))) + ((Imu_Gyro_Increments (2)) * (Imu_Gyro_Increments (2)))) + ((Imu_Gyro_Increments (3)) * (Imu_Gyro_Increments (3)))))) <= (Float (Attitude_Estimator_params.Immobility_Threshold)));

      if Discrete_Time_Integrator_1_Reset then
         Discrete_Time_Integrator_1_out_memory := 0.0E+00;
         Discrete_Time_Integrator_1_in_memory := 0.0E+00;
      end if;

      Discrete_Time_Integrator_1_out1 := (Discrete_Time_Integrator_1_out_memory) + ((1.0E+00) * ((1.0E-02) * (Discrete_Time_Integrator_1_in_memory)));
      Discrete_Time_Integrator_1_out_memory := Discrete_Time_Integrator_1_out1;
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Compute_Immobility/Discrete-Time Integrator'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Compute_Immobility/Relational Operator'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Compute_Immobility/Sum'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Compute_Immobility/Product'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Compute_Immobility/Product '
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Compute_Immobility/Product  '
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Compute_Immobility/Sqrt'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Compute_Immobility/Constant'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Compute_Immobility/Logical Operator'

      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Compute_Immobility/Constant2'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Compute_Immobility/Relational Operator1'
      Relational_Operator1_out1 := (Discrete_Time_Integrator_1_out1) > (Float (Attitude_Estimator_params.Immobility_Time_Confirmation));
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Compute_Immobility/Relational Operator1'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Compute_Immobility/Constant2'

      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Logical Operator'
      --  Block 'Attitude_Estimator/Imu.Status'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Compare To Constant1'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Alignment criterion'

      if (Relational_Operator1_out1)
         and then ((Imu_Status) = (2))
      then

         if not (Alignment_criterion_enabled) then
            Alignment_criterion_enabled := True;
         end if;

         Alignment_criterion.comp (Sum_1_out1, Alignment_criterion_Gravity_Err_OK);
      else

         if Alignment_criterion_enabled then
            Alignment_criterion_enabled := False;
            Alignment_criterion.disable (Alignment_criterion_Gravity_Err_OK);
         end if;

      end if;

      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Alignment criterion'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Compare To Constant1'
      --  End Block 'Attitude_Estimator/Imu.Status'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Logical Operator'

      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Unit Delay'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Logical Operator2'
      Logical_Operator2_out1 := (Alignment_criterion_Gravity_Err_OK)
         or else (Unit_Delay_memory);
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Logical Operator2'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Unit Delay'

      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Logical Operator1'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Logical Operator4'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute correction  on gyroscopes/Boost Gain alignment/Gain'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute correction  on gyroscopes/Constant1'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute correction  on gyroscopes/Boost Gain alignment/Switch'

      if (Relational_Operator1_out1)
         and then (not (Logical_Operator2_out1))
      then
         Switch_1_out1 := (1.0E+01) * (Float (Attitude_Estimator_params.FILTER_KP));
      else
         Switch_1_out1 := Float (Attitude_Estimator_params.FILTER_KP);
      end if;

      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute correction  on gyroscopes/Boost Gain alignment/Switch'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute correction  on gyroscopes/Constant1'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute correction  on gyroscopes/Boost Gain alignment/Gain'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Logical Operator4'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Logical Operator1'

      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute correction  on gyroscopes/Discrete-Time Integrator'

      for i in 1 .. 3 loop
         Discrete_Time_Integrator_out1 (i) := (Discrete_Time_Integrator_out_memory (i)) + ((1.0E+00) * ((1.0E-02) * (Discrete_Time_Integrator_in_memory (i))));
      end loop;

      for i in 1 .. 3 loop
         Discrete_Time_Integrator_out_memory (i) := Discrete_Time_Integrator_out1 (i);
      end loop;

      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute correction  on gyroscopes/Discrete-Time Integrator'

      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute correction  on gyroscopes/Product'
      --  Block 'Attitude_Estimator/Imu.Gyro_Increments'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute correction  on gyroscopes/Subtract'

      for i in 1 .. 3 loop
         Subtract_out1 (i) := ((Imu_Gyro_Increments (i)) + ((Sum_1_out1 (i)) * (Switch_1_out1))) + (Discrete_Time_Integrator_out1 (i));
      end loop;

      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute correction  on gyroscopes/Subtract'
      --  End Block 'Attitude_Estimator/Imu.Gyro_Increments'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute correction  on gyroscopes/Product'

      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Kinematic Propagation Quaternion/Add4'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Kinematic Propagation Quaternion/Product12'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Kinematic Propagation Quaternion/Product13'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Kinematic Propagation Quaternion/Product11'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Kinematic Propagation Quaternion/Add3'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Kinematic Propagation Quaternion/Product8'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Kinematic Propagation Quaternion/Product9'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Kinematic Propagation Quaternion/Product10'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Kinematic Propagation Quaternion/Add2'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Kinematic Propagation Quaternion/Product5'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Kinematic Propagation Quaternion/Product6'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Kinematic Propagation Quaternion/Product7'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Kinematic Propagation Quaternion/Add1'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Kinematic Propagation Quaternion/Product2'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Kinematic Propagation Quaternion/Product3'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Kinematic Propagation Quaternion/Product4'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Kinematic Propagation Quaternion/Mux'
      Mux_1_1_out1 (1) := (((0.0E+00) - ((Subtract_out1 (1)) * (Q_Est_Previous_memory (2)))) - ((Subtract_out1 (2)) * (Q_Est_Previous_memory (3)))) - ((Subtract_out1 (3)) * (Q_Est_Previous_memory (4)));
      Mux_1_1_out1 (2) := (((Subtract_out1 (1)) * (Q_Est_Previous_memory (1))) + ((Subtract_out1 (3)) * (Q_Est_Previous_memory (3)))) - ((Subtract_out1 (2)) * (Q_Est_Previous_memory (4)));
      Mux_1_1_out1 (3) := (((Subtract_out1 (2)) * (Q_Est_Previous_memory (1))) - ((Subtract_out1 (3)) * (Q_Est_Previous_memory (2)))) + ((Subtract_out1 (1)) * (Q_Est_Previous_memory (4)));
      Mux_1_1_out1 (4) := (((Subtract_out1 (3)) * (Q_Est_Previous_memory (1))) + ((Subtract_out1 (2)) * (Q_Est_Previous_memory (2)))) - ((Subtract_out1 (1)) * (Q_Est_Previous_memory (3)));
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Kinematic Propagation Quaternion/Mux'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Kinematic Propagation Quaternion/Product4'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Kinematic Propagation Quaternion/Product3'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Kinematic Propagation Quaternion/Product2'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Kinematic Propagation Quaternion/Add1'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Kinematic Propagation Quaternion/Product7'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Kinematic Propagation Quaternion/Product6'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Kinematic Propagation Quaternion/Product5'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Kinematic Propagation Quaternion/Add2'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Kinematic Propagation Quaternion/Product10'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Kinematic Propagation Quaternion/Product9'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Kinematic Propagation Quaternion/Product8'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Kinematic Propagation Quaternion/Add3'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Kinematic Propagation Quaternion/Product11'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Kinematic Propagation Quaternion/Product13'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Kinematic Propagation Quaternion/Product12'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Kinematic Propagation Quaternion/Add4'

      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Gain'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Q_Est_Previous'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Add'

      for i in 1 .. 4 loop
         Add_out1 (i) := Float ((Long_Float (Q_Est_Previous_memory (i))) + (((0.5) * (Attitude_Estimator_params.te)) * (Long_Float (Mux_1_1_out1 (i)))));
      end loop;

      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Add'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Q_Est_Previous'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Gain'

      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Unit Quaternion/Quaternion Norm/Sum'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Unit Quaternion/Quaternion Norm/Product'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Unit Quaternion/Quaternion Norm/Product '
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Unit Quaternion/Quaternion Norm/ Product '
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Unit Quaternion/Quaternion Norm/ Product  '
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Unit Quaternion/Quaternion Norm/Sqrt1'
      Sqrt1_out1 := Float (Sqrt_Fun (((((Add_out1 (1)) * (Add_out1 (1))) + ((Add_out1 (2)) * (Add_out1 (2)))) + ((Add_out1 (3)) * (Add_out1 (3)))) + ((Add_out1 (4)) * (Add_out1 (4)))));
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Unit Quaternion/Quaternion Norm/Sqrt1'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Unit Quaternion/Quaternion Norm/ Product  '
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Unit Quaternion/Quaternion Norm/ Product '
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Unit Quaternion/Quaternion Norm/Product '
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Unit Quaternion/Quaternion Norm/Product'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Unit Quaternion/Quaternion Norm/Sum'

      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Unit Quaternion/Compare To Constant'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Unit Quaternion/Constant'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Unit Quaternion/Switch'

      if (Boolean_To_Unsigned_8 ((Sqrt1_out1) = (0.0E+00))) > (0) then
         Switch_2_out1 := 1.0E+00;
      else
         Switch_2_out1 := Sqrt1_out1;
      end if;

      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Unit Quaternion/Switch'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Unit Quaternion/Constant'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Unit Quaternion/Compare To Constant'

      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Unit Quaternion/Divide'

      for i in 1 .. 4 loop
         Divide_1_out1 (i) := (Add_out1 (i)) / (Switch_2_out1);
      end loop;

      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Euler Integration/Compute Unit Quaternion/Divide'

      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Quaternion To Euler Angles/Compute Roll /1 - 2*(qx² + qy²)/Math Function'

      for i in 1 .. 4 loop
         Math_Function_out1 (i) := pow (Divide_1_out1 (i), Float (2.0E+00));
      end loop;

      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Quaternion To Euler Angles/Compute Roll /1 - 2*(qx² + qy²)/Math Function'

      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Quaternion To Euler Angles/Compute Pitch/Asin'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Quaternion To Euler Angles/Compute Pitch/2*(qw*qy-qz*qx)/Add'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Quaternion To Euler Angles/Compute Pitch/2*(qw*qy-qz*qx)/qw*qy'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Quaternion To Euler Angles/Compute Pitch/2*(qw*qy-qz*qx)/qx*qz'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Quaternion To Euler Angles/Compute Pitch/2*(qw*qy-qz*qx)/Gain1'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Quaternion To Euler Angles/Compute Roll /Atan2'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Quaternion To Euler Angles/Compute Roll /2*(qw*qx + qy*qz)/Add'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Quaternion To Euler Angles/Compute Roll /2*(qw*qx + qy*qz)/qw*qx'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Quaternion To Euler Angles/Compute Roll /2*(qw*qx + qy*qz)/qy*qz'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Quaternion To Euler Angles/Compute Roll /2*(qw*qx + qy*qz)/Gain1'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Quaternion To Euler Angles/Compute Roll /1 - 2*(qx² + qy²)/Constant'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Quaternion To Euler Angles/Compute Roll /1 - 2*(qx² + qy²)/Gain3'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Quaternion To Euler Angles/Compute Roll /1 - 2*(qx² + qy²)/Add3'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Quaternion To Euler Angles/Compute Roll /1 - 2*(qx² + qy²)/Add1'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Quaternion To Euler Angles/Mux'
      Mux_2_out1 (1) := atan2 ((2.0E+00) * (((Divide_1_out1 (1)) * (Divide_1_out1 (2))) + ((Divide_1_out1 (3)) * (Divide_1_out1 (4)))), (1.0E+00) - ((2.0E+00) * ((Math_Function_out1 (2)) + (Math_Function_out1 (3)))));
      Mux_2_out1 (2) := asin ((2.0E+00) * (((Divide_1_out1 (1)) * (Divide_1_out1 (3))) - ((Divide_1_out1 (2)) * (Divide_1_out1 (4)))));
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Quaternion To Euler Angles/Mux'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Quaternion To Euler Angles/Compute Roll /1 - 2*(qx² + qy²)/Add1'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Quaternion To Euler Angles/Compute Roll /1 - 2*(qx² + qy²)/Add3'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Quaternion To Euler Angles/Compute Roll /1 - 2*(qx² + qy²)/Gain3'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Quaternion To Euler Angles/Compute Roll /1 - 2*(qx² + qy²)/Constant'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Quaternion To Euler Angles/Compute Roll /2*(qw*qx + qy*qz)/Gain1'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Quaternion To Euler Angles/Compute Roll /2*(qw*qx + qy*qz)/qy*qz'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Quaternion To Euler Angles/Compute Roll /2*(qw*qx + qy*qz)/qw*qx'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Quaternion To Euler Angles/Compute Roll /2*(qw*qx + qy*qz)/Add'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Quaternion To Euler Angles/Compute Roll /Atan2'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Quaternion To Euler Angles/Compute Pitch/2*(qw*qy-qz*qx)/Gain1'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Quaternion To Euler Angles/Compute Pitch/2*(qw*qy-qz*qx)/qx*qz'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Quaternion To Euler Angles/Compute Pitch/2*(qw*qy-qz*qx)/qw*qy'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Quaternion To Euler Angles/Compute Pitch/2*(qw*qy-qz*qx)/Add'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Quaternion To Euler Angles/Compute Pitch/Asin'

      --  Block 'Attitude_Estimator/Imu.Gyro_Increments'
      --  Block 'Attitude_Estimator/Attitude_Estimator/Mux'

      for Idx1 in 1 .. 2 loop
         Mux_out1 (Idx1) := Mux_2_out1 (Idx1);
      end loop;

      for Idx1 in 1 .. 3 loop
         Mux_out1 ((Idx1) + (2)) := Imu_Gyro_Increments (Idx1);
      end loop;

      --  End Block 'Attitude_Estimator/Attitude_Estimator/Mux'
      --  End Block 'Attitude_Estimator/Imu.Gyro_Increments'

      --  Block 'Attitude_Estimator/Attitude'

      for i in 1 .. 5 loop
         Attitude (i) := Mux_out1 (i);
      end loop;

      --  End Block 'Attitude_Estimator/Attitude'

      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-ST	ANDBY-0000 SWR-FAULT-0000/Undefined'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-ST	ANDBY-0000 SWR-FAULT-0000/Operational1'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-ST	ANDBY-0000 SWR-FAULT-0000/Failure1'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-ST	ANDBY-0000 SWR-FAULT-0000/Logical Operator1'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-ST	ANDBY-0000 SWR-FAULT-0000/Compare To Constant'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-ST	ANDBY-0000 SWR-FAULT-0000/Compare To Constant1'
      --  Block 'Attitude_Estimator/Imu.Status'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-ST	ANDBY-0000 SWR-FAULT-0000/Switch1'

      if (Imu_Status) = (3) then
         Switch1_out1 := 3;
      else

         --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-ST	ANDBY-0000 SWR-FAULT-0000/Switch2'

         if ((Imu_Status) = (2))
            and then (Logical_Operator2_out1)
         then
            Switch1_out1 := 2;
         else
            Switch1_out1 := 1;
         end if;

         --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-ST	ANDBY-0000 SWR-FAULT-0000/Switch2'
      end if;

      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-ST	ANDBY-0000 SWR-FAULT-0000/Switch1'
      --  End Block 'Attitude_Estimator/Imu.Status'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-ST	ANDBY-0000 SWR-FAULT-0000/Compare To Constant1'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-ST	ANDBY-0000 SWR-FAULT-0000/Compare To Constant'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-ST	ANDBY-0000 SWR-FAULT-0000/Logical Operator1'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-ST	ANDBY-0000 SWR-FAULT-0000/Failure1'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-ST	ANDBY-0000 SWR-FAULT-0000/Operational1'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-ST	ANDBY-0000 SWR-FAULT-0000/Undefined'

      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-ST	ANDBY-0000 SWR-FAULT-0000/Failure'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-ST	ANDBY-0000 SWR-FAULT-0000/Operational'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-ST	ANDBY-0000 SWR-FAULT-0000/Initialization'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-ST	ANDBY-0000 SWR-FAULT-0000/Multiport Switch1'
      case Switch1_out1 is
         when 1 =>
            Multiport_Switch1_out1 := 1;
         when 2 =>
            Multiport_Switch1_out1 := 2;
         when others =>

            --  Last index or index out of range
            Multiport_Switch1_out1 := 3;
      end case;
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-ST	ANDBY-0000 SWR-FAULT-0000/Multiport Switch1'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-ST	ANDBY-0000 SWR-FAULT-0000/Initialization'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-ST	ANDBY-0000 SWR-FAULT-0000/Operational'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-ST	ANDBY-0000 SWR-FAULT-0000/Failure'

      --  Block 'Attitude_Estimator/Navigation_Reference_Status'
      Navigation_Reference_Status := Multiport_Switch1_out1;
      --  End Block 'Attitude_Estimator/Navigation_Reference_Status'

      --  update 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Q_Est_Previous'

      for i in 1 .. 4 loop
         Q_Est_Previous_memory (i) := Divide_1_out1 (i);
      end loop;

      --  End update 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Q_Est_Previous'

      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Compute_Immobility/Constant1'

      --  update 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Compute_Immobility/Discrete-Time Integrator'

      if Discrete_Time_Integrator_1_Reset then
         Discrete_Time_Integrator_1_in_memory := 0.0E+00;
      else
         Discrete_Time_Integrator_1_in_memory := 1.0E+00;
      end if;

      --  End update 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Compute_Immobility/Discrete-Time Integrator'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Compute_Immobility/Constant1'

      --  update 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Unit Delay'
      Unit_Delay_memory := Logical_Operator2_out1;
      --  End update 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Unit Delay'

      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute correction  on gyroscopes/Product1'
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute correction  on gyroscopes/Constant'

      --  update 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute correction  on gyroscopes/Discrete-Time Integrator'

      for i in 1 .. 3 loop
         Discrete_Time_Integrator_in_memory (i) := (Sum_1_out1 (i)) * (Float (Attitude_Estimator_params.FILTER_KI));
      end loop;

      --  End update 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute correction  on gyroscopes/Discrete-Time Integrator'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute correction  on gyroscopes/Constant'
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-MANUAL-0021 SWR-MANUAL-0031/Compute correction  on gyroscopes/Product1'
   end comp;

   procedure disable is
   begin
      --  Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Alignment criterion'
      Alignment_criterion.disable (Alignment_criterion_Gravity_Err_OK);
      --  End Block 'Attitude_Estimator/Attitude_Estimator/SWR-ST	ANDBY-0000 SWR-FAULT-0000/SWR-STANDBY-0000/Alignment criterion'
   end disable;
end Attitude_Estimator;
--  @EOF
