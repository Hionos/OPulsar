with Pulsar.Constants;
with Pulsar.Notification_Manager.Types; use Pulsar.Notification_Manager.Types;
with Hal.Light_Signal; use Hal.Light_Signal;

package body Pulsar.Notification_Manager.Core
is

   -- Number of times the update function will be called in 1 second
   Number_Of_Cycles_For_1_Second : constant Natural := Natural (Pulsar.Constants.Fast_Loop_Frequency * 1);

   -- Light notification blinking period during initialization in seconds
   Initialization_Blinking_Period : constant := 0.2;

   -- Light notification blinking period during stand by in seconds
   Stand_By_Blinking_Period : constant := 0.5;

   ----------------------------------------------------------------------------
   -- New_And_Initialize                                                     --
   ----------------------------------------------------------------------------
   function New_And_Initialize (Light_Signal_Interface : in not null Hal.Light_Signal.T_Light_Signal_Class_Access)
      return not null T_Notification_Manager_Class_Access is
      Notification_Manager : constant T_Notification_Manager_Class_Access :=
         new T_Notification_Manager'(Light_Signal_Interface => Light_Signal_Interface,
                                     others                 => <>);
   begin
      Notification_Manager.Set_Notification_Status (Initialization);

      return Notification_Manager;
   end New_And_Initialize;

   ----------------------------------------------------------------------------
   -- Set_Toggling_Conditions                                                --
   ----------------------------------------------------------------------------
   procedure Set_Toggling_Conditions (This                      : in out T_Notification_Manager'Class;
                                      First_State, Second_State : in Hal.Light_Signal.T_Light_State := Hal.Light_Signal.OFF;
                                      Toggling_Period           : in T_Toggling_Period := 0.0) is
   begin
      This.Current_Number_Of_Cycles := 0;
      This.First_Light_State := False;
      This.Toggling_States := (True  => First_State,
                               False => Second_State);
      This.Number_Of_Cycles_In_Toggling_Period := Natural (Float (Number_Of_Cycles_For_1_Second) * Toggling_Period);
   end Set_Toggling_Conditions;

   ----------------------------------------------------------------------------
   -- Set_Notification_Status                                                --
   ----------------------------------------------------------------------------
   procedure Set_Notification_Status (This                : in out T_Notification_Manager;
                                      Notification_Status : in Pulsar.Notification_Manager.Types.T_Notification_Status)
   is
      Notification_Status_Changed : constant Boolean := Notification_Status /= This.Notification_Status;
      Notification_Status_Not_Initialized : constant Boolean := This.Current_Number_Of_Cycles = 0;
   begin
      if Notification_Status_Changed or Notification_Status_Not_Initialized then
         This.Notification_Status := Notification_Status;

         -- Adapt toggling conditions regarding notification status
         case This.Notification_Status is
            when Initialization =>
               This.Set_Toggling_Conditions (Hal.Light_Signal.Red,
                                             Hal.Light_Signal.Green,
                                             Initialization_Blinking_Period);
            when Stand_By =>
               This.Set_Toggling_Conditions (Hal.Light_Signal.OFF,
                                             Hal.Light_Signal.Green,
                                             Stand_By_Blinking_Period);
            when Running =>
               This.Solid_State := Hal.Light_Signal.Green;
            when Fault =>
               This.Solid_State := Hal.Light_Signal.Red;
         end case;
      end if;
   end Set_Notification_Status;

   ----------------------------------------------------------------------------
   -- Current_Toggling_State                                                 --
   ----------------------------------------------------------------------------
   function Current_Toggling_State (This : in out T_Notification_Manager'Class) return Hal.Light_Signal.T_Light_State is
   begin
      if This.Current_Number_Of_Cycles mod This.Number_Of_Cycles_In_Toggling_Period = 0 then
         This.First_Light_State := not This.First_Light_State;
         This.Current_Number_Of_Cycles := 0;
      end if;
      return This.Toggling_States (This.First_Light_State);
   end Current_Toggling_State;

   ----------------------------------------------------------------------------
   -- Update                                                                 --
   ----------------------------------------------------------------------------
   procedure Update (This : in out T_Notification_Manager) is
   begin
      case This.Notification_Status is
         when Initialization | Stand_By =>
            This.Light_Signal_Interface.Set_State (This.Current_Toggling_State);
            This.Current_Number_Of_Cycles := This.Current_Number_Of_Cycles + 1;
         when Running | Fault =>
            This.Light_Signal_Interface.Set_State (This.Solid_State);
      end case;
   end Update;

end Pulsar.Notification_Manager.Core;
