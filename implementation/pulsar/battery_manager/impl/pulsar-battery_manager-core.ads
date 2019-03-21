-------------------------------------------------------------------------------
--                       PULSAR FLIGHT SYSTEM                                --
--                                                                           --
--           Copyright (C) 2016-2017, SOGILIS <http://sogilis.com>           --
--                                                                           --
-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This package provides routines to handle the Battery Manager component    --
-------------------------------------------------------------------------------

with Pulsar.Battery_Manager.Types;
with Hal.Battery;

package Pulsar.Battery_Manager.Core is

   -- Type defining the class object
   type T_Battery_Manager is tagged private;

   -- Type defining a pointer to the class object
   type T_Battery_Manager_Class_Access is access all T_Battery_Manager'Class;

   ----------------------------------------------------------------------------
   -- REQ: Battery_Interface is not null
   -- ENS: Return new instance of T_Battery_Manager
   ----------------------------------------------------------------------------
   function New_And_Initialize (Battery_Interface : not null Hal.Battery.T_Battery_Class_Access)
      return not null T_Battery_Manager_Class_Access;

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: Return True if the Battery Level is sufficient for Flight,
   --             False otherwise
   ----------------------------------------------------------------------------
   function Is_Battery_Level_Sufficient_For_Flight (This : T_Battery_Manager) return Boolean;

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: Return battery manager component status in range of Pulsar.Battery_Manager.Types.T_Battery_Manager_Status
   ----------------------------------------------------------------------------
   function Get_Battery_Status (This : T_Battery_Manager) return Pulsar.Battery_Manager.Types.T_Battery_Manager_Status;

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: None
   ----------------------------------------------------------------------------
   procedure Update (This : in out T_Battery_Manager);

private
   type T_Battery_Manager is tagged
      record
         Battery_Interface : Hal.Battery.T_Battery_Class_Access;
         --
         Battery_Level_Sufficient_For_Flight : Boolean := False;
         Battery_Status                      : Pulsar.Battery_Manager.Types.T_Battery_Manager_Status := Pulsar.Battery_Manager.Types.Initialization;
      end record;

end Pulsar.Battery_Manager.Core;
