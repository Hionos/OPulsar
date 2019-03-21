package body Pulsar.State_Machine.Selector.Transition is

   ----------------------------------------------------------------------------
   -- Get_Target_State                                                       --
   ----------------------------------------------------------------------------
   function Get_Target_State (This : in T_Transition) return Pulsar.State_Machine.Types.T_State_Machine_State is
     (This.Target_State);

end Pulsar.State_Machine.Selector.Transition;
