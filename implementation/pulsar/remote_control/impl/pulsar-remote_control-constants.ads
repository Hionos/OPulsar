-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This is the Remote_Control Constants Package definition                   --
-------------------------------------------------------------------------------

with Ada.Numerics;
with Hal.Remote_Control;

package Pulsar.Remote_Control.Constants is

   -- Remote control maximum throttle value to engage flight in safe condition
   Safe_Throttle_Ratio : constant Hal.Remote_Control.T_Ratio := 5.0;

   -- Remote control margin on roll, pitch and yaw commands to engage flight in safe condition
   Safe_Mid_Ratio_Margin  : constant Hal.Remote_Control.T_Ratio := 5.0;

   -- Maximum angular speed order from radio controller on roll angular speed in rad/s
   Max_Roll_Angular_Speed : constant := 3.0 * Ada.Numerics.Pi;

   -- Maximum angular speed order from radio controller on pitch angular speed in rad/s
   Max_Pitch_Angular_Speed : constant := 3.0 * Ada.Numerics.Pi;

   -- Maximum angular speed order from radio controller on yaw angular speed in rad/s
   Max_Yaw_Angular_Speed : constant := Ada.Numerics.Pi;

   -- Maximum angle order from radio controller on roll and pitch in rad
   Max_Angle : constant := Ada.Numerics.Pi / 4.0;

   -- Maximum duration in s allowed without Remote Control data reception before a timeout is declared
   Remote_Control_Timeout : constant := 1.0;

end Pulsar.Remote_Control.Constants;