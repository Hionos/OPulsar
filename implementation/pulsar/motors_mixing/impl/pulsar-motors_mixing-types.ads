-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This is the Motors_Mixing Types Package definition                        --
-------------------------------------------------------------------------------

package Pulsar.Motors_Mixing.Types is

   -- Constrained subtype representing an attitude correction in %
   subtype T_Attitude_Correction is Float range -100.0 .. 100.0;

   -- Type representing attitude corrections
   type T_Attitude_Corrections is record
      Roll  : T_Attitude_Correction := 0.0;
      Pitch : T_Attitude_Correction := 0.0;
      Yaw   : T_Attitude_Correction := 0.0;
   end record;

   -- Constrained subtype representing a throttle computed by flight control in %
   subtype T_Flight_Control_Throttle is Float range 0.0 .. 100.0;

end Pulsar.Motors_Mixing.Types;
