-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This is the main Attitude Estimator submodule package definition          --
-------------------------------------------------------------------------------

with Hal.Imu;
with Pulsar.Navigation_Reference.Types;

package Pulsar.Navigation_Reference.Attitude_Estimator.Core
is
   --  Type defining the class object
   type T_Attitude_Estimator is tagged private;

   --  Type defining a pointer to the class object
   type T_Attitude_Estimator_Class_Access is access all T_Attitude_Estimator'Class;

   ----------------------------------------------------------------------------
   --  REQ: Imu_Interface is not null
   --  ENS: Return new instance of T_Attitude_Estimator
   ----------------------------------------------------------------------------
   function New_And_Initialize (Imu_Interface : not null Hal.Imu.T_Imu_Class_Access)
      return not null T_Attitude_Estimator_Class_Access;

   ----------------------------------------------------------------------------
   --  REQ: None
   --  ENS: Navigation Reference status is returned in range of
   --       Pulsar.Navigation_Reference.Types.T_Navigation_Reference_Status
   ----------------------------------------------------------------------------
   function Get_Navigation_Reference_Status (This : in T_Attitude_Estimator)
      return Pulsar.Navigation_Reference.Types.T_Navigation_Reference_Status;

   ----------------------------------------------------------------------------
   --  REQ: None
   --  ENS: Attitude record is returned
   ----------------------------------------------------------------------------
   function Get_Attitude (This : in T_Attitude_Estimator)
      return Pulsar.Navigation_Reference.Types.T_Attitude;

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: Output Attitudes (angles and rates) and Navigation Reference status are computed
   ----------------------------------------------------------------------------
   procedure Update (This : in out T_Attitude_Estimator);

private
   type T_Attitude_Estimator is tagged
      record
         Imu_Interface               : not null Hal.Imu.T_Imu_Class_Access;
         Navigation_Reference_Status : Pulsar.Navigation_Reference.Types.T_Navigation_Reference_Status := Pulsar.Navigation_Reference.Types.Initialization;
         Attitude                    : Pulsar.Navigation_Reference.Types.T_Attitude := ((others => 0.0),
                                                                                        (others => 0.0));
      end record;

end Pulsar.Navigation_Reference.Attitude_Estimator.Core;
