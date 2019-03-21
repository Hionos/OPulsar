-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This package provides main interface for the autopilot                    --
-------------------------------------------------------------------------------

with Boards.Hardware_Factory;
with Pulsar.Battery_Manager.Core;
with Pulsar.Remote_Control.Core;
with Pulsar.Navigation_Reference.Core;
with Pulsar.State_Machine.Core;
with Pulsar.Notification_Manager.Core;
with Pulsar.Motors_Mixing.Core;
with Pulsar.Flight_Control.Core;
with Pulsar.Logger.Core;

package Pulsar.Autopilot is

   -- Type defining the class object
   type T_Autopilot is tagged private;

   -- Type defining a pointer to the class object
   type T_Autopilot_Class_Access is access all T_Autopilot'Class;

   ----------------------------------------------------------------------------
   -- REQ: Hardware_Factory is not null
   -- ENS: Return new instance of T_Autopilot
   ----------------------------------------------------------------------------
   function New_And_Initialize (Hardware_Factory : not null Boards.Hardware_Factory.T_Hardware_Factory_Class_Access) return not null T_Autopilot_Class_Access;

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: Updates all components of the system
   ----------------------------------------------------------------------------
   procedure Update (This : in out T_Autopilot);

private

   type T_Autopilot is tagged
      record
         The_Hardware_Factory             : not null Boards.Hardware_Factory.T_Hardware_Factory_Class_Access;

         Battery_Manager_Component        : not null Pulsar.Battery_Manager.Core.T_Battery_Manager_Class_Access;
         Remote_Control_Component         : not null Pulsar.Remote_Control.Core.T_Remote_Control_Class_Access;
         Navigation_Reference_Component   : not null Pulsar.Navigation_Reference.Core.T_Navigation_Reference_Class_Access;
         State_Machine_Component          : not null Pulsar.State_Machine.Core.T_State_Machine_Class_Access;
         Notification_Manager_Component   : not null Pulsar.Notification_Manager.Core.T_Notification_Manager_Class_Access ;
         Motors_Mixing_Component          : not null Pulsar.Motors_Mixing.Core.T_Motors_Mixing_Class_Access;
         Flight_Control_Component         : not null Pulsar.Flight_Control.Core.T_Flight_Control_Class_Access;
         Logger_Component                 : not null Pulsar.Logger.Core.T_Logger_Class_Access;
      end record;

end Pulsar.Autopilot;
