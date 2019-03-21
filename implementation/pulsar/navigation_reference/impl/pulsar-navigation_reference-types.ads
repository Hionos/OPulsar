-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This is the Navigation Reference Types package definition                 --
-------------------------------------------------------------------------------

with Hal.Imu;
with Ada.Numerics;

package Pulsar.Navigation_Reference.Types is

   -- Type defining all navigation reference component status
   type T_Navigation_Reference_Status is (Initialization, Operational, Failure);

   -- Type defining the Attitude Rates for Roll, Pitch, Yaw  in rad/s
   type T_Attitude_Rates is record
      Roll  : Hal.Imu.T_Angular_Speed := 0.0;
      Pitch : Hal.Imu.T_Angular_Speed := 0.0;
      Yaw   : Hal.Imu.T_Angular_Speed := 0.0;
   end record;

   subtype T_Roll_Angle is Float range -Ada.Numerics.Pi .. Ada.Numerics.Pi;
   subtype T_Pitch_Angle is Float range -Ada.Numerics.Pi/2.0 .. Ada.Numerics.Pi/2.0;

   -- Type defining the Attitude Angles for Roll, Pitch in rad
   type T_Attitude_Angles is record
      Roll  : T_Roll_Angle  := 0.0;
      Pitch : T_Pitch_Angle := 0.0;
   end record;

   type T_Attitude is record
      Angles : T_Attitude_Angles := (others => 0.0);
      Rates  : T_Attitude_Rates  := (others => 0.0);
   end record;

end Pulsar.Navigation_Reference.Types;
