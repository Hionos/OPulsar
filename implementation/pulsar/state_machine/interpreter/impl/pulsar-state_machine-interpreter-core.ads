-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This package provides routines to handle the State Machine Interpreter    --
-- sub-module                                                                --
-------------------------------------------------------------------------------

with Pulsar.Remote_Control.Core;
with Pulsar.Logger.Core;

with Pulsar.Flight_Control.Types;
with Pulsar.Notification_Manager.Types;
with Pulsar.State_Machine.Types;

package Pulsar.State_Machine.Interpreter.Core is

   --  Type defining the class object
   type T_State_Machine_Interpreter is tagged limited private;

   --  Type defining a pointer to the class object
   type T_State_Machine_Interpreter_Class_Access is access all T_State_Machine_Interpreter'Class;

   ----------------------------------------------------------------------------
   -- REQ: Remote_Control_Interface is not null
   -- ENS: A new instance of T_State_Machine_Interpreter is returned
   ----------------------------------------------------------------------------
   function New_And_Initialize (Remote_Control_Interface : in not null Pulsar.Remote_Control.Core.T_Remote_Control_Class_Access;
                                Logger_Interface         : in not null Pulsar.Logger.Core.T_Logger_Class_Access)
                                return not null T_State_Machine_Interpreter_Class_Access;

   ----------------------------------------------------------------------------
   -- REQ: State is the current state machine state
   -- ENS: State is set to State
   ----------------------------------------------------------------------------
   procedure Set_State (This  : in out T_State_Machine_Interpreter;
                        State : in Pulsar.State_Machine.Types.T_State_Machine_State);

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: The notification status is returned in the range of
   --      Pulsar.Notification_Manager.Types.T_Notification_Status
   ----------------------------------------------------------------------------
   function Get_Notification (This : in out T_State_Machine_Interpreter) return Pulsar.Notification_Manager.Types.T_Notification_Status;

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: The flight mode is returned in the range of
   --      Pulsar.Flight_Modes.Types.T_Flight_Mode
   ----------------------------------------------------------------------------
   function Get_Flight_Mode (This : in out T_State_Machine_Interpreter) return Pulsar.Flight_Control.Types.T_Flight_Mode;

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: Notification and Flight Mode status are updated
   ----------------------------------------------------------------------------
   procedure Update (This : in out T_State_Machine_Interpreter);

private

   type T_Text_Message_Type is (Stand_By, Manual, Fault);

   type T_State_Machine_Interpreter is tagged limited
      record
         Remote_Control_Interface : Pulsar.Remote_Control.Core.T_Remote_Control_Class_Access := null;
         Logger_Interface         : Pulsar.Logger.Core.T_Logger_Class_Access := null;
         State                    : Pulsar.State_Machine.Types.T_State_Machine_State := Pulsar.State_Machine.Types.Init;
         Previous_State           : Pulsar.State_Machine.Types.T_State_Machine_State := Pulsar.State_Machine.Types.Init;
         Notification             : Pulsar.Notification_Manager.Types.T_Notification_Status := Pulsar.Notification_Manager.Types.Initialization;
         Flight_Mode              : Pulsar.Flight_Control.Types.T_Flight_Mode := Pulsar.Flight_Control.Types.Stopped;
         Text_Message             : T_Text_Message_Type := Stand_By;
      end record;

end Pulsar.State_Machine.Interpreter.Core;
