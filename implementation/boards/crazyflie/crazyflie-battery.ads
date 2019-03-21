-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This package provides routines to handle the Battery hardware             --
-- Crazyflie                                                                 --
-------------------------------------------------------------------------------

with Hal.Battery;

package Crazyflie.Battery is

   -- Type defining the class object
   type T_Battery is new Hal.Battery.T_Battery with private;

   -- Type defining a pointer to the class object
   type T_Battery_Class_Access is access all T_Battery'Class;

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: Return new instance of T_Battery
   ----------------------------------------------------------------------------
   not overriding
   function New_And_Initialize return not null T_Battery_Class_Access;

   ----------------------------------------------------------------------------
   -- REQ : None
   -- ENS : Return Battery Hardware Status
   ----------------------------------------------------------------------------
   overriding
   function Get_Status (This : not null access T_Battery) return Hal.Battery.T_Battery_Status;

   ----------------------------------------------------------------------------
   -- REQ : None
   -- ENS : Return Battery hardware charge ratio
   ----------------------------------------------------------------------------
   overriding
   function Get_Charge_Ratio (This : not null access T_Battery) return Hal.Battery.T_Charge_Ratio;

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: Update internal state of the component
   ----------------------------------------------------------------------------
   not overriding
   procedure Update (This : not null access T_Battery);

private
   type T_Battery is new Hal.Battery.T_Battery with
      record
         Status       : Hal.Battery.T_Battery_Status := Hal.Battery.Undefined;
         Charge_Ratio : Hal.Battery.T_Charge_Ratio := 0.0;
      end record;

end Crazyflie.Battery;
