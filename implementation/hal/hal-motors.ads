-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This package provides routines to handle the Motors Hardware Abstraction  --
-- Layer                                                                     --
-------------------------------------------------------------------------------

package Hal.Motors is

   -- Type defining the interface object
   type T_Motors is limited interface;

   -- Type defining a pointer to the interface object
   type T_Motors_Class_Access is access all T_Motors'Class;

   -- Constrained type defining motors speed in %
   type T_Speed is delta 0.01 range 0.00 .. 100.00 with Small => 0.01;

   -- Enum of motors
   type T_Motor_Id is (Motor1, Motor2, Motor3, Motor4);

   -- Array type representing output motors speed
   type T_Motors_Speed is array (T_Motor_Id) of T_Speed;

   -- Enum of motors command
   Type T_Command is (Stop, Run);

   ----------------------------------------------------------------------------
   -- REQ : Motors_Speed.MotorX are in range of T_Speed
   -- ENS : Motors speed are set to Motors_Speed.MotorX
   ----------------------------------------------------------------------------
   procedure Set_Motors_Speed (This         : in out T_Motors;
                               Motors_Speed : in T_Motors_Speed) is abstract;

   ----------------------------------------------------------------------------
   -- REQ : Command is in range of T_Command
   -- ENS : Command is applied to the motors
   ----------------------------------------------------------------------------
   procedure Set_Motors_Command (This    : in out T_Motors;
                                 Command : in T_Command) is abstract;

end Hal.Motors;
