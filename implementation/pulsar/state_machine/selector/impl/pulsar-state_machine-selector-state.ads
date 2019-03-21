-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This package provides routines to handle a State of a state machine       --
-------------------------------------------------------------------------------

with Pulsar.State_Machine.Types;
with Pulsar.State_Machine.Selector.Transition;

package Pulsar.State_Machine.Selector.State is

   -- Type defining the class object
   type T_State (State_Label           : Pulsar.State_Machine.Types.T_State_Machine_State;
                 Number_Of_Transitions : Natural) is tagged limited private;

   -- Type defining a pointer to the class object
   type T_State_Class_Access is access all T_State'Class;

   -- Type defining the list of attached transition
   type T_Transitions_List is array (Natural range <>) of Pulsar.State_Machine.Selector.Transition.T_Transition_Class_Access;

   ----------------------------------------------------------------------------
   -- REQ: State_Label is a T_State_Machine_State and Number_Of_Transitions is
   --      a Natural
   -- ENS: A new instance of T_State is returned
   ----------------------------------------------------------------------------
   function New_And_Initialize (State_Label           : in Pulsar.State_Machine.Types.T_State_Machine_State;
                                Number_Of_Transitions : in Natural) return not null T_State_Class_Access;

   ----------------------------------------------------------------------------
   -- REQ: Transition is a T_Transition class access and
   --      Current_Number_Of_Transitions < Number_Of_Transitions
   -- ENS: Transition has been added to Transitions List
   ----------------------------------------------------------------------------
   procedure Add_Transition (This       : in out T_State;
                             Transition : in Pulsar.State_Machine.Selector.Transition.T_Transition_Class_Access);

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: The next state we can reach is returned
   ----------------------------------------------------------------------------
   function Get_Next_State (This : in T_State) return Pulsar.State_Machine.Types.T_State_Machine_State;

private

   type T_State (State_Label           : Pulsar.State_Machine.Types.T_State_Machine_State;
                 Number_Of_Transitions : Natural) is tagged limited
      record
         State : Pulsar.State_Machine.Types.T_State_Machine_State := State_Label;

         Transitions_List : T_Transitions_List (1 .. Number_Of_Transitions) := (others => null);

         -- Current number of transitions attached to the state
         Current_Number_Of_Transitions : Natural := 0;
      end record;

end Pulsar.State_Machine.Selector.State;
