with Pulsar.Navigation_Reference.Types; use Pulsar.Navigation_Reference.Types;

with Pulsar.State_Machine.Types;

package body Pulsar.State_Machine.Selector.Transition_Init_To_Stand_By is

   ----------------------------------------------------------------------------
   -- New_And_Initialize                                                     --
   ----------------------------------------------------------------------------
   not overriding
   function New_And_Initialize (Battery_Manager_Interface      : in not null Pulsar.Battery_Manager.Core.T_Battery_Manager_Class_Access;
                                Navigation_Reference_Interface : in not null Pulsar.Navigation_Reference.Core.T_Navigation_Reference_Class_Access)
                                return not null T_Transition_Init_To_Stand_By_Class_Access is
   begin
      return new T_Transition_Init_To_Stand_By'(Pulsar.State_Machine.Selector.Transition.T_Transition with
                                                Target                         => Pulsar.State_Machine.Types.Stand_By,
                                                Battery_Manager_Interface      => Battery_Manager_Interface,
                                                Navigation_Reference_Interface => Navigation_Reference_Interface);
   end New_And_Initialize;

   ----------------------------------------------------------------------------
   -- Is_Activable                                                           --
   ----------------------------------------------------------------------------
   overriding
   function Is_Activable (This : in T_Transition_Init_To_Stand_By) return Boolean is
     (This.Navigation_Reference_Interface.Get_Navigation_Reference_Status = Operational and
      This.Battery_Manager_Interface.Is_Battery_Level_Sufficient_For_Flight);
      -- The condition on the current State is ensured by contruction of the State (Init State)

end Pulsar.State_Machine.Selector.Transition_Init_To_Stand_By;
