-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This package provides routines to handle the Notification Manager         --
-- component                                                                 --
-------------------------------------------------------------------------------

with Hal.Light_Signal;
with Pulsar.Notification_Manager.Types;

package Pulsar.Notification_Manager.Core is

   -- Type defining the class object
   type T_Notification_Manager is tagged private;

   -- Type defining a pointer to the class object
   type T_Notification_Manager_Class_Access is access all T_Notification_Manager'Class;

   ----------------------------------------------------------------------------
   -- REQ: Light_Signal_Interface is not null
   -- ENS: Return new instance of T_Notification_Manager
   ----------------------------------------------------------------------------
   function New_And_Initialize (Light_Signal_Interface : in not null Hal.Light_Signal.T_Light_Signal_Class_Access)
      return not null T_Notification_Manager_Class_Access;

   ----------------------------------------------------------------------------
   -- REQ : Notification_Status is in range
   --       Pulsar.Notification_Manager.Types.T_Notification_Status
   -- ENS : Notification Manager status is set with Notification_Status value
   ----------------------------------------------------------------------------
   procedure Set_Notification_Status (This                : in out T_Notification_Manager;
                                      Notification_Status : in Pulsar.Notification_Manager.Types.T_Notification_Status);

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: Light signal is set according to the notification manager status
   ----------------------------------------------------------------------------
   procedure Update (This : in out T_Notification_Manager);

private

   type T_Toggling_States is array (Boolean) of Hal.Light_Signal.T_Light_State;

   -- Constrained positive float type representing the toggling period in second
   subtype T_Toggling_Period is Float range 0.0 .. Float'Last;

   ----------------------------------------------------------------------------
   -- REQ: First_State, Second_State are in range Hal.Light_Signal.T_Light_State,
   --      Toggling_Period is >= 0.0
   -- ENS: Toggling conditions are set to match current notification status
   ----------------------------------------------------------------------------
   procedure Set_Toggling_Conditions (This                      : in out T_Notification_Manager'Class;
                                      First_State, Second_State : in Hal.Light_Signal.T_Light_State := Hal.Light_Signal.OFF;
                                      Toggling_Period           : in T_Toggling_Period := 0.0);

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: Current light signal state to apply is returned when toggling
   ----------------------------------------------------------------------------
   function Current_Toggling_State (This : in out T_Notification_Manager'Class) return Hal.Light_Signal.T_Light_State;

   type T_Notification_Manager is tagged
      record
         Light_Signal_Interface : not null Hal.Light_Signal.T_Light_Signal_Class_Access;
         Notification_Status    : Pulsar.Notification_Manager.Types.T_Notification_Status := Pulsar.Notification_Manager.Types.Initialization;
         Solid_State            : Hal.Light_Signal.T_Light_State                          := Hal.Light_Signal.OFF;
         -- Toggling conditions
         Current_Number_Of_Cycles            : Natural           := 0;
         First_Light_State                   : Boolean           := False;
         Toggling_States                     : T_Toggling_States := (True  => Hal.Light_Signal.OFF,
                                                                     False => Hal.Light_Signal.OFF);
         Number_Of_Cycles_In_Toggling_Period : Natural           := 0;
      end record;

end Pulsar.Notification_Manager.Core;
