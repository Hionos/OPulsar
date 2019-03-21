package body Pulsar.Autopilot is

   ----------------------------------------------------------------------------
   -- New_And_Initialize                                                     --
   ----------------------------------------------------------------------------
   function New_And_Initialize (Hardware_Factory : not null Boards.Hardware_Factory.T_Hardware_Factory_Class_Access) return not null T_Autopilot_Class_Access is
      Battery_Manager_Component      : constant Pulsar.Battery_Manager.Core.T_Battery_Manager_Class_Access           :=
         Pulsar.Battery_Manager.Core.New_And_Initialize (Hardware_Factory.Get_Battery);
      Navigation_Reference_Component : constant Pulsar.Navigation_Reference.Core.T_Navigation_Reference_Class_Access :=
         Pulsar.Navigation_Reference.Core.New_And_Initialize (Hardware_Factory.Get_Imu);
      Remote_Control_Component       : constant Pulsar.Remote_Control.Core.T_Remote_Control_Class_Access             :=
         Pulsar.Remote_Control.Core.New_And_Initialize (Hardware_Factory.Get_Remote_Control);
      Motors_Mixing_Component        : constant Pulsar.Motors_Mixing.Core.T_Motors_Mixing_Class_Access               :=
         Pulsar.Motors_Mixing.Core.New_And_Initialize (Hardware_Factory.Get_Motors);
      Flight_Control_Component       : constant Pulsar.Flight_Control.Core.T_Flight_Control_Class_Access             :=
         Pulsar.Flight_Control.Core.New_And_Initialize(Navigation_Reference_Component,
                                                       Remote_Control_Component,
                                                       Motors_Mixing_Component);
      Notification_Manager_Component : constant Pulsar.Notification_Manager.Core.T_Notification_Manager_Class_Access :=
        Pulsar.Notification_Manager.Core.New_And_Initialize (Hardware_Factory.Get_Light_Signal);
      Logger_Component               : constant Pulsar.Logger.Core.T_Logger_Class_Access                             :=
        Pulsar.Logger.Core.New_And_Initialize (Logger_Stream_Interface => Hardware_Factory.Get_Logger_Stream);
      State_Machine_Component : constant Pulsar.State_Machine.Core.T_State_Machine_Class_Access                      :=
         Pulsar.State_Machine.Core.New_And_Initialize (Battery_Manager_Interface      => Battery_Manager_Component,
                                                       Navigation_Reference_Interface => Navigation_Reference_Component,
                                                       Remote_Control_Interface       => Remote_Control_Component,
                                                       Notification_Manager_Interface => Notification_Manager_Component,
                                                       Flight_Control_Interface       => Flight_Control_Component,
                                                       Logger_Interface               => Logger_Component);
   begin
      return new T_Autopilot'(The_Hardware_Factory             => Hardware_Factory,
                              Battery_Manager_Component        => Battery_Manager_Component,
                              Remote_Control_Component         => Remote_Control_Component,
                              Navigation_Reference_Component   => Navigation_Reference_Component,
                              State_Machine_Component          => State_Machine_Component,
                              Notification_Manager_Component   => Notification_Manager_Component,
                              Motors_Mixing_Component          => Motors_Mixing_Component,
                              Flight_Control_Component         => Flight_Control_Component,
                              Logger_Component                 => Logger_Component);
   end New_And_Initialize;

   ----------------------------------------------------------------------------
   -- Update                                                                 --
   ----------------------------------------------------------------------------
   procedure Update (This : in out T_Autopilot) is
   begin
      --  Update input components (system inputs)
      This.Battery_Manager_Component.Update;
      This.Navigation_Reference_Component.Update;
      This.Remote_Control_Component.Update;

      --  Update the State Machine
      This.State_Machine_Component.Update;

      --  Update the Flight Control
      This.Flight_Control_Component.Update;

      --  Update output components (system outputs)
      This.Notification_Manager_Component.Update;
      This.Motors_Mixing_Component.Update;

      --  Update external Logger component
      This.Logger_Component.Update;
   end Update;

end Pulsar.Autopilot;
