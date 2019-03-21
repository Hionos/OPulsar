package body Pulsar.State_Machine.Core is

   ----------------------------------------------------------------------------
   -- New_And_Initialize                                                     --
   ----------------------------------------------------------------------------
   function New_And_Initialize (Battery_Manager_Interface      : in not null Pulsar.Battery_Manager.Core.T_Battery_Manager_Class_Access;
                                Navigation_Reference_Interface : in not null Pulsar.Navigation_Reference.Core.T_Navigation_Reference_Class_Access;
                                Remote_Control_Interface       : in not null Pulsar.Remote_Control.Core.T_Remote_Control_Class_Access;
                                Notification_Manager_Interface : in not null Pulsar.Notification_Manager.Core.T_Notification_Manager_Class_Access;
                                Flight_Control_Interface       : in not null Pulsar.Flight_Control.Core.T_Flight_Control_Class_Access;
                                Logger_Interface               : in not null Pulsar.Logger.Core.T_Logger_Class_Access)
                                return not null T_State_Machine_Class_Access is
   begin
      return new T_State_Machine'(Selector                       => Pulsar.State_Machine.Selector.Core.New_And_Initialize (Battery_Manager_Interface,
                                                                                                                           Navigation_Reference_Interface,
                                                                                                                           Remote_Control_Interface),
                                  Interpreter                    => Pulsar.State_Machine.Interpreter.Core.New_And_Initialize (Remote_Control_Interface,
                                                                                                                              Logger_Interface),
                                  Notification_Manager_Interface => Notification_Manager_Interface,
                                  Flight_Control_Interface       => Flight_Control_Interface);
   end New_And_Initialize;

   ----------------------------------------------------------------------------
   -- Update                                                                 --
   ----------------------------------------------------------------------------
   procedure Update (This : in out T_State_Machine) is
   begin
      This.Selector.Update;

      This.Interpreter.Set_State (This.Selector.Get_State);

      This.Interpreter.Update;

      This.Notification_Manager_Interface.Set_Notification_Status (This.Interpreter.Get_Notification);
      This.Flight_Control_Interface.Set_Mode (This.Interpreter.Get_Flight_Mode);
   end Update;

   ----------------------------------------------------------------------------
   -- Get_State                                                              --
   ----------------------------------------------------------------------------
   function Get_State (This : in T_State_Machine) return Pulsar.State_Machine.Types.T_State_Machine_State is
   begin
      return This.Selector.Get_State;
   end Get_State;

   ----------------------------------------------------------------------------
   -- Get_Flight_Mode                                                        --
   ----------------------------------------------------------------------------
   function Get_Flight_Mode (This : in T_State_Machine) return Pulsar.Flight_Control.Types.T_Flight_Mode is
   begin
      return This.Interpreter.Get_Flight_Mode;
   end Get_Flight_Mode;

end Pulsar.State_Machine.Core;
