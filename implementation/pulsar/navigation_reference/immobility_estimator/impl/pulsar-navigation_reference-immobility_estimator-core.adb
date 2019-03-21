with Pulsar.Maths;
with Pulsar.Constants;

with Pulsar.Navigation_Reference.Immobility_Estimator.Constants;
use Pulsar.Navigation_Reference.Immobility_Estimator.Constants;

with Hal.Imu;
use Hal.Imu;

package body Pulsar.Navigation_Reference.Immobility_Estimator.Core
is

   --  Number of times the update function will be called
   Number_Of_Cycles_For_1_Second : constant := Natural (Pulsar.Constants.Fast_Loop_Frequency * 1);

   --  Number of times the immobility status should stay at True
   Number_Of_Cycle_For_Confirmation : constant := Natural (Number_Of_Cycles_For_1_Second * Immobility_Confirm_Duration) + 1;

   ----------------------------------------------------------------------------
   --  New_And_Initialize                                                    --
   ----------------------------------------------------------------------------
   function New_And_Initialize (Imu_Interface : not null Hal.Imu.T_Imu_Class_Access)
      return not null T_Immobility_Estimator_Class_Access
   is
   begin
      return new T_Immobility_Estimator'(Imu_Interface => Imu_Interface,
                                         others        => <>);
   end New_And_Initialize;

   ----------------------------------------------------------------------------
   -- Is_Immobility_Confirmed                                                --
   ----------------------------------------------------------------------------
   function Is_Immobility_Confirmed (This : T_Immobility_Estimator)
      return Boolean
   is
      ( This.Immobility_Confirmed );

   ----------------------------------------------------------------------------
   -- Normalize                                                              --
   ----------------------------------------------------------------------------
   function Normalize (X : Float; Y : Float; Z : Float)
      return Float
   is
      ( Pulsar.Maths.Sqrt ((X ** 2) + (Y ** 2) + (Z ** 2)) );

   ----------------------------------------------------------------------------
   --  Update                                                                --
   ----------------------------------------------------------------------------
   procedure Update (This : in out T_Immobility_Estimator)
   is
      Current_Imu_Status                          : constant Hal.Imu.T_Hardware_Status         := This.Imu_Interface.Get_Status;
      Current_Gyro_Increments                     : constant Hal.Imu.T_Gyro_Increments         := This.Imu_Interface.Get_Gyro_Increments;
      Current_Accel_Increments                    : constant Hal.Imu.T_Acceleration_Increments := This.Imu_Interface.Get_Acceleration_Increments;
      Current_Normalized_Acceleration             : constant Hal.Imu.T_Acceleration            := Normalize (X => Current_Accel_Increments.x,
                                                                                                             Y => Current_Accel_Increments.y,
                                                                                                             Z => Current_Accel_Increments.z);
      Current_Normalized_Gyro                     : constant Hal.Imu.T_Angular_Speed           := Normalize (X => Current_Gyro_Increments.x,
                                                                                                             Y => Current_Gyro_Increments.y,
                                                                                                             Z => Current_Gyro_Increments.z);
      Acceleration_Increments_In_Immobility_Range : constant Boolean := Current_Normalized_Acceleration >= Low_Immobility_Acceleration_Tolerance and
                                                                        Current_Normalized_Acceleration <= High_Immobility_Acceleration_Tolerance;
      Rotation_Increments_In_Immobility_Range     : constant Boolean := Current_Normalized_Gyro < Immobility_Rotation_Threshold;
   begin
      --  Check if Current Imu Status is Operational, Accel and Gyro increments detect immobility for at least Immobility_Confirm_Duration
      if Current_Imu_Status = Hal.Imu.Operational and then
        Acceleration_Increments_In_Immobility_Range and then
        Rotation_Increments_In_Immobility_Range then
         This.Current_Cycles_Where_Immobility_Is_Detected := This.Current_Cycles_Where_Immobility_Is_Detected + 1;
         if This.Immobility_Confirmed or else
           (This.Current_Cycles_Where_Immobility_Is_Detected >= Number_Of_Cycle_For_Confirmation)
         then
            This.Immobility_Confirmed := True;

            -- Reset the current number of counted cycles, to avoid possible overflow, as we already are in immobility confirmed
            -- so no need to record the number of cycles satisfying this criteria
            This.Current_Cycles_Where_Immobility_Is_Detected := 0;
         else
            This.Immobility_Confirmed := False;
         end if;
      else
         This.Immobility_Confirmed := False;
         This.Current_Cycles_Where_Immobility_Is_Detected := 0;
      end if;

   end Update;

end Pulsar.Navigation_Reference.Immobility_Estimator.Core;
