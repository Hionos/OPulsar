-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This is the main Immobility Estimator submodule package definition        --
-------------------------------------------------------------------------------

with Hal.Imu;

package Pulsar.Navigation_Reference.Immobility_Estimator.Core
is
   --  Type defining the class object
   type T_Immobility_Estimator is tagged private;

   --  Type defining a pointer to the class object
   type T_Immobility_Estimator_Class_Access is access all T_Immobility_Estimator'Class;

   ----------------------------------------------------------------------------
   --  REQ: Imu_Interface is not null
   --  ENS: Return new instance of T_Immobility_Estimator
   ----------------------------------------------------------------------------
   function New_And_Initialize (Imu_Interface : not null Hal.Imu.T_Imu_Class_Access)
      return not null T_Immobility_Estimator_Class_Access;

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: True is returned if the Immobility Estimator detects immobility,
   --      False otherwise
   ----------------------------------------------------------------------------
   function Is_Immobility_Confirmed (This : T_Immobility_Estimator)
      return Boolean;

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: Immobility_confirmed status is computed
   ----------------------------------------------------------------------------
   procedure Update (This : in out T_Immobility_Estimator);

private
   ----------------------------------------------------------------------------
   -- REQ : X, the first component, in the Float range
   --       Y, the second component, in the Float range
   --       Z, the third component, in the Float range
   -- ENS : Returns the norm from the X, Y, Z components in the Float range
   ----------------------------------------------------------------------------
   function Normalize (X : Float; Y : Float; Z : Float)
      return Float;

   type T_Immobility_Estimator is tagged
      record
         Imu_Interface                               : not null Hal.Imu.T_Imu_Class_Access;
         Immobility_Confirmed                        : Boolean := False;
         Current_Cycles_Where_Immobility_Is_Detected : Natural := 0;
      end record;

end Pulsar.Navigation_Reference.Immobility_Estimator.Core;
