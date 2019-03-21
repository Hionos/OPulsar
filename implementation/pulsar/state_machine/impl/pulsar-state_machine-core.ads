-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This package provides routines to handle the State Machine component      --
-------------------------------------------------------------------------------

with Pulsar.Battery_Manager.Core;
with Pulsar.Navigation_Reference.Core;
with Pulsar.Remote_Control.Core;
with Pulsar.Notification_Manager.Core;
with Pulsar.Flight_Control.Core;
with Pulsar.Logger.Core;
with Pulsar.State_Machine.Selector.Core;
with Pulsar.State_Machine.Interpreter.Core;

with Pulsar.State_Machine.Types;
with Pulsar.Flight_Control.Types;

package Pulsar.State_Machine.Core is

   --  Type defining the class object
   type T_State_Machine is tagged private;

   --  Type defining a pointer to the class object
   type T_State_Machine_Class_Access is access all T_State_Machine'Class;

   ----------------------------------------------------------------------------
   -- REQ: Battery_Manager_Interface      is not null
   --      Navigation_Reference_Interface is not null
   --      Remote_Control_Interface       is not null
   --      Notification_Manager_Interface is not null
   --      Flight_Control_Interface       is not null
   --      Logger_Interface               is not null
   -- ENS: A new instance of T_State_Machine is returned
   ----------------------------------------------------------------------------
   function New_And_Initialize (Battery_Manager_Interface      : in not null Pulsar.Battery_Manager.Core.T_Battery_Manager_Class_Access;
                                Navigation_Reference_Interface : in not null Pulsar.Navigation_Reference.Core.T_Navigation_Reference_Class_Access;
                                Remote_Control_Interface       : in not null Pulsar.Remote_Control.Core.T_Remote_Control_Class_Access;
                                Notification_Manager_Interface : in not null Pulsar.Notification_Manager.Core.T_Notification_Manager_Class_Access;
                                Flight_Control_Interface       : in not null Pulsar.Flight_Control.Core.T_Flight_Control_Class_Access;
                                Logger_Interface               : in not null Pulsar.Logger.Core.T_Logger_Class_Access)
                                return not null T_State_Machine_Class_Access;

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: The State Machine Selector and Interpreter subcomponents are updated
   ----------------------------------------------------------------------------
   procedure Update (This : in out T_State_Machine);

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: The State Machine State is returned
   ----------------------------------------------------------------------------
   function Get_State (This : in T_State_Machine) return Pulsar.State_Machine.Types.T_State_Machine_State;

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: The Flight Mode is returned
   ----------------------------------------------------------------------------
   function Get_Flight_Mode (This : in T_State_Machine) return Pulsar.Flight_Control.Types.T_Flight_Mode;

private

   type T_State_Machine is tagged
      record
         Selector                       : not null Pulsar.State_Machine.Selector.Core.T_State_Machine_Selector_Class_Access;
         Interpreter                    : not null Pulsar.State_Machine.Interpreter.Core.T_State_Machine_Interpreter_Class_Access;
         Notification_Manager_Interface : not null Pulsar.Notification_Manager.Core.T_Notification_Manager_Class_Access;
         Flight_Control_Interface       : not null Pulsar.Flight_Control.Core.T_Flight_Control_Class_Access;
      end record;

end Pulsar.State_Machine.Core;
