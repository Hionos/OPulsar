with Attitude_Estimator;
with Attitude_Estimator_types;
with Interfaces; use Interfaces;

package body Pulsar.Navigation_Reference.Attitude_Estimator.Core
is

   ----------------------------------------------------------------------------
   --  New_And_Initialize                                                    --
   ----------------------------------------------------------------------------
   function New_And_Initialize (Imu_Interface : not null Hal.Imu.T_Imu_Class_Access)
      return not null T_Attitude_Estimator_Class_Access
   is
   begin
      --  Initialize the Matlab/Simulink Model
      Standard.Attitude_Estimator.init;

      return new T_Attitude_Estimator'(Imu_Interface => Imu_Interface,
                                       others        => <>);
   end New_And_Initialize;

   ----------------------------------------------------------------------------
   --  Get_Navigation_Reference_Status                                       --
   ----------------------------------------------------------------------------
   function Get_Navigation_Reference_Status (This : in T_Attitude_Estimator)
      return Pulsar.Navigation_Reference.Types.T_Navigation_Reference_Status
   is
      ( This.Navigation_Reference_Status );

   ----------------------------------------------------------------------------
   --  Get_Attitude                                                          --
   ----------------------------------------------------------------------------
   function Get_Attitude (This : in T_Attitude_Estimator)
      return Pulsar.Navigation_Reference.Types.T_Attitude
   is
      ( This.Attitude );

   ----------------------------------------------------------------------------
   --  Update                                                                --
   ----------------------------------------------------------------------------
   procedure Update (This : in out T_Attitude_Estimator)
   is
      Accel_Increments   : constant Attitude_Estimator_types.Float_Array_3 := (This.Imu_Interface.Get_Acceleration_Increments.x,
                                                                               This.Imu_Interface.Get_Acceleration_Increments.y,
                                                                               This.Imu_Interface.Get_Acceleration_Increments.z);
      Gyro_Increments    : constant Attitude_Estimator_types.Float_Array_3 := (This.Imu_Interface.Get_Gyro_Increments.x,
                                                                               This.Imu_Interface.Get_Gyro_Increments.y,
                                                                               This.Imu_Interface.Get_Gyro_Increments.z);
      Imu_Status         : constant Unsigned_8 := Hal.Imu.T_Hardware_Status'Pos(This.Imu_Interface.Get_Status) + 1;
      Computed_Attitudes : Attitude_Estimator_types.Float_Array_5;
      Computed_Status    : Unsigned_8;
   begin
      --  Should set the inputs to the model and exercize it
      Standard.Attitude_Estimator.comp (Accel_Increments, Gyro_Increments, Imu_Status, Computed_Attitudes, Computed_Status);

      -- Store the results
      This.Navigation_Reference_Status := Pulsar.Navigation_Reference.Types.T_Navigation_Reference_Status'Val (Computed_Status - 1);
      This.Attitude.Angles.Roll        := Pulsar.Navigation_Reference.Types.T_Roll_Angle (Computed_Attitudes(1));
      This.Attitude.Angles.Pitch       := Pulsar.Navigation_Reference.Types.T_Pitch_Angle (Computed_Attitudes(2));
      This.Attitude.Rates.Roll         := Hal.Imu.T_Angular_Speed (Computed_Attitudes(3));
      This.Attitude.Rates.Pitch        := Hal.Imu.T_Angular_Speed (Computed_Attitudes(4));
      This.Attitude.Rates.Yaw          := Hal.Imu.T_Angular_Speed (Computed_Attitudes(5));
   end Update;

end Pulsar.Navigation_Reference.Attitude_Estimator.Core;
