-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                        --
-- This package provides routines to handle a Transition of a state machine --
-------------------------------------------------------------------------------

with Pulsar.State_Machine.Types;

package Pulsar.State_Machine.Selector.Transition is

   -- Type defining the class object
   type T_Transition (Target : Pulsar.State_Machine.Types.T_State_Machine_State) is abstract tagged limited private;

   -- Type defining a pointer to the class object
   type T_Transition_Class_Access is access all T_Transition'Class;

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: The target state is returned
   ----------------------------------------------------------------------------
   function Get_Target_State (This : in T_Transition) return Pulsar.State_Machine.Types.T_State_Machine_State;

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: If the transition is activable True is returned, otherwise False is
   --      returned
   ----------------------------------------------------------------------------
   function Is_Activable (This : in T_Transition) return Boolean is abstract;

private
   type T_Transition (Target : Pulsar.State_Machine.Types.T_State_Machine_State) is abstract tagged limited
      record
         Target_State : Pulsar.State_Machine.Types.T_State_Machine_State := Target;
      end record;

end Pulsar.State_Machine.Selector.Transition;
