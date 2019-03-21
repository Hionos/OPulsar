-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This package provides routine to update the board                         --
-------------------------------------------------------------------------------

package Hal.Core is

   -- Type defining the interface object
   type T_Hal is limited interface;

   -- Type defining a pointer to the interface object
   type T_Hal_Class_Access is access all T_Hal'Class;

   ----------------------------------------------------------------------------
   -- REQ : None
   -- ENS : The board is updated
   ----------------------------------------------------------------------------
   procedure Update_Board (This : not null access T_Hal) is abstract;

end Hal.Core;
