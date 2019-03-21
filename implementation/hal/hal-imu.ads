-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This package provides routines to handle the Inertial Platform component  --
-- hardware abstraction Layer                                                --
-------------------------------------------------------------------------------

package Hal.Imu is

   -- Type defining all the possible hardware statuses
   type T_Hardware_Status is (Undefined, Operational, Failure);

   -- Sub-type to restrict the range of the float type use for Acceleration (m/s²)
   subtype T_Acceleration is Float;

   -- Sub-type to restrict the range of the float type use for Angular Speed (rad/s)
   subtype T_Angular_Speed is Float;

   -- Type recording Acceleration Increments
   type T_Acceleration_Increments is record
      x : T_Acceleration := 0.0;
      y : T_Acceleration := 0.0;
      z : T_Acceleration := 0.0;
   end record;

   -- Type recording Gyroscope Increments
   type T_Gyro_Increments is record
      x : T_Angular_Speed := 0.0;
      y : T_Angular_Speed := 0.0;
      z : T_Angular_Speed := 0.0;
   end record;

   -- Type defining the interface object
   type T_Imu is limited interface;

   -- Type defining a pointer to the interface object
   type T_Imu_Class_Access is access all T_Imu'Class;

   ----------------------------------------------------------------------------
   -- REQ : None
   -- ENS : Return Imu Hardware Status
   ----------------------------------------------------------------------------
   function Get_Status (This : not null access T_Imu) return T_Hardware_Status is abstract;

   ----------------------------------------------------------------------------
   -- REQ : None
   -- ENS : Return Imu Acceleration Increments
   ----------------------------------------------------------------------------
   function Get_Acceleration_Increments (This : not null access T_Imu) return T_Acceleration_Increments is abstract;
   --with Pre'Class => Get_Status (This) = Operational; -- This currently makes gcc bug, Ticket N° [Q317-009]

   ----------------------------------------------------------------------------
   -- REQ : None
   -- ENS : Return Imu Gyroscope Increments
   ----------------------------------------------------------------------------
   function Get_Gyro_Increments (This : not null access T_Imu) return T_Gyro_Increments is abstract;
   --with Pre'Class => Get_Status (This) = Operational; -- This currently makes gcc bug, Ticket N° [Q317-009]

end Hal.Imu;
