-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This package provides routines to handle a Transition "Manual to StandBy" --
-- states of Pulsar                                                          --
-------------------------------------------------------------------------------

with Pulsar.Remote_Control.Core;
with Pulsar.State_Machine.Selector.Transition;

package Pulsar.State_Machine.Selector.Transition_Manual_To_Stand_By is

   -- Type defining the class object
   type T_Transition_Manual_To_Stand_By is new Pulsar.State_Machine.Selector.Transition.T_Transition with private;

   -- Type defining a pointer to the class object
   type T_Transition_Manual_To_Stand_By_Class_Access is access all T_Transition_Manual_To_Stand_By'Class;

   ----------------------------------------------------------------------------
   -- REQ: Remote_Control_Interface is not null
   -- ENS: A new instance of T_Transition_Manual_To_Stand_By is returned
   ----------------------------------------------------------------------------
   not overriding
   function New_And_Initialize (Remote_Control_Interface : in not null Pulsar.Remote_Control.Core.T_Remote_Control_Class_Access)
                                return not null T_Transition_Manual_To_Stand_By_Class_Access;

   overriding
   function Is_Activable (This : in T_Transition_Manual_To_Stand_By) return Boolean;

private

   type T_Transition_Manual_To_Stand_By is new Pulsar.State_Machine.Selector.Transition.T_Transition with
      record
         Remote_Control_Interface : not null Pulsar.Remote_Control.Core.T_Remote_Control_Class_Access;
      end record;

end Pulsar.State_Machine.Selector.Transition_Manual_To_Stand_By;
