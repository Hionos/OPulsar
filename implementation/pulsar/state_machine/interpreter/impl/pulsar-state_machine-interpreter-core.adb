with Pulsar.State_Machine.Types;  use Pulsar.State_Machine.Types;
with Pulsar.Remote_Control.Types; use Pulsar.Remote_Control.Types;

with Hal.Logger_Stream;

package body Pulsar.State_Machine.Interpreter.Core is

   ----------------------------------------------------------------------------
   -- New_And_Initialize                                                     --
   ----------------------------------------------------------------------------
   function New_And_Initialize (Remote_Control_Interface : in not null Pulsar.Remote_Control.Core.T_Remote_Control_Class_Access;
                                Logger_Interface         : in not null Pulsar.Logger.Core.T_Logger_Class_Access)
                                return not null T_State_Machine_Interpreter_Class_Access is
   begin
      return new T_State_Machine_Interpreter'(Remote_Control_Interface => Remote_Control_Interface,
                                              Logger_Interface         => Logger_Interface,
                                              State                    => Pulsar.State_Machine.Types.Init,
                                              Previous_State           => Pulsar.State_Machine.Types.Init,
                                              Notification             => Pulsar.Notification_Manager.Types.Initialization,
                                              FLight_Mode              => Pulsar.Flight_Control.Types.Stopped,
                                              Text_Message             => Stand_By);
   end New_And_Initialize;

   ----------------------------------------------------------------------------
   -- Set_State                                                              --
   ----------------------------------------------------------------------------
   procedure Set_State (This  : in out T_State_Machine_Interpreter;
                        State : in Pulsar.State_Machine.Types.T_State_Machine_State) is
   begin
      This.Previous_State := This.State;
      This.State := State;
   end;

   ----------------------------------------------------------------------------
   -- Get_Notification                                                       --
   ----------------------------------------------------------------------------
   function Get_Notification (This : in out T_State_Machine_Interpreter) return Pulsar.Notification_Manager.Types.T_Notification_Status is
     (This.Notification);

   ----------------------------------------------------------------------------
   -- Get_Flight_Mode                                                        --
   ----------------------------------------------------------------------------
   function Get_Flight_Mode (This : in out T_State_Machine_Interpreter) return Pulsar.Flight_Control.Types.T_Flight_Mode is
     (This.Flight_Mode);

   ----------------------------------------------------------------------------
   -- Update                                                                 --
   ----------------------------------------------------------------------------
   procedure Update (This : in out T_State_Machine_Interpreter) is
      Text_Message : Hal.Logger_Stream.T_Text_Message := (others => Character'Val(0));
   begin
      --  Update the outputs according to the current state
      case This.State is
         when Pulsar.State_Machine.Types.Init   =>
            This.Notification := Pulsar.Notification_Manager.Types.Initialization;
            This.FLight_Mode  := Pulsar.Flight_Control.Types.Stopped;

         when Pulsar.State_Machine.Types.Stand_By =>
            This.Notification := Pulsar.Notification_Manager.Types.Stand_By;
            This.Flight_Mode  := Pulsar.Flight_Control.Types.Stopped;

            if (This.State /= This.Previous_State) then
               Text_Message (1 .. 8) := "STAND BY";
               This.Logger_Interface.Set_Text_Message(Text_Message);
            end if;
            -- MCDC Problem, in relation with Ticket 181 (to be resolved)

         when Pulsar.State_Machine.Types.Manual =>
            This.Notification := Pulsar.Notification_Manager.Types.Running;

            if (This.State /= This.Previous_State) then
               Text_Message (1 .. 6) := "MANUAL";
               This.Logger_Interface.Set_Text_Message(Text_Message);
            end if;
            -- MCDC Problem, in relation with Ticket 181 (to be resolved)

            if This.Remote_Control_Interface.Get_Flight_Mode = Pulsar.Remote_Control.Types.Rates then
               This.Flight_Mode := Pulsar.Flight_Control.Types.Rates;
            elsif This.Remote_Control_Interface.Get_Flight_Mode = Pulsar.Remote_Control.Types.Stabilized then
               This.Flight_Mode := Pulsar.Flight_Control.Types.Stabilized;
            end if;
            -- MCDC Problem, in relation with Ticket 181 (to be resolved)

         when Pulsar.State_Machine.Types.Fault  =>
            This.Notification := Pulsar.Notification_Manager.Types.Fault;
            This.FLight_Mode  := Pulsar.Flight_Control.Types.Stopped;

            if (This.State /= This.Previous_State) then
               Text_Message (1 .. 5) := "FAULT";
               This.Logger_Interface.Set_Text_Message(Text_Message);
            end if;
            -- MCDC Problem, in relation with Ticket 181 (to be resolved)
      end case;
   end Update;

end Pulsar.State_Machine.Interpreter.Core;
