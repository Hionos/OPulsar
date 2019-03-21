-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This package provides routines to handle the State Machine Selector       --
-- subcomponents                                                             --
-------------------------------------------------------------------------------

with Pulsar.Battery_Manager.Core;
with Pulsar.Navigation_Reference.Core;
with Pulsar.Remote_Control.Core;

with Pulsar.State_Machine.Types;
with Pulsar.State_Machine.Selector.State;

package Pulsar.State_Machine.Selector.Core is

   --  Type defining the class object
   type T_State_Machine_Selector is tagged limited private;

   --  Type defining a pointer to the class object
   type T_State_Machine_Selector_Class_Access is access all T_State_Machine_Selector'Class;

   ----------------------------------------------------------------------------
   -- REQ: Battery_Manager_Interface      is not null
   --      Navigation_Reference_Interface is not null
   --      Remote_Control_Interface       is not null
   -- ENS: A new instance of T_State_Machine_Selector is returned
   ----------------------------------------------------------------------------
   function New_And_Initialize (Battery_Manager_Interface      : in not null Pulsar.Battery_Manager.Core.T_Battery_Manager_Class_Access;
                                Navigation_Reference_Interface : in not null Pulsar.Navigation_Reference.Core.T_Navigation_Reference_Class_Access;
                                Remote_Control_Interface       : in not null Pulsar.Remote_Control.Core.T_Remote_Control_Class_Access)
                                return not null T_State_Machine_Selector_Class_Access;

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: The current State is returned in the range of
   --      Pulsar.State_Machine.Types.T_State_Machine_State
   ----------------------------------------------------------------------------
   function Get_State (This : in T_State_Machine_Selector) return Pulsar.State_Machine.Types.T_State_Machine_State;

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: The current state of the state machine is updated
   ----------------------------------------------------------------------------
   procedure Update (This : in out T_State_Machine_Selector);

private

   type T_State_List is array (Pulsar.State_Machine.Types.T_State_Machine_State) of Pulsar.State_Machine.Selector.State.T_State_Class_Access;

   type T_State_Machine_Selector is tagged limited
      record
         State : Pulsar.State_Machine.Types.T_State_Machine_State := Pulsar.State_Machine.Types.Init;

         --  List of all supported states in this state machine
         States_List : T_State_List := (others => null);
      end record;

end Pulsar.State_Machine.Selector.Core;
