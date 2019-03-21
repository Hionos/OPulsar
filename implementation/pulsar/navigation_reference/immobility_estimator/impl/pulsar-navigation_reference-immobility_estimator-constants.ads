-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This is the Immobility Estimator submodule constants package definition   --
-------------------------------------------------------------------------------

with Pulsar.Constants;

package Pulsar.Navigation_Reference.Immobility_Estimator.Constants
is

   --  Acceleration tolerance applied on Earth gravity to detect immobility (m/s²)
   Immobility_Acceleration_Tolerance : constant := 0.1;

   --  Rotation threshold to detect immobility (rad/s)
   Immobility_Rotation_Threshold : constant := 0.2;

   --  Duration to confirm that no motion is detected (s)
   Immobility_Confirm_Duration : constant := 1.0;

   --  Immobility acceleration tolerance bounds (m/s²)
   Low_Immobility_Acceleration_Tolerance : constant := Pulsar.Constants.Earth_Gravity - Immobility_Acceleration_Tolerance;
   High_Immobility_Acceleration_Tolerance : constant := Pulsar.Constants.Earth_Gravity + Immobility_Acceleration_Tolerance;

end Pulsar.Navigation_Reference.Immobility_Estimator.Constants;
