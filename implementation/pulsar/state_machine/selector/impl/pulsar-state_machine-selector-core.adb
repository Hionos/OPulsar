with Pulsar.State_Machine.Selector.Transition;
with Pulsar.State_Machine.Selector.Transition_To_Fault;
with Pulsar.State_Machine.Selector.Transition_Init_To_Stand_By;
with Pulsar.State_Machine.Selector.Transition_Manual_To_Stand_By;
with Pulsar.State_Machine.Selector.Transition_Stand_By_To_Manual;

with Pulsar.State_Machine.Types; use Pulsar.State_Machine.Types;

package body Pulsar.State_Machine.Selector.Core is

   ----------------------------------------------------------------------------
   -- New_And_Initialize                                                     --
   ----------------------------------------------------------------------------
   function New_And_Initialize (Battery_Manager_Interface      : in not null Pulsar.Battery_Manager.Core.T_Battery_Manager_Class_Access;
                                Navigation_Reference_Interface : in not null Pulsar.Navigation_Reference.Core.T_Navigation_Reference_Class_Access;
                                Remote_Control_Interface       : in not null Pulsar.Remote_Control.Core.T_Remote_Control_Class_Access)
                                return not null T_State_Machine_Selector_Class_Access is
      --  Declare the different states that will be used in the state machine
      --  To add a new state, simply :
      --     - Add a new enum in the T_State_Machine_States type
      --     - Declare here a new State_xxx object with the state enum and the correct number of transition
      --     - Add the transitions associated to the state
      State_Init   : Constant Pulsar.State_Machine.Selector.State.T_State_Class_Access :=
        Pulsar.State_Machine.Selector.State.New_And_Initialize (State_Label => Init, Number_Of_Transitions => 2);

      State_Manual : Constant Pulsar.State_Machine.Selector.State.T_State_Class_Access :=
        Pulsar.State_Machine.Selector.State.New_And_Initialize (State_Label => Manual, Number_Of_Transitions => 2);

      State_Fault  : Constant Pulsar.State_Machine.Selector.State.T_State_Class_Access :=
        Pulsar.State_Machine.Selector.State.New_And_Initialize (State_Label => Fault, Number_Of_Transitions => 0);

      State_Standby: Constant Pulsar.State_Machine.Selector.State.T_State_Class_Access :=
        Pulsar.State_Machine.Selector.State.New_And_Initialize (State_Label => Stand_By, Number_Of_Transitions => 2);

      -- Transitions
      T_To_Fault           : constant Pulsar.State_Machine.Selector.Transition.T_Transition_Class_Access := Pulsar.State_Machine.Selector.Transition.T_Transition_Class_Access (
        Pulsar.State_Machine.Selector.Transition_To_Fault.New_And_Initialize (Battery_Manager_Interface      => Battery_Manager_Interface,
                                                                              Navigation_Reference_Interface => Navigation_Reference_Interface));

      T_Init_To_Stand_By   : constant Pulsar.State_Machine.Selector.Transition.T_Transition_Class_Access := Pulsar.State_Machine.Selector.Transition.T_Transition_Class_Access (
        Pulsar.State_Machine.Selector.Transition_Init_To_Stand_By.New_And_Initialize (Battery_Manager_Interface      => Battery_Manager_Interface,
                                                                                      Navigation_Reference_Interface => Navigation_Reference_Interface));

      T_Stand_By_To_Manual : constant Pulsar.State_Machine.Selector.Transition.T_Transition_Class_Access := Pulsar.State_Machine.Selector.Transition.T_Transition_Class_Access (
        Pulsar.State_Machine.Selector.Transition_Stand_By_To_Manual.New_And_Initialize (Navigation_Reference_Interface => Navigation_Reference_Interface,
                                                                                        Remote_Control_Interface       => Remote_Control_Interface));

      T_Manual_To_Stand_By : constant Pulsar.State_Machine.Selector.Transition.T_Transition_Class_Access := Pulsar.State_Machine.Selector.Transition.T_Transition_Class_Access (
        Pulsar.State_Machine.Selector.Transition_Manual_To_Stand_By.New_And_Initialize (Remote_Control_Interface => Remote_Control_Interface));

   begin
      -- Build the State Machine by associating the different transitions to the corresponding states
      State_Init.Add_Transition (T_To_Fault);
      State_Init.Add_Transition (T_Init_To_Stand_By);

      State_Standby.Add_Transition(T_To_Fault);
      State_Standby.Add_Transition(T_Stand_By_To_Manual);

      State_Manual.Add_Transition (T_To_Fault);
      State_Manual.Add_Transition (T_Manual_To_Stand_By);

      -- Initialize the state machine object and reference the init state by default
      return new T_State_Machine_Selector'(State       => Init,
                                           States_List => T_State_List'(Init     => State_Init,
                                                                        Manual   => State_Manual,
                                                                        Fault    => State_Fault,
                                                                        Stand_By => State_Standby));
   end New_And_Initialize;

   ----------------------------------------------------------------------------
   -- Get_State                                                      --
   ----------------------------------------------------------------------------
   function Get_State (This : in T_State_Machine_Selector) return Pulsar.State_Machine.Types.T_State_Machine_State is
     (This.State);

   ----------------------------------------------------------------------------
   -- Update                                                                 --
   ----------------------------------------------------------------------------
   procedure Update (This : in out T_State_Machine_Selector) is
   begin
      This.State := This.States_List (This.State).Get_Next_State;
   end Update;

end Pulsar.State_Machine.Selector.Core;
