-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This package provides routines to handle the light signal output hardware --
-- abstraction Layer                                                         --
-------------------------------------------------------------------------------

package Hal.Light_Signal
is

   -- Type defining all the possible light signal state
   type T_Light_State is (OFF, Green, Red);

   -- Type defining the interface object
   type T_Light_Signal is limited interface;

   -- Type defining a pointer to the interface object
   type T_Light_Signal_Class_Access is access all T_Light_Signal'Class;

   ----------------------------------------------------------------------------
   -- REQ : Light_State in the T_Light_State
   -- ENS : Light signal will be set to Light_State
   ----------------------------------------------------------------------------
   procedure Set_State (This        : in out T_Light_Signal;
                        Light_State : in T_Light_State) is abstract;

end Hal.Light_Signal;
