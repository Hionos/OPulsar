with Pulsar.Maths;

with Pulsar.Motors_Mixing.Constants;

package body Pulsar.Motors_Mixing.Core is

   ----------------------------------------------------------------------------
   -- New_And_Initialize                                                     --
   ----------------------------------------------------------------------------
   function New_And_Initialize (Motors : in not null Hal.Motors.T_Motors_Class_Access) return not null T_Motors_Mixing_Class_Access is
   begin
      return new T_Motors_Mixing'(Motors => Motors,
                                  others => <>);
   end New_And_Initialize;

   ----------------------------------------------------------------------------
   -- Set_Attitude_Corrections                                               --
   ----------------------------------------------------------------------------
   procedure Set_Attitude_Corrections (This        : in out T_Motors_Mixing;
                                       Corrections : in Pulsar.Motors_Mixing.Types.T_Attitude_Corrections) is
   begin
      This.Attitude_Corrections := Corrections;
   end Set_Attitude_Corrections;

   ----------------------------------------------------------------------------
   -- Set_Flight_Control_Throttle                                            --
   ----------------------------------------------------------------------------
   procedure Set_Flight_Control_Throttle (This     : in out T_Motors_Mixing;
                                          Throttle : in Pulsar.Motors_Mixing.Types.T_Flight_Control_Throttle) is
   begin
      This.Flight_Control_Throttle := Throttle;
   end Set_Flight_Control_Throttle;

   ----------------------------------------------------------------------------
   -- Set_Stop                                                               --
   ----------------------------------------------------------------------------
   procedure Set_Stop (This : in out T_Motors_Mixing;
                       Stop : in Boolean) is
   begin
      This.Stop := Stop;
   end Set_Stop;

   ----------------------------------------------------------------------------
   -- Update                                                                 --
   ----------------------------------------------------------------------------
   procedure Update (This : in T_Motors_Mixing) is
      Motors_Speed   : Hal.Motors.T_Motors_Speed := (others => 0.0);
      Motors_Command : Hal.Motors.T_Command := Hal.Motors.Stop;
   begin
      if not This.Stop then
         Motors_Speed   := This.Compute_Motors_Speed;
         Motors_Command := Hal.Motors.Run;
      end if;

      This.Motors.Set_Motors_Speed (Motors_Speed);
      This.Motors.Set_Motors_Command (Motors_Command);
   end Update;

   ----------------------------------------------------------------------------
   -- Compute_Motors_Speed                                                   --
   ----------------------------------------------------------------------------
   function Compute_Motors_Speed (This : in T_Motors_Mixing'Class) return Hal.Motors.T_Motors_Speed is
      Motors_Speed       : Hal.Motors.T_Motors_Speed := (others => 0.0);
      Main_Motors_Thrust : T_Thrusts := (others => 0.0);
      Thrust_Adjustment  : Float := 0.0;
   begin
      Main_Motors_Thrust := This.Compute_Main_Motors_Thrust;
      Thrust_Adjustment := Compute_Thrust_Adjustment (Main_Motors_Thrust);

      for Motor_Id in Hal.Motors.T_Motor_Id loop
         Motors_Speed (Motor_Id) := Hal.Motors.T_Speed (10.0 * Pulsar.Maths.Sqrt (
           Saturate_Motor_Thrust (Main_Motors_Thrust (Motor_Id) + Thrust_Adjustment)));
      end loop;

      return Motors_Speed;
   end Compute_Motors_Speed;

   ----------------------------------------------------------------------------
   -- Compute_Main_Motors_Thrust                                             --
   ----------------------------------------------------------------------------
   function Compute_Main_Motors_Thrust (This : in T_Motors_Mixing'Class) return T_Thrusts is
      Main_Motors_Thrust : T_Thrusts := (others => 0.0);
   begin
      Main_Motors_Thrust (Hal.Motors.Motor1) := -This.Attitude_Corrections.Roll + This.Attitude_Corrections.Pitch + This.Attitude_Corrections.Yaw;
      Main_Motors_Thrust (Hal.Motors.Motor2) := -This.Attitude_Corrections.Roll - This.Attitude_Corrections.Pitch - This.Attitude_Corrections.Yaw;
      Main_Motors_Thrust (Hal.Motors.Motor3) := This.Attitude_Corrections.Roll - This.Attitude_Corrections.Pitch + This.Attitude_Corrections.Yaw;
      Main_Motors_Thrust (Hal.Motors.Motor4) := This.Attitude_Corrections.Roll + This.Attitude_Corrections.Pitch - This.Attitude_Corrections.Yaw;

      for Motor_Id in Hal.Motors.T_Motor_Id loop
         Main_Motors_Thrust (Motor_Id) := (This.Flight_Control_Throttle**2 * 0.01) + Main_Motors_Thrust (Motor_Id);
      end loop;

      return Main_Motors_Thrust;
   end Compute_Main_Motors_Thrust;

   ----------------------------------------------------------------------------
   -- Compute_Thrust_Adjustment                                              --
   ----------------------------------------------------------------------------
   function Compute_Thrust_Adjustment (Main_Motors_Thrust : in T_Thrusts) return Float is
      Minimum           : constant Float := Minimum_Thrust (Main_Motors_Thrust);
      Maximum           : constant Float := Maximum_Thrust (Main_Motors_Thrust);
      Thrust_Adjustment : Float := 0.0;
   begin
      if Maximum - Minimum > 100.0 then
         Thrust_Adjustment := 50.0 - ((Minimum + Maximum) / 2.0);
      else
         if Maximum > 100.0 then
            Thrust_Adjustment := 100.0 - Maximum;
         elsif Minimum < 0.0 then
            Thrust_Adjustment := -Minimum;
         else
            Thrust_Adjustment := 0.0;
         end if;
      end if;

      return Thrust_Adjustment;
   end Compute_Thrust_Adjustment;

   ----------------------------------------------------------------------------
   -- Minimum_Thrust                                                         --
   ----------------------------------------------------------------------------
   function Minimum_Thrust (Thrusts : in T_Thrusts) return Float is
      Minimum : Float := Thrusts (Thrusts'First);
   begin
      for Motor_Id in Hal.Motors.T_Motor_Id range Hal.Motors.T_Motor_Id'Succ (Thrusts'First) .. Thrusts'Last loop
         Minimum := Float'Min (Minimum, Thrusts (Motor_Id));
      end loop;

      return Minimum;
   end Minimum_Thrust;

   ----------------------------------------------------------------------------
   -- Maximum_Thrust                                                         --
   ----------------------------------------------------------------------------
   function Maximum_Thrust (Thrusts : in T_Thrusts) return Float is
      Maximum : Float := Thrusts (Thrusts'First);
   begin
      for Motor_Id in Hal.Motors.T_Motor_Id range Hal.Motors.T_Motor_Id'Succ (Thrusts'First) .. Thrusts'Last loop
         Maximum := Float'Max (Maximum, Thrusts (Motor_Id));
      end loop;

      return Maximum;
   end Maximum_Thrust;

   ----------------------------------------------------------------------------
   -- Saturate_Motor_Thrust                                                  --
   ----------------------------------------------------------------------------
   function Saturate_Motor_Thrust (Thrust : in Float) return Float is
      Saturated  : Float := Thrust;
      Min_Thrust : constant Float := (Motors_Mixing.Constants.Motors_Min_Speed / 10.0)**2;
   begin
      if Saturated > Float (Hal.Motors.T_Speed'Last) then
         Saturated := Float (Hal.Motors.T_Speed'Last);
      elsif Saturated <  Min_Thrust then
         Saturated := Min_Thrust;
      end if;

      return Saturated;
   end Saturate_Motor_Thrust;

end Pulsar.Motors_Mixing.Core;
