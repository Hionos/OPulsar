-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This package provides routines to handle the Led Crazyflie                --
-------------------------------------------------------------------------------

with Hal.Light_Signal; use Hal.Light_Signal;

package Crazyflie.Light_Signal is

   -- Type defining the class object
   type T_Light_Signal is new Hal.Light_Signal.T_Light_Signal with private;

   -- Type defining a pointer to the class object
   type T_Light_Signal_Class_Access is access all T_Light_Signal'Class;

   ----------------------------------------------------------------------------
   -- REQ: Led_Color is in range of Hal.Led.T_Led_Color
   -- ENS: Return new instance of T_Led
   ----------------------------------------------------------------------------
   not overriding
   function New_And_Initialize return not null T_Light_Signal_CLass_Access;

   ----------------------------------------------------------------------------
   -- REQ : Led_State, the output state, in the range of Hal.Led.T_Led_State
   -- ENS : Led will be set with Led_State
   ----------------------------------------------------------------------------
   overriding
   procedure Set_State (This        : in out T_Light_Signal;
                        Light_State : in Hal.Light_Signal.T_Light_State);

private
   type T_Light_Signal is new Hal.Light_Signal.T_Light_Signal with null record;

end Crazyflie.Light_Signal;
