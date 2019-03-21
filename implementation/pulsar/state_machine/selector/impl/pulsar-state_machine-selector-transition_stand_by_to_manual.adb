with Pulsar.Remote_Control.Types; use Pulsar.Remote_Control.Types;

with Pulsar.State_Machine.Types;

package body Pulsar.State_Machine.Selector.Transition_Stand_By_To_Manual is

   ----------------------------------------------------------------------------
   -- New_And_Initialize                                                     --
   ----------------------------------------------------------------------------
   not overriding
   function New_And_Initialize (Navigation_Reference_Interface : in not null Pulsar.Navigation_Reference.Core.T_Navigation_Reference_Class_Access;
                                Remote_Control_Interface       : in not null Pulsar.Remote_Control.Core.T_Remote_Control_Class_Access)
                                return not null T_Transition_Stand_By_To_Manual_Class_Access is
   begin
      return new T_Transition_Stand_By_To_Manual'(Pulsar.State_Machine.Selector.Transition.T_Transition with
                                                  Target                         => Pulsar.State_Machine.Types.Manual,
                                                  Navigation_Reference_Interface => Navigation_Reference_Interface,
                                                  Remote_Control_Interface       => Remote_Control_Interface);
   end New_And_Initialize;

   ----------------------------------------------------------------------------
   -- Is_Activable                                                           --
   ----------------------------------------------------------------------------
   overriding
   function Is_Activable (This : T_Transition_Stand_By_To_Manual) return Boolean is
     (This.Navigation_Reference_Interface.Is_Immobility_Confirmed and
      not This.Remote_Control_Interface.Is_Timeout_Detected and
      This.Remote_Control_Interface.Is_In_Neutral_Position and
      This.Remote_Control_Interface.Get_Arming_Command = Arm);
      -- The condition on the current State is ensured by contruction of the State (Stand_By State)

end Pulsar.State_Machine.Selector.Transition_Stand_By_To_Manual;
