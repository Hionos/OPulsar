package body Pulsar.Navigation_Reference.Core
is

   ----------------------------------------------------------------------------
   --  New_And_Initialize                                                    --
   ----------------------------------------------------------------------------
   function New_And_Initialize (Imu_Interface : not null Hal.Imu.T_Imu_Class_Access)
      return not null T_Navigation_Reference_Class_Access
   is
   begin
      return new T_Navigation_Reference'(Immobility_Estimator => Pulsar.Navigation_Reference.Immobility_Estimator.Core.New_And_Initialize (Imu_Interface),
                                        Attitude_Estimator   => Pulsar.Navigation_Reference.Attitude_Estimator.Core.New_And_Initialize (Imu_Interface));
   end New_And_Initialize;

   ----------------------------------------------------------------------------
   -- Is_Immobility_Confirmed                                                 --
   ----------------------------------------------------------------------------
   function Is_Immobility_Confirmed (This : T_Navigation_Reference) return Boolean
   is
      ( This.Immobility_Estimator.Is_Immobility_Confirmed );

   ----------------------------------------------------------------------------
   --  Get_Navigation_Reference_Status                                       --
   ----------------------------------------------------------------------------
   function Get_Navigation_Reference_Status (This : in T_Navigation_Reference)
      return Pulsar.Navigation_Reference.Types.T_Navigation_Reference_Status
   is
      ( This.Attitude_Estimator.Get_Navigation_Reference_Status );

   ----------------------------------------------------------------------------
   --  Get_Attitude                                                          --
   ----------------------------------------------------------------------------
   function Get_Attitude (This : in T_Navigation_Reference)
      return Pulsar.Navigation_Reference.Types.T_Attitude
   is
      ( This.Attitude_Estimator.Get_Attitude );

   ----------------------------------------------------------------------------
   --  Update                                                                --
   ----------------------------------------------------------------------------
   procedure Update (This : in out T_Navigation_Reference)
   is
   begin
      This.Immobility_Estimator.Update;
      This.Attitude_Estimator.Update;
   end Update;

end Pulsar.Navigation_Reference.Core;
