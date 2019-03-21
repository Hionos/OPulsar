with Pulsar.Remote_Control.Types; use Pulsar.Remote_Control.Types;

with Pulsar.State_Machine.Types;

package body Pulsar.State_Machine.Selector.Transition_Manual_To_Stand_By is

   ----------------------------------------------------------------------------
   -- New_And_Initialize                                                     --
   ----------------------------------------------------------------------------
   not overriding
   function New_And_Initialize (Remote_Control_Interface : in not null Pulsar.Remote_Control.Core.T_Remote_Control_Class_Access)
                                return not null T_Transition_Manual_To_Stand_By_Class_Access is
   begin
      return new T_Transition_Manual_To_Stand_By'(Pulsar.State_Machine.Selector.Transition.T_Transition with
                                                  Target                   => Pulsar.State_Machine.Types.Stand_By,
                                                  Remote_Control_Interface => Remote_Control_Interface);
   end New_And_Initialize;

   ----------------------------------------------------------------------------
   -- Is_Activable                                                           --
   ----------------------------------------------------------------------------
   overriding
   function Is_Activable (This : in T_Transition_Manual_To_Stand_By) return Boolean is
     (This.Remote_Control_Interface.Get_Arming_Command = Disarm or
      This.Remote_Control_Interface.Is_Timeout_Detected);
      -- The condition on the current State is ensured by contruction of the State (Manual State)

end Pulsar.State_Machine.Selector.Transition_Manual_To_Stand_By;
