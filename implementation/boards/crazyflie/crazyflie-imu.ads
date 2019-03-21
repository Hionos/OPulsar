-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This package provides routines to handle the Imu component                --
-------------------------------------------------------------------------------

with Hal.Imu;

package Crazyflie.Imu is

   -- Type defining the class object
   type T_Imu is new Hal.Imu.T_Imu with private;

   -- Type defining a pointer to the class object
   type T_Imu_Class_Access is access T_Imu'Class;

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: Return new instance of T_Imu
   ----------------------------------------------------------------------------
   function New_And_Initialize return not null T_Imu_Class_Access;

   ----------------------------------------------------------------------------
   -- REQ : None
   -- ENS : Return Imu Hardware Status
   ----------------------------------------------------------------------------
   overriding
   function Get_Status (This : not null access T_Imu) return Hal.Imu.T_Hardware_Status;

   ----------------------------------------------------------------------------
   -- REQ : None
   -- ENS : Return Imu Acceleration Increments
   ----------------------------------------------------------------------------
   overriding
   function Get_Acceleration_Increments (This : not null access T_Imu) return Hal.Imu.T_Acceleration_Increments;

   ----------------------------------------------------------------------------
   -- REQ : None
   -- ENS : Return Imu Gyroscope Increments
   ----------------------------------------------------------------------------
   overriding
   function Get_Gyro_Increments (This : not null access T_Imu) return Hal.Imu.T_Gyro_Increments;

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: Update internal state of the component
   ----------------------------------------------------------------------------
   not overriding
   procedure Update (This : not null access T_Imu);

private
   type T_Imu is new Hal.Imu.T_Imu with record
      Status : Hal.Imu.T_Hardware_Status := Hal.Imu.Undefined;
      Accel  : Hal.Imu.T_Acceleration_Increments := (others => 0.0);
      Gyro   : Hal.Imu.T_Gyro_Increments := (others => 0.0);
   end record;

end Crazyflie.Imu;
