-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This package provides routines to handle the Battery hardware             --
-- abstraction Layer                                                         --
-------------------------------------------------------------------------------

package Hal.Battery is

   -- Type defining all the possible battery statuses
   type T_Battery_Status is (Operational, Failure, Undefined);

   -- Constrained type defining battery charge ratio
   type T_Charge_Ratio is delta 0.01 range 0.00 .. 100.00 with Small => 0.01;

   -- Type defining the interface object
   type T_Battery is limited interface;

   -- Type defining a pointer to the interface object
   type T_Battery_Class_Access is access all T_Battery'Class;

   ----------------------------------------------------------------------------
   -- REQ : None
   -- ENS : Return battery hardware status
   ----------------------------------------------------------------------------
   function Get_Status (This : not null access T_Battery) return T_Battery_Status is abstract;

   ----------------------------------------------------------------------------
   -- REQ : None
   -- ENS : Return battery hardware charge ratio
   ----------------------------------------------------------------------------
   function Get_Charge_Ratio (This : not null access T_Battery) return T_Charge_Ratio is abstract;

end Hal.Battery;
