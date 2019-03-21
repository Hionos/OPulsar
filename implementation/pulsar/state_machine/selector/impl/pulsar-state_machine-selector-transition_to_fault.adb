with Pulsar.Battery_Manager.Types;      use Pulsar.Battery_Manager.Types;
with Pulsar.Navigation_Reference.Types; use Pulsar.Navigation_Reference.Types;

with Pulsar.State_Machine.Types;

package body Pulsar.State_Machine.Selector.Transition_To_Fault is

   ----------------------------------------------------------------------------
   -- New_And_Initialize                                                     --
   ----------------------------------------------------------------------------
   not overriding
   function New_And_Initialize (Battery_Manager_Interface      : in not null Pulsar.Battery_Manager.Core.T_Battery_Manager_Class_Access;
                                Navigation_Reference_Interface : in not null Pulsar.Navigation_Reference.Core.T_Navigation_Reference_Class_Access)
                                return not null T_Transition_To_Fault_Class_Access is
   begin
      return new  T_Transition_To_Fault'(Pulsar.State_Machine.Selector.Transition.T_Transition with
                                         Target                         => Pulsar.State_Machine.Types.Fault,
                                         Battery_Manager_Interface      => Battery_Manager_Interface,
                                         Navigation_Reference_Interface => Navigation_Reference_Interface);
   end New_And_Initialize;

   ----------------------------------------------------------------------------
   -- Is_Activable                                                           --
   ----------------------------------------------------------------------------
   overriding
   function Is_Activable (This : in T_Transition_To_Fault) return Boolean is
      Battery_Level_Consideration : constant Boolean := This.Battery_Manager_Interface.Get_Battery_Status = Pulsar.Battery_Manager.Types.Operational and
                                                        not This.Battery_Manager_Interface.Is_Battery_Level_Sufficient_For_Flight;
   begin
     return This.Navigation_Reference_Interface.Get_Navigation_Reference_Status = Failure or
            This.Battery_Manager_Interface.Get_Battery_Status = Failure or
            Battery_Level_Consideration;
   end Is_Activable;

end Pulsar.State_Machine.Selector.Transition_To_Fault;
