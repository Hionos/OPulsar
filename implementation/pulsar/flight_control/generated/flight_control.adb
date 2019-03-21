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

with Flight_Control_params; use Flight_Control_params;

package body Flight_Control is
   Discrete_Derivative_memory : Float;
   Discrete_Time_Integrator_in_memory : Float;
   Discrete_Time_Integrator_out_memory : Float;
   Discrete_Time_Integrator_Reset : Boolean;
   Discrete_Derivative_1_memory : Float;
   Discrete_Time_Integrator_1_in_memory : Float;
   Discrete_Time_Integrator_1_out_memory : Float;
   Discrete_Time_Integrator_1_Reset : Boolean;
   Discrete_Derivative_2_memory : Float;
   Discrete_Time_Integrator_2_in_memory : Float;
   Discrete_Time_Integrator_2_out_memory : Float;
   Discrete_Time_Integrator_2_Reset : Boolean;
   Delay_memory : Float_Array_1;
   Delay_1_memory : Float_Array_1;
   Delay_2_memory : Float_Array_1;

   procedure init is
   begin
      Flight_Control.initStates;
   end init;

   procedure initStates is
   begin
      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0020 SWR-MANUAL-0021/Discrete Derivative'
      Discrete_Derivative_memory := 0.0E+00;
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0020 SWR-MANUAL-0021/Discrete Derivative'

      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0020 SWR-MANUAL-0021/Discrete-Time Integrator'
      Discrete_Time_Integrator_in_memory := 0.0E+00;
      Discrete_Time_Integrator_out_memory := 0.0E+00;
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0020 SWR-MANUAL-0021/Discrete-Time Integrator'

      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0030 SWR-MANUAL-0031/Discrete Derivative'
      Discrete_Derivative_1_memory := 0.0E+00;
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0030 SWR-MANUAL-0031/Discrete Derivative'

      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0030 SWR-MANUAL-0031/Discrete-Time Integrator'
      Discrete_Time_Integrator_1_in_memory := 0.0E+00;
      Discrete_Time_Integrator_1_out_memory := 0.0E+00;
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0030 SWR-MANUAL-0031/Discrete-Time Integrator'

      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0040/Discrete Derivative'
      Discrete_Derivative_2_memory := 0.0E+00;
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0040/Discrete Derivative'

      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0040/Discrete-Time Integrator'
      Discrete_Time_Integrator_2_in_memory := 0.0E+00;
      Discrete_Time_Integrator_2_out_memory := 0.0E+00;
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0040/Discrete-Time Integrator'

      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0020 SWR-MANUAL-0021/Delay'
      Delay_memory (1) := 0.0E+00;
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0020 SWR-MANUAL-0021/Delay'

      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0030 SWR-MANUAL-0031/Delay'
      Delay_1_memory (1) := 0.0E+00;
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0030 SWR-MANUAL-0031/Delay'

      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0040/Delay'
      Delay_2_memory (1) := 0.0E+00;
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0040/Delay'
   end initStates;

   procedure comp
      (Rc_Orders_Throttle : Float;
       Rc_Orders_Rates : Float_Array_3;
       Attitude_Rates : Float_Array_3;
       Flight_Mode : Unsigned_8;
       Rc_Orders_Angles : Float_Array_2;
       Attitude_Angles : Float_Array_2;
       Flight_Control_Throttle : out Float;
       Attitude_Corrections : out Float_Array_3;
       Stop : out Boolean)
   is
      Multiport_Switch1_1_out1 : Float;
      Sum_1_out1 : Float;
      Kd_Roll_out1 : Float;
      Multiport_Switch1_out1 : Boolean;
      Discrete_Time_Integrator_out1 : Float;
      Add_out1 : Float;
      Saturation_out1 : Float;
      Multiport_Switch1_2_out1 : Float;
      Sum_2_out1 : Float;
      Kd_Pitch_out1 : Float;
      Discrete_Time_Integrator_1_out1 : Float;
      Add_1_out1 : Float;
      Saturation_1_out1 : Float;
      Sum1_3_out1 : Float;
      Kd_Yaw_out1 : Float;
      Discrete_Time_Integrator_2_out1 : Float;
      Add_2_out1 : Float;
      Saturation_2_out1 : Float;
      Mux_out1 : Float_Array_3;
   begin
      --  Block 'Flight_Control/Rc_Orders.Throttle'
      --  Block 'Flight_Control/Flight_Control_Throttle'
      Flight_Control_Throttle := Rc_Orders_Throttle;
      --  End Block 'Flight_Control/Flight_Control_Throttle'
      --  End Block 'Flight_Control/Rc_Orders.Throttle'

      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0010 SWR-MANUAL-0020 SWR-MANUAL-0021 /Kp_roll_angle'
      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0010 SWR-MANUAL-0020 SWR-MANUAL-0021 /Sum'
      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0010 SWR-MANUAL-0020 SWR-MANUAL-0021 /Constant'
      --  Block 'Flight_Control/Flight_Mode'
      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0010 SWR-MANUAL-0020 SWR-MANUAL-0021 /Multiport Switch1'
      case Flight_Mode is
         when 1 =>
            Multiport_Switch1_1_out1 := Rc_Orders_Rates (1);
         when 2 =>
            Multiport_Switch1_1_out1 := Float ((Flight_Control_params.Kp_roll_angle) * (Long_Float ((Rc_Orders_Angles (1)) - (Attitude_Angles (1)))));
         when others =>

            --  Last index or index out of range
            Multiport_Switch1_1_out1 := 0.0E+00;
      end case;
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0010 SWR-MANUAL-0020 SWR-MANUAL-0021 /Multiport Switch1'
      --  End Block 'Flight_Control/Flight_Mode'
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0010 SWR-MANUAL-0020 SWR-MANUAL-0021 /Constant'
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0010 SWR-MANUAL-0020 SWR-MANUAL-0021 /Sum'
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0010 SWR-MANUAL-0020 SWR-MANUAL-0021 /Kp_roll_angle'

      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0020 SWR-MANUAL-0021/Sum'
      Sum_1_out1 := (Multiport_Switch1_1_out1) - (Attitude_Rates (1));
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0020 SWR-MANUAL-0021/Sum'

      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0020 SWR-MANUAL-0021/Kd_Roll'
      Kd_Roll_out1 := Float ((Flight_Control_params.Kd_Roll) * (Long_Float (Sum_1_out1)));
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0020 SWR-MANUAL-0021/Kd_Roll'

      --  Block 'Flight_Control/Flight_Control/SWR-FAULT-0000 SWR-INIT-0000 SWR-STANDBY-0000 SWR-STANDBY-0010 SWR-MANUAL-0000/Constant2'
      --  Block 'Flight_Control/Flight_Control/SWR-FAULT-0000 SWR-INIT-0000 SWR-STANDBY-0000 SWR-STANDBY-0010 SWR-MANUAL-0000/Constant'
      --  Block 'Flight_Control/Flight_Mode'
      --  Block 'Flight_Control/Flight_Control/SWR-FAULT-0000 SWR-INIT-0000 SWR-STANDBY-0000 SWR-STANDBY-0010 SWR-MANUAL-0000/Multiport Switch1'
      case Flight_Mode is
         when 1 =>
            Multiport_Switch1_out1 := False;
         when 2 =>
            Multiport_Switch1_out1 := False;
         when others =>

            --  Last index or index out of range
            Multiport_Switch1_out1 := True;
      end case;
      --  End Block 'Flight_Control/Flight_Control/SWR-FAULT-0000 SWR-INIT-0000 SWR-STANDBY-0000 SWR-STANDBY-0010 SWR-MANUAL-0000/Multiport Switch1'
      --  End Block 'Flight_Control/Flight_Mode'
      --  End Block 'Flight_Control/Flight_Control/SWR-FAULT-0000 SWR-INIT-0000 SWR-STANDBY-0000 SWR-STANDBY-0010 SWR-MANUAL-0000/Constant'
      --  End Block 'Flight_Control/Flight_Control/SWR-FAULT-0000 SWR-INIT-0000 SWR-STANDBY-0000 SWR-STANDBY-0010 SWR-MANUAL-0000/Constant2'

      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0020 SWR-MANUAL-0021/Discrete-Time Integrator'
      Discrete_Time_Integrator_Reset := Multiport_Switch1_out1;

      if Discrete_Time_Integrator_Reset then
         Discrete_Time_Integrator_out_memory := 0.0E+00;
         Discrete_Time_Integrator_in_memory := 0.0E+00;
      end if;

      Discrete_Time_Integrator_out1 := (Discrete_Time_Integrator_out_memory) + ((1.0E+00) * ((1.0E-02) * (Discrete_Time_Integrator_in_memory)));
      Discrete_Time_Integrator_out_memory := Discrete_Time_Integrator_out1;
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0020 SWR-MANUAL-0021/Discrete-Time Integrator'

      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0020 SWR-MANUAL-0021/Discrete Derivative'
      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0020 SWR-MANUAL-0021/Kp_Roll'
      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0020 SWR-MANUAL-0021/Add'
      Add_out1 := ((Float ((Flight_Control_params.Kp_Roll) * (Long_Float (Sum_1_out1)))) + (Float ((((1.0E+00) * (Kd_Roll_out1)) / (1.0E-02)) - (Discrete_Derivative_memory)))) + (Discrete_Time_Integrator_out1);
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0020 SWR-MANUAL-0021/Add'
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0020 SWR-MANUAL-0021/Kp_Roll'
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0020 SWR-MANUAL-0021/Discrete Derivative'

      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0020 SWR-MANUAL-0021/Saturation'

      if (Add_out1) > (3.0E+01) then
         Saturation_out1 := 3.0E+01;
      else

         if (Long_Float (Add_out1)) < (-(30.0)) then
            Saturation_out1 := (-3.0E+01);
         else
            Saturation_out1 := Add_out1;
         end if;

      end if;

      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0020 SWR-MANUAL-0021/Saturation'

      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0010 SWR-MANUAL-0030 SWR-MANUAL-0031 /Constant'
      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0010 SWR-MANUAL-0030 SWR-MANUAL-0031 /Kp_pitch_angle'
      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0010 SWR-MANUAL-0030 SWR-MANUAL-0031 /Sum1'
      --  Block 'Flight_Control/Flight_Mode'
      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0010 SWR-MANUAL-0030 SWR-MANUAL-0031 /Multiport Switch1'
      case Flight_Mode is
         when 1 =>
            Multiport_Switch1_2_out1 := Rc_Orders_Rates (2);
         when 2 =>
            Multiport_Switch1_2_out1 := Float ((Flight_Control_params.Kp_pitch_angle) * (Long_Float ((Rc_Orders_Angles (2)) - (Attitude_Angles (2)))));
         when others =>

            --  Last index or index out of range
            Multiport_Switch1_2_out1 := 0.0E+00;
      end case;
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0010 SWR-MANUAL-0030 SWR-MANUAL-0031 /Multiport Switch1'
      --  End Block 'Flight_Control/Flight_Mode'
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0010 SWR-MANUAL-0030 SWR-MANUAL-0031 /Sum1'
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0010 SWR-MANUAL-0030 SWR-MANUAL-0031 /Kp_pitch_angle'
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0010 SWR-MANUAL-0030 SWR-MANUAL-0031 /Constant'

      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0030 SWR-MANUAL-0031/Sum'
      Sum_2_out1 := (Multiport_Switch1_2_out1) - (Attitude_Rates (2));
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0030 SWR-MANUAL-0031/Sum'

      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0030 SWR-MANUAL-0031/Kd_Pitch'
      Kd_Pitch_out1 := Float ((Flight_Control_params.Kd_Pitch) * (Long_Float (Sum_2_out1)));
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0030 SWR-MANUAL-0031/Kd_Pitch'

      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0030 SWR-MANUAL-0031/Discrete-Time Integrator'
      Discrete_Time_Integrator_1_Reset := Multiport_Switch1_out1;

      if Discrete_Time_Integrator_1_Reset then
         Discrete_Time_Integrator_1_out_memory := 0.0E+00;
         Discrete_Time_Integrator_1_in_memory := 0.0E+00;
      end if;

      Discrete_Time_Integrator_1_out1 := (Discrete_Time_Integrator_1_out_memory) + ((1.0E+00) * ((1.0E-02) * (Discrete_Time_Integrator_1_in_memory)));
      Discrete_Time_Integrator_1_out_memory := Discrete_Time_Integrator_1_out1;
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0030 SWR-MANUAL-0031/Discrete-Time Integrator'

      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0030 SWR-MANUAL-0031/Discrete Derivative'
      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0030 SWR-MANUAL-0031/Kp_Pitch'
      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0030 SWR-MANUAL-0031/Add'
      Add_1_out1 := ((Float ((Flight_Control_params.Kp_Pitch) * (Long_Float (Sum_2_out1)))) + (Float ((((1.0E+00) * (Kd_Pitch_out1)) / (1.0E-02)) - (Discrete_Derivative_1_memory)))) + (Discrete_Time_Integrator_1_out1);
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0030 SWR-MANUAL-0031/Add'
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0030 SWR-MANUAL-0031/Kp_Pitch'
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0030 SWR-MANUAL-0031/Discrete Derivative'

      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0030 SWR-MANUAL-0031/Saturation'

      if (Add_1_out1) > (3.0E+01) then
         Saturation_1_out1 := 3.0E+01;
      else

         if (Long_Float (Add_1_out1)) < (-(30.0)) then
            Saturation_1_out1 := (-3.0E+01);
         else
            Saturation_1_out1 := Add_1_out1;
         end if;

      end if;

      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0030 SWR-MANUAL-0031/Saturation'

      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0040/Sum1'
      Sum1_3_out1 := (Rc_Orders_Rates (3)) - (Attitude_Rates (3));
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0040/Sum1'

      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0040/Kd_Yaw'
      Kd_Yaw_out1 := Float ((Flight_Control_params.Kd_Yaw) * (Long_Float (Sum1_3_out1)));
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0040/Kd_Yaw'

      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0040/Discrete-Time Integrator'
      Discrete_Time_Integrator_2_Reset := Multiport_Switch1_out1;

      if Discrete_Time_Integrator_2_Reset then
         Discrete_Time_Integrator_2_out_memory := 0.0E+00;
         Discrete_Time_Integrator_2_in_memory := 0.0E+00;
      end if;

      Discrete_Time_Integrator_2_out1 := (Discrete_Time_Integrator_2_out_memory) + ((1.0E+00) * ((1.0E-02) * (Discrete_Time_Integrator_2_in_memory)));
      Discrete_Time_Integrator_2_out_memory := Discrete_Time_Integrator_2_out1;
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0040/Discrete-Time Integrator'

      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0040/Discrete Derivative'
      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0040/Kp_Yaw'
      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0040/Add'
      Add_2_out1 := ((Float ((Flight_Control_params.Kp_Yaw) * (Long_Float (Sum1_3_out1)))) + (Float ((((1.0E+00) * (Kd_Yaw_out1)) / (1.0E-02)) - (Discrete_Derivative_2_memory)))) + (Discrete_Time_Integrator_2_out1);
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0040/Add'
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0040/Kp_Yaw'
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0040/Discrete Derivative'

      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0040/Saturation'

      if (Add_2_out1) > (3.0E+01) then
         Saturation_2_out1 := 3.0E+01;
      else

         if (Long_Float (Add_2_out1)) < (-(30.0)) then
            Saturation_2_out1 := (-3.0E+01);
         else
            Saturation_2_out1 := Add_2_out1;
         end if;

      end if;

      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0040/Saturation'

      --  Block 'Flight_Control/Flight_Control/Mux'
      Mux_out1 (1) := Saturation_out1;
      Mux_out1 (2) := Saturation_1_out1;
      Mux_out1 (3) := Saturation_2_out1;
      --  End Block 'Flight_Control/Flight_Control/Mux'

      --  Block 'Flight_Control/Attitude_Corrections'

      for i in 1 .. 3 loop
         Attitude_Corrections (i) := Mux_out1 (i);
      end loop;

      --  End Block 'Flight_Control/Attitude_Corrections'

      --  Block 'Flight_Control/Stop'
      Stop := Multiport_Switch1_out1;
      --  End Block 'Flight_Control/Stop'

      --  update 'Flight_Control/Flight_Control/SWR-MANUAL-0020 SWR-MANUAL-0021/Discrete Derivative'
      Discrete_Derivative_memory := ((1.0E+00) * (Kd_Roll_out1)) / (1.0E-02);
      --  End update 'Flight_Control/Flight_Control/SWR-MANUAL-0020 SWR-MANUAL-0021/Discrete Derivative'

      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0020 SWR-MANUAL-0021/Sum1'
      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0020 SWR-MANUAL-0021/Delay'
      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0020 SWR-MANUAL-0021/Kb_Roll'
      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0020 SWR-MANUAL-0021/Ki_Roll'

      --  update 'Flight_Control/Flight_Control/SWR-MANUAL-0020 SWR-MANUAL-0021/Discrete-Time Integrator'

      if Discrete_Time_Integrator_Reset then
         Discrete_Time_Integrator_in_memory := 0.0E+00;
      else
         Discrete_Time_Integrator_in_memory := (Float ((Flight_Control_params.Ki_Roll) * (Long_Float (Sum_1_out1)))) - (Float ((Flight_Control_params.Kb_Roll) * (Long_Float (Delay_memory (1)))));
      end if;

      --  End update 'Flight_Control/Flight_Control/SWR-MANUAL-0020 SWR-MANUAL-0021/Discrete-Time Integrator'
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0020 SWR-MANUAL-0021/Ki_Roll'
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0020 SWR-MANUAL-0021/Kb_Roll'
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0020 SWR-MANUAL-0021/Delay'
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0020 SWR-MANUAL-0021/Sum1'

      --  update 'Flight_Control/Flight_Control/SWR-MANUAL-0030 SWR-MANUAL-0031/Discrete Derivative'
      Discrete_Derivative_1_memory := ((1.0E+00) * (Kd_Pitch_out1)) / (1.0E-02);
      --  End update 'Flight_Control/Flight_Control/SWR-MANUAL-0030 SWR-MANUAL-0031/Discrete Derivative'

      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0030 SWR-MANUAL-0031/Sum1'
      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0030 SWR-MANUAL-0031/Delay'
      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0030 SWR-MANUAL-0031/Kb_Pitch'
      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0030 SWR-MANUAL-0031/Ki_Pitch'

      --  update 'Flight_Control/Flight_Control/SWR-MANUAL-0030 SWR-MANUAL-0031/Discrete-Time Integrator'

      if Discrete_Time_Integrator_1_Reset then
         Discrete_Time_Integrator_1_in_memory := 0.0E+00;
      else
         Discrete_Time_Integrator_1_in_memory := (Float ((Flight_Control_params.Ki_Pitch) * (Long_Float (Sum_2_out1)))) - (Float ((Flight_Control_params.Kb_Pitch) * (Long_Float (Delay_1_memory (1)))));
      end if;

      --  End update 'Flight_Control/Flight_Control/SWR-MANUAL-0030 SWR-MANUAL-0031/Discrete-Time Integrator'
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0030 SWR-MANUAL-0031/Ki_Pitch'
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0030 SWR-MANUAL-0031/Kb_Pitch'
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0030 SWR-MANUAL-0031/Delay'
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0030 SWR-MANUAL-0031/Sum1'

      --  update 'Flight_Control/Flight_Control/SWR-MANUAL-0040/Discrete Derivative'
      Discrete_Derivative_2_memory := ((1.0E+00) * (Kd_Yaw_out1)) / (1.0E-02);
      --  End update 'Flight_Control/Flight_Control/SWR-MANUAL-0040/Discrete Derivative'

      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0040/Sum2'
      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0040/Delay'
      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0040/Kb_Yaw'
      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0040/Ki_Yaw'

      --  update 'Flight_Control/Flight_Control/SWR-MANUAL-0040/Discrete-Time Integrator'

      if Discrete_Time_Integrator_2_Reset then
         Discrete_Time_Integrator_2_in_memory := 0.0E+00;
      else
         Discrete_Time_Integrator_2_in_memory := (Float ((Flight_Control_params.Ki_Yaw) * (Long_Float (Sum1_3_out1)))) - (Float ((Flight_Control_params.Kb_Yaw) * (Long_Float (Delay_2_memory (1)))));
      end if;

      --  End update 'Flight_Control/Flight_Control/SWR-MANUAL-0040/Discrete-Time Integrator'
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0040/Ki_Yaw'
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0040/Kb_Yaw'
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0040/Delay'
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0040/Sum2'

      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0020 SWR-MANUAL-0021/Sum2'

      --  update 'Flight_Control/Flight_Control/SWR-MANUAL-0020 SWR-MANUAL-0021/Delay'
      Delay_memory (1) := (Add_out1) - (Saturation_out1);
      --  End update 'Flight_Control/Flight_Control/SWR-MANUAL-0020 SWR-MANUAL-0021/Delay'
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0020 SWR-MANUAL-0021/Sum2'

      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0030 SWR-MANUAL-0031/Sum2'

      --  update 'Flight_Control/Flight_Control/SWR-MANUAL-0030 SWR-MANUAL-0031/Delay'
      Delay_1_memory (1) := (Add_1_out1) - (Saturation_1_out1);
      --  End update 'Flight_Control/Flight_Control/SWR-MANUAL-0030 SWR-MANUAL-0031/Delay'
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0030 SWR-MANUAL-0031/Sum2'

      --  Block 'Flight_Control/Flight_Control/SWR-MANUAL-0040/Sum3'

      --  update 'Flight_Control/Flight_Control/SWR-MANUAL-0040/Delay'
      Delay_2_memory (1) := (Add_2_out1) - (Saturation_2_out1);
      --  End update 'Flight_Control/Flight_Control/SWR-MANUAL-0040/Delay'
      --  End Block 'Flight_Control/Flight_Control/SWR-MANUAL-0040/Sum3'
   end comp;
end Flight_Control;
--  @EOF
