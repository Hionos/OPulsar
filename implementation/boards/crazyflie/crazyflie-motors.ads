-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This package provides routines to handle the Motors hardware for          --
-- Crazyflie                                                                 --
-------------------------------------------------------------------------------

with Hal.Motors; use Hal.Motors;

package Crazyflie.Motors is

   -- Type defining the class object
   type T_Motors is new Hal.Motors.T_Motors with private;

   -- Type defining a pointer to the class object
   type T_Motors_Class_Access is access all T_Motors'Class;

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: New instance of T_Motors is returned
   ----------------------------------------------------------------------------
   not overriding
   function New_And_Initialize return not null T_Motors_Class_Access;

   ----------------------------------------------------------------------------
   -- REQ : Motors_Speed.MotorX are in range of T_Speed
   -- ENS : Motors speed are set to Motors_Speed.MotorX
   ----------------------------------------------------------------------------
   overriding
   procedure Set_Motors_Speed (This         : in out T_Motors;
                               Motors_Speed : in Hal.Motors.T_Motors_Speed);

   ----------------------------------------------------------------------------
   -- REQ : Command is in range of T_Command
   -- ENS : Command is applied to the motors
   ----------------------------------------------------------------------------
   overriding
   procedure Set_Motors_Command (This    : in out T_Motors;
                                 Command : in Hal.Motors.T_Command);

private

   ----------------------------------------------------------------------------
   -- REQ : None
   -- ENS : PWMs are updated according to the T_Motors internal state
   ----------------------------------------------------------------------------
   not overriding
   procedure Update_PWMs (This : in T_Motors);

   type T_Motors is new Hal.Motors.T_Motors with record
      Motors_Speed   : Hal.Motors.T_Motors_Speed := (others => Hal.Motors.T_Speed'First);
      Motors_Command : Hal.Motors.T_Command := Hal.Motors.Stop;
   end record;

end Crazyflie.Motors;
