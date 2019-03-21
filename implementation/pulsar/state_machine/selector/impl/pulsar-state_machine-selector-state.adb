package body Pulsar.State_Machine.Selector.State is

   ----------------------------------------------------------------------------
   -- New_And_Initialize                                                     --
   ----------------------------------------------------------------------------
   function New_And_Initialize (State_Label           : in Pulsar.State_Machine.Types.T_State_Machine_State;
                                Number_Of_Transitions : in Natural) return not null T_State_Class_Access is
   begin
      return new T_State (State_Label           => State_Label,
                          Number_Of_Transitions => Number_Of_Transitions);
   end New_And_Initialize;

   ----------------------------------------------------------------------------
   -- Add_Transition                                                         --
   ----------------------------------------------------------------------------
   procedure Add_Transition (This       : in out T_State;
                             Transition : in Pulsar.State_Machine.Selector.Transition.T_Transition_Class_Access) is
   begin
      This.Current_Number_Of_Transitions := This.Current_Number_Of_Transitions + 1;
      This.Transitions_List (This.Current_Number_Of_Transitions) := Transition;
   end Add_Transition;

   ----------------------------------------------------------------------------
   -- Get_Next_State                                                         --
   ----------------------------------------------------------------------------
   function Get_Next_State (This : in T_State) return Pulsar.State_Machine.Types.T_State_Machine_State is
      Next_State : Pulsar.State_Machine.Types.T_State_Machine_State := This.State;
   begin
      for Index in 1 .. This.Current_Number_Of_Transitions loop
         if This.Transitions_List (Index).Is_Activable then
            Next_State := This.Transitions_List (Index).Get_Target_State;
            exit;
         end if;
         -- MCDC Problem, in relation with Ticket 181 (to be resolved)
      end loop;

      return Next_State;
   end Get_Next_State;

end Pulsar.State_Machine.Selector.State;
