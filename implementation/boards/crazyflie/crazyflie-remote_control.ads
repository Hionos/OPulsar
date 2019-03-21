-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This package provides routines to handle the Remote_Control hardware for  --
-- Crazyflie                                                                 --
-------------------------------------------------------------------------------

with Hal.Remote_Control;

with Ada.Real_Time; use Ada.Real_Time;

package Crazyflie.Remote_Control is

   -- Type defining the class object
   type T_Remote_Control is new Hal.Remote_Control.T_Remote_Control with private;

   -- Type defining a pointer to the class object
   type T_Remote_Control_Class_Access is access T_Remote_Control'Class;

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: Return new instance of T_Remote_Control
   ----------------------------------------------------------------------------
   not overriding
   function New_And_Initialize return not null T_Remote_Control_Class_Access;

   ----------------------------------------------------------------------------
   -- REQ : None
   -- ENS : Remote Control Hardware Arming state is returned
   ----------------------------------------------------------------------------
   overriding
   function Get_Arming (This : T_Remote_Control) return Hal.Remote_Control.T_Arming_State;

   ----------------------------------------------------------------------------
   -- REQ : None
   -- ENS : Remote Control Hardware elapsed time since last data reception
   --       is returned
   ----------------------------------------------------------------------------
   overriding
   function Get_Elapsed_Time_From_Reception (This : T_Remote_Control) return Hal.Remote_Control.T_Elapsed_Time;

   ----------------------------------------------------------------------------
   -- REQ : None
   -- ENS : Remote Control Hardware Flight Mode switch is returned
   ----------------------------------------------------------------------------
   overriding
   function Get_Flight_Mode (This : T_Remote_Control) return Hal.Remote_Control.T_Flight_Mode;

   ----------------------------------------------------------------------------
   -- REQ : None
   -- ENS : Return Remote Control Hardware Throttle Ratio
   ----------------------------------------------------------------------------
   overriding
   function Get_Throttle_Ratio (This : T_Remote_Control) return Hal.Remote_Control.T_Ratio;

   ----------------------------------------------------------------------------
   -- REQ : None
   -- ENS : Return Remote Control Hardware Roll Ratio
   ----------------------------------------------------------------------------
   overriding
   function Get_Roll_Ratio (This : T_Remote_Control) return Hal.Remote_Control.T_Ratio;

   ----------------------------------------------------------------------------
   -- REQ : None
   -- ENS : Return Remote Control Hardware Pitch Ratio
   ----------------------------------------------------------------------------
   overriding
   function Get_Pitch_Ratio (This : T_Remote_Control) return Hal.Remote_Control.T_Ratio;

   ----------------------------------------------------------------------------
   -- REQ : None
   -- ENS : Return Remote Control Hardware Yaw Ratio
   ----------------------------------------------------------------------------
   overriding
   function Get_Yaw_Ratio (This : T_Remote_Control) return Hal.Remote_Control.T_Ratio;

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: Update internal state of the component
   ----------------------------------------------------------------------------
   not overriding
   procedure Update (This : in out T_Remote_Control);

private
   type T_Remote_Control is new Hal.Remote_Control.T_Remote_Control with record
      Arming_State                : Hal.Remote_Control.T_Arming_State := Hal.Remote_Control.Disarmed;
      Elapsed_Time_From_Reception : Hal.Remote_Control.T_Elapsed_Time := 65.535;
      Timeout_Start_Time          : Time := Clock;
      Flight_Mode                 : Hal.Remote_Control.T_Flight_Mode := Hal.Remote_Control.Stabilized;
      Throttle                    : Hal.Remote_Control.T_Ratio := 0.0;
      Roll                        : Hal.Remote_Control.T_Ratio := 50.0;
      Pitch                       : Hal.Remote_Control.T_Ratio := 50.0;
      Yaw                         : Hal.Remote_Control.T_Ratio := 50.0;
   end record;

end Crazyflie.Remote_Control;
