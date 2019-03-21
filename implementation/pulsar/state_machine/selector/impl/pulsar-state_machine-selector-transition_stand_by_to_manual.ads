-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This package provides routines to handle a Transition                     --
-- "Manual to Stand By" states of Pulsar                                     --
-------------------------------------------------------------------------------

with Pulsar.Navigation_Reference.Core;
with Pulsar.Remote_Control.Core;

with Pulsar.State_Machine.Selector.Transition;

package Pulsar.State_Machine.Selector.Transition_Stand_By_To_Manual is

   -- Type defining the class object
   type T_Transition_Stand_By_To_Manual is new Pulsar.State_Machine.Selector.Transition.T_Transition with private;

   -- Type defining a pointer to the class object
   type T_Transition_Stand_By_To_Manual_Class_Access is access all T_Transition_Stand_By_To_Manual'Class;

   ----------------------------------------------------------------------------
   -- REQ: Inertial_Platform_Interface is not null and Remote_Control_Interface
   --      is not null
   -- ENS: A new instance of T_Transition_Stand_By_To_Manual is returned
   ----------------------------------------------------------------------------
   not overriding
   function New_And_Initialize (Navigation_Reference_Interface : in not null Pulsar.Navigation_Reference.Core.T_Navigation_Reference_Class_Access;
                                Remote_Control_Interface       : in not null Pulsar.Remote_Control.Core.T_Remote_Control_CLass_Access)
                                return not null T_Transition_Stand_By_To_Manual_Class_Access;

   overriding
   function Is_Activable (This : in T_Transition_Stand_By_To_Manual) return Boolean;

private

   type T_Transition_Stand_By_To_Manual is new Pulsar.State_Machine.Selector.Transition.T_Transition with
      record
         Navigation_Reference_Interface : not null Pulsar.Navigation_Reference.Core.T_Navigation_Reference_Class_Access;
         Remote_Control_Interface       : not null Pulsar.Remote_Control.Core.T_Remote_Control_Class_Access;
      end record;

end Pulsar.State_Machine.Selector.Transition_Stand_By_To_Manual;
