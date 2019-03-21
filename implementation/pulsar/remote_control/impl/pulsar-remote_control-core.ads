-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This package provides routines to handle the Remote Control component     --
-------------------------------------------------------------------------------

with Pulsar.Remote_Control.Types;
with Hal.Remote_Control;

package Pulsar.Remote_Control.Core is

   -- Type defining the class object
   type T_Remote_Control is tagged private;

   -- Type defining a pointer to the class object
   type T_Remote_Control_Class_Access is access all T_Remote_Control'Class;

   ----------------------------------------------------------------------------
   -- REQ: Remote_Control_Interface is not null
   -- ENS: Return new instance of T_Remote_Control
   ----------------------------------------------------------------------------
   function New_And_Initialize (Remote_Control_Interface : not null Hal.Remote_Control.T_Remote_Control_Class_Access) return not null T_Remote_Control_Class_Access;

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: True is returend if Remote Control reception timeout is detected,
   --      False is returned otherwise
   ----------------------------------------------------------------------------
   function Is_Timeout_Detected (This : in T_Remote_Control) return Boolean;

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: Remote Control arming command is returned
   ----------------------------------------------------------------------------
   function Get_Arming_Command (This : in T_Remote_Control) return Types.T_Arming_Command;

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: Remote Control flight mode is returned
   ----------------------------------------------------------------------------
   function Get_Flight_Mode (This : in T_Remote_Control) return Types.T_Flight_Mode;

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: True is returned if Remote Control is in Neutral Position,
   --      False is returned otherwise
   ----------------------------------------------------------------------------
   function Is_In_Neutral_Position (This : in T_Remote_Control) return Boolean;

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: Current RC Orders (Throttle, Rates and Angles) are returned
   ----------------------------------------------------------------------------
   function Get_Rc_Orders (This : in T_Remote_Control) return Types.T_Rc_Orders;

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: Remote Control component is updated
   ----------------------------------------------------------------------------
   procedure Update (This : in out T_Remote_Control);

private

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: True is returned if Remote Control sticks are in neutral position,
   --      False is returned otherwise
   ----------------------------------------------------------------------------
   procedure Evaluate_Remote_Control_Neutrality (This               : in out T_Remote_Control'Class;
                                                 Rc_Throttle_Ratio,
                                                 Rc_Roll_Ratio,
                                                 Rc_Pitch_Ratio,
                                                 Rc_Yaw_Ratio       : in Hal.Remote_Control.T_Ratio);

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: Remote Control arming command is computed
   ----------------------------------------------------------------------------
   procedure Compute_Arming_Command (This : in out T_Remote_Control'Class);

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: Remote Control flight mode is computed
   ----------------------------------------------------------------------------
   procedure Compute_Flight_Mode (This : in out T_Remote_Control'Class);

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: Remote Control orders are computed
   ----------------------------------------------------------------------------
   procedure Compute_Rc_Orders (This               : in out T_Remote_Control'Class;
                                Rc_Throttle_Ratio,
                                Rc_Roll_Ratio,
                                Rc_Pitch_Ratio,
                                Rc_Yaw_Ratio       : in Hal.Remote_Control.T_Ratio);

   type T_Remote_Control is tagged
      record
         Remote_Control_Interface : not null Hal.Remote_Control.T_Remote_Control_Class_Access;
         Rc_Arming_Command        : Types.T_Arming_Command := Types.No_Command;
         Rc_Flight_Mode           : Types.T_Flight_Mode    := Types.Rates;
         Rc_Timeout_Detected      : Boolean                := False;
         Rc_Neutral_Position      : Boolean                := False;
         Rc_Orders                : Types.T_Rc_Orders      := (Throttle => 0.0,
                                                               Rates    => (others => 0.0),
                                                               Angles   => (others => 0.0));
         Previous_Rc_Arming       : Hal.Remote_Control.T_Arming_State := Hal.Remote_Control.Armed;
      end record;

end Pulsar.Remote_Control.Core;
