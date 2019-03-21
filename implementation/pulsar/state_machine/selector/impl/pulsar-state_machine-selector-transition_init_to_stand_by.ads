-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                        --
-- This package provides routines to handle a Transition "Init to Stand By" --
-- states of Pulsar                                                         --
-------------------------------------------------------------------------------

with Pulsar.Battery_Manager.Core;
with Pulsar.Navigation_Reference.Core;

with Pulsar.State_Machine.Selector.Transition;

package Pulsar.State_Machine.Selector.Transition_Init_To_Stand_By is

   -- Type defining the class object
   type T_Transition_Init_To_Stand_By is new Pulsar.State_Machine.Selector.Transition.T_Transition with private;

   -- Type defining a pointer to the class object
   type T_Transition_Init_To_Stand_By_Class_Access is access all T_Transition_Init_To_Stand_By'Class;

   ----------------------------------------------------------------------------
   -- REQ: Battery_Manager_Interface is not null and
   --      Navigation_Reference_Interface is not null
   -- ENS: A new instance of T_Transition_Init_To_Stand_By is returned
   ----------------------------------------------------------------------------
   not overriding
   function New_And_Initialize (Battery_Manager_Interface      : in not null Pulsar.Battery_Manager.Core.T_Battery_Manager_Class_Access;
                                Navigation_Reference_Interface : in not null Pulsar.Navigation_Reference.Core.T_Navigation_Reference_Class_Access)
                                return not null T_Transition_Init_To_Stand_By_Class_Access;

   overriding
   function Is_Activable (This : in T_Transition_Init_To_Stand_By) return Boolean;

private

   type T_Transition_Init_To_Stand_By is new Pulsar.State_Machine.Selector.Transition.T_Transition with
      record
         Battery_Manager_Interface      : not null Pulsar.Battery_Manager.Core.T_Battery_Manager_Class_Access;
         Navigation_Reference_Interface : not null Pulsar.Navigation_Reference.Core.T_Navigation_Reference_Class_Access;
      end record;

end Pulsar.State_Machine.Selector.Transition_Init_To_Stand_By;
