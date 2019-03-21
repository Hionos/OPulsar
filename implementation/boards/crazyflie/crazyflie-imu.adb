with IMU_Device;

package body Crazyflie.Imu is

   ----------------------------------------------------------------------------
   -- New_And_Initialize                                                     --
   ----------------------------------------------------------------------------
   function New_And_Initialize return not null T_Imu_Class_Access is
   begin
      IMU_Device.IMU_Init_Registers;
      return new Crazyflie.Imu.T_Imu;
   end New_And_Initialize;

   ----------------------------------------------------------------------------
   -- Get_Status                                                             --
   ----------------------------------------------------------------------------
   overriding
   function Get_Status (This : not null access T_Imu) return Hal.Imu.T_Hardware_Status is
   begin
      return This.Status;
   end Get_Status;

   ----------------------------------------------------------------------------
   -- Get_Acceleration_Increments                                            --
   ----------------------------------------------------------------------------
   overriding
   function Get_Acceleration_Increments (This : not null access T_Imu) return Hal.Imu.T_Acceleration_Increments is
   begin
      return This.Accel;
   end Get_Acceleration_Increments;

   ----------------------------------------------------------------------------
   -- Get_Gyro_Increments                                                    --
   ----------------------------------------------------------------------------
   overriding
   function Get_Gyro_Increments (This : not null access T_Imu) return Hal.Imu.T_Gyro_Increments is
   begin
      return This.Gyro;
   end Get_Gyro_Increments;

   ----------------------------------------------------------------------------
   -- Update                                                                 --
   ----------------------------------------------------------------------------
   not overriding
   procedure Update (This : not null access T_Imu) is
   begin
      This.Status := IMU_Device.IMU_Get_Status;
      This.Accel  := IMU_Device.IMU_Get_Acc;
      This.Gyro   := IMU_Device.IMU_Get_Gyro;
   end Update;

end Crazyflie.Imu;
