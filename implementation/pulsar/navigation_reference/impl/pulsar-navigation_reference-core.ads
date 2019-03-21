-------------------------------------------------------------------------------
--  RESPONSIBILITIES:                                                        --
--  This package provides routines to handle the Navigation Reference        --
--  component                                                                --
-------------------------------------------------------------------------------

with Hal.Imu;

with Pulsar.Navigation_Reference.Types;
with Pulsar.Navigation_Reference.Immobility_Estimator.Core;
with Pulsar.Navigation_Reference.Attitude_Estimator.Core;

package Pulsar.Navigation_Reference.Core
is

   --  Type defining the class object
   type T_Navigation_Reference is tagged limited private;

   --  Type defining a pointer to the class object
   type T_Navigation_Reference_Class_Access is access all T_Navigation_Reference'Class;

   ----------------------------------------------------------------------------
   --  REQ: Imu_Interface is not null
   --  ENS: Return new instance of T_Navigation_Reference
   ----------------------------------------------------------------------------
   function New_And_Initialize (Imu_Interface : not null Hal.Imu.T_Imu_Class_Access)
      return not null T_Navigation_Reference_Class_Access;

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: True is returned if the Navigation Reference detects immobility,
   --      False otherwise
   ----------------------------------------------------------------------------
   function Is_Immobility_Confirmed (This : T_Navigation_Reference) return Boolean;

   ----------------------------------------------------------------------------
   --  REQ: None
   --  ENS: Navigation Reference status is returned in range of
   --       Pulsar.Navigation_Reference.Types.T_Navigation_Reference_Status
   ----------------------------------------------------------------------------
   function Get_Navigation_Reference_Status (This : in T_Navigation_Reference)
      return Pulsar.Navigation_Reference.Types.T_Navigation_Reference_Status;

   ----------------------------------------------------------------------------
   --  REQ: None
   --  ENS: Attitude record is returned
   ----------------------------------------------------------------------------
   function Get_Attitude (This : in T_Navigation_Reference)
      return Pulsar.Navigation_Reference.Types.T_Attitude;

   ----------------------------------------------------------------------------
   --  REQ: None
   --  ENS: Navigation Reference component is updated
   ----------------------------------------------------------------------------
   procedure Update (This : in out T_Navigation_Reference);

private
   type T_Navigation_Reference is tagged limited
      record
         Immobility_Estimator : not null Pulsar.Navigation_Reference.Immobility_Estimator.Core.T_Immobility_Estimator_Class_Access;
         Attitude_Estimator   : not null Pulsar.Navigation_Reference.Attitude_Estimator.Core.T_Attitude_Estimator_Class_Access;
      end record;

end Pulsar.Navigation_Reference.Core;
