with Hal.Remote_Control; use Hal.Remote_Control;
with Pulsar.Remote_Control.Constants;

package body Pulsar.Remote_Control.Core
is

   -- Constrained subtype representing the acceptable ratio range to declare neutral position
   subtype T_Safe_Mid_Ratio_Range is T_Ratio
      range (50.0 - Constants.Safe_Mid_Ratio_Margin) .. (50.0 + Constants.Safe_Mid_Ratio_Margin);

   ----------------------------------------------------------------------------
   -- New_And_Initialize                                                     --
   ----------------------------------------------------------------------------
   function New_And_Initialize (Remote_Control_Interface : not null Hal.Remote_Control.T_Remote_Control_Class_Access) return not null T_Remote_Control_Class_Access is
   begin
      return new T_Remote_Control'(Remote_Control_Interface => Remote_Control_Interface,
                                   others                   => <>);
   end New_And_Initialize;

   ----------------------------------------------------------------------------
   -- Is_Timeout_Detected                                                    --
   ----------------------------------------------------------------------------
   function Is_Timeout_Detected (This : in T_Remote_Control) return Boolean is
   begin
      return This.Rc_Timeout_Detected;
   end Is_Timeout_Detected;

   ----------------------------------------------------------------------------
   -- Get_Arming_Command                                                     --
   ----------------------------------------------------------------------------
   function Get_Arming_Command (This : in T_Remote_Control) return Types.T_Arming_Command is
   begin
      return This.Rc_Arming_Command;
   end Get_Arming_Command;

   ----------------------------------------------------------------------------
   -- Get_Flight_Mode                                                        --
   ----------------------------------------------------------------------------
   function Get_Flight_Mode (This : in T_Remote_Control) return Types.T_Flight_Mode is
   begin
      return This.Rc_Flight_Mode;
   end Get_Flight_Mode;

   ----------------------------------------------------------------------------
   -- Is_In_Neutral_Position                                                 --
   ----------------------------------------------------------------------------
   function Is_In_Neutral_Position (This : in T_Remote_Control) return Boolean is
   begin
      return This.Rc_Neutral_Position;
   end Is_In_Neutral_Position;

   ----------------------------------------------------------------------------
   -- Get_Rc_Orders                                                          --
   ----------------------------------------------------------------------------
   function Get_Rc_Orders (This : in T_Remote_Control) return Types.T_Rc_Orders is
   begin
      return This.Rc_Orders;
   end Get_Rc_Orders;

   ----------------------------------------------------------------------------
   -- Evaluate_Remote_Control_Neutrality                                     --
   ----------------------------------------------------------------------------
   procedure Evaluate_Remote_Control_Neutrality (This               : in out T_Remote_Control'Class;
                                                 Rc_Throttle_Ratio,
                                                 Rc_Roll_Ratio,
                                                 Rc_Pitch_Ratio,
                                                 Rc_Yaw_Ratio       : in Hal.Remote_Control.T_Ratio) is
      Throttle_In_Safe_Position : Boolean := False;
      Roll_In_Safe_Position     : Boolean := False;
      Pitch_In_Safe_Position    : Boolean := False;
      Yaw_In_Safe_Position      : Boolean := False;
   begin
      Throttle_In_Safe_Position := Rc_Throttle_Ratio < Constants.Safe_Throttle_Ratio;
      Roll_In_Safe_Position     := Rc_Roll_Ratio in T_Safe_Mid_Ratio_Range;
      Pitch_In_Safe_Position    := Rc_Pitch_Ratio in T_Safe_Mid_Ratio_Range;
      Yaw_In_Safe_Position      := Rc_Yaw_Ratio in T_Safe_Mid_Ratio_Range;

      This.Rc_Neutral_Position :=
        Throttle_In_Safe_Position and then
        Roll_In_Safe_Position and then
        Pitch_In_Safe_Position and then
        Yaw_In_Safe_Position;
   end Evaluate_Remote_Control_Neutrality;

   ----------------------------------------------------------------------------
   -- Compute_Arming_Command                                                 --
   ----------------------------------------------------------------------------
   procedure Compute_Arming_Command (This : in out T_Remote_Control'Class) is
      Rc_Arming : constant Hal.Remote_Control.T_Arming_State :=
         This.Remote_Control_Interface.Get_Arming;

      -- Arming_States_To_Arming_Command array is used to elaborate the output Arming_Command
      -- thanks to previous and current input Arming_State
      Arming_States_To_Arming_Command : constant array (Hal.Remote_Control.T_Arming_State, Hal.Remote_Control.T_Arming_State) of Types.T_Arming_Command :=
         (Hal.Remote_Control.Armed    => (Hal.Remote_Control.Armed    => Types.No_Command,
                                          Hal.Remote_Control.Disarmed => Types.Arm),
          Hal.Remote_Control.Disarmed => (others => Types.Disarm));
   begin
      This.Rc_Arming_Command := Arming_States_To_Arming_Command (Rc_Arming, This.Previous_Rc_Arming);
      This.Previous_Rc_Arming := Rc_Arming;
   end Compute_Arming_Command;

   ----------------------------------------------------------------------------
   -- Compute_Flight_Mode                                                    --
   ----------------------------------------------------------------------------
   procedure Compute_Flight_Mode (This : in out T_Remote_Control'Class) is
      Hal_To_Remote_Control_Flight_Mode : constant array (Hal.Remote_Control.T_Flight_Mode) of Types.T_Flight_Mode :=
         (Hal.Remote_Control.Rates      => Types.Rates,
          Hal.Remote_Control.Stabilized => Types.Stabilized);
   begin
      This.Rc_Flight_Mode := Hal_To_Remote_Control_Flight_Mode (This.Remote_Control_Interface.Get_Flight_Mode);
   end Compute_Flight_Mode;

   ----------------------------------------------------------------------------
   -- Compute_Rc_Orders                                                      --
   ----------------------------------------------------------------------------
   procedure Compute_Rc_Orders (This               : in out T_Remote_Control'Class;
                                Rc_Throttle_Ratio,
                                Rc_Roll_Ratio,
                                Rc_Pitch_Ratio,
                                Rc_Yaw_Ratio       : in Hal.Remote_Control.T_Ratio) is
   begin
      This.Rc_Orders := (Throttle => Rc_Throttle_Ratio,
                         Rates    => (Roll  => (Float (Rc_Roll_Ratio) - 50.0) * 2.0 * Constants.Max_Roll_Angular_Speed / 100.0,
                                      Pitch => (50.0 - Float (Rc_Pitch_Ratio)) * 2.0 * Constants.Max_Pitch_Angular_Speed / 100.0,
                                      Yaw   => (Float (Rc_Yaw_Ratio) - 50.0) * 2.0 * Constants.Max_Yaw_Angular_Speed / 100.0),
                         Angles   => (Roll  => (Float (Rc_Roll_Ratio) - 50.0) * 2.0 * Constants.Max_Angle / 100.0,
                                      Pitch => (50.0 - Float (Rc_Pitch_Ratio)) * 2.0 * Constants.Max_Angle / 100.0));
   end Compute_Rc_Orders;

   ----------------------------------------------------------------------------
   -- Update                                                                 --
   ----------------------------------------------------------------------------
   procedure Update (This : in out T_Remote_Control) is
      Rc_Throttle_Ratio : constant T_Ratio := This.Remote_Control_Interface.Get_Throttle_Ratio;
      Rc_Roll_Ratio     : constant T_Ratio := This.Remote_Control_Interface.Get_Roll_Ratio;
      Rc_Pitch_Ratio    : constant T_Ratio := This.Remote_Control_Interface.Get_Pitch_Ratio;
      Rc_Yaw_Ratio      : constant T_Ratio := This.Remote_Control_Interface.Get_Yaw_Ratio;
   begin
      This.Rc_Timeout_Detected := This.Remote_Control_Interface.Get_Elapsed_Time_From_Reception > Constants.Remote_Control_Timeout;
      This.Evaluate_Remote_Control_Neutrality (Rc_Throttle_Ratio,
                                          Rc_Roll_Ratio,
                                          Rc_Pitch_Ratio,
                                          Rc_Yaw_Ratio);
      This.Compute_Arming_Command;
      This.Compute_Flight_Mode;

      This.Compute_Rc_Orders (Rc_Throttle_Ratio,
                              Rc_Roll_Ratio,
                              Rc_Pitch_Ratio,
                              Rc_Yaw_Ratio);
   end Update;

end Pulsar.Remote_Control.Core;
