-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This is the Remote_Control Types Package definition                       --
-------------------------------------------------------------------------------

with Hal.Remote_Control;
with Pulsar.Remote_Control.Constants; use Pulsar.Remote_Control.Constants;

package Pulsar.Remote_Control.Types is

   -- Constraint subtype representing roll angular speed in rad/s
   subtype T_Roll_Angular_Speed is Float
      range -Max_Roll_Angular_Speed .. Max_Roll_Angular_Speed;

   -- Constraint subtype representing pitch angular speed in rad/s
   subtype T_Pitch_Angular_Speed is Float
      range -Max_Pitch_Angular_Speed .. Max_Pitch_Angular_Speed;

   -- Constraint subtype representing yaw angular speed in rad/s
   subtype T_Yaw_Angular_Speed is Float
      range -Max_Yaw_Angular_Speed .. Max_Yaw_Angular_Speed;

   -- Constraint subtype representing angle in rad
   subtype T_Angle is Float
      range -Max_Angle .. Max_Angle;

   -- Type defining the Remote Control Rates for Roll, Pitch and Yaw in rad/s
   type T_Rc_Rates is record
      Roll  : T_Roll_Angular_Speed  := 0.0;
      Pitch : T_Pitch_Angular_Speed := 0.0;
      Yaw   : T_Yaw_Angular_Speed   := 0.0;
   end record;

   -- Type defining the Remote Control Angles for Roll and Pitch in rad
   type T_Rc_Angles is record
      Roll  : T_Angle := 0.0;
      Pitch : T_Angle := 0.0;
   end record;

   -- Type defining the Remote Control orders
   type T_Rc_Orders is record
      Throttle : Hal.Remote_Control.T_Ratio;
      Rates    : T_Rc_Rates  := (others => <>);
      Angles   : T_Rc_Angles := (others => <>);
   end record;

   -- Enum representing Remote Control Arming Command
   type T_Arming_Command is (No_Command, Arm, Disarm);

   -- Enum representing Remote Control Flight Mode
   type T_Flight_Mode is (Rates, Stabilized);

end Pulsar.Remote_Control.Types;