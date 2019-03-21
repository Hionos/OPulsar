-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This package provides routines to handle the Motors Mixing component      --
-------------------------------------------------------------------------------

with Pulsar.Motors_Mixing.Types;

with Hal.Motors;

package Pulsar.Motors_Mixing.Core is

   -- Type defining the class object
   type T_Motors_Mixing is tagged private;

   -- Type defining a pointer to the class object
   type T_Motors_Mixing_Class_Access is access all T_Motors_Mixing'Class;

   ----------------------------------------------------------------------------
   -- REQ: Motors is not null
   -- ENS: A new instance of T_Motors_Mixing is returned
   ----------------------------------------------------------------------------
   function New_And_Initialize (Motors : in not null Hal.Motors.T_Motors_Class_Access) return not null T_Motors_Mixing_Class_Access;

   ----------------------------------------------------------------------------
   -- REQ: Corrections.Roll, Corrections.Pitch and Corrections.Yaw are in range
   --      Pulsar.Motors_Mixing.Types.T_Attitude_Correction
   -- ENS: Attitude corrections are set with Corrections values
   ----------------------------------------------------------------------------
   procedure Set_Attitude_Corrections (This        : in out T_Motors_Mixing;
                                       Corrections : in Pulsar.Motors_Mixing.Types.T_Attitude_Corrections);

   ----------------------------------------------------------------------------
   -- REQ: Throttle is in range
   --      Pulsar.Motors_Mixing.Types.T_Flight_Control_Throttle
   -- ENS: Flight control throttle is set with Throttle value
   ----------------------------------------------------------------------------
   procedure Set_Flight_Control_Throttle (This     : in out T_Motors_Mixing;
                                          Throttle : in Pulsar.Motors_Mixing.Types.T_Flight_Control_Throttle);

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: Stop status is set with Stop value
   ----------------------------------------------------------------------------
   procedure Set_Stop (This : in out T_Motors_Mixing;
                       Stop : in Boolean);

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: Motors speed output values are updated
   ----------------------------------------------------------------------------
   procedure Update (This : in T_Motors_Mixing);

private

   -- Array type representing thrusts
   type T_Thrusts is array (Hal.Motors.T_Motor_Id) of Float;

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: Motors speed are computed and returned in range T_Motors_Speed
   ----------------------------------------------------------------------------
   function Compute_Motors_Speed (This : in T_Motors_Mixing'Class) return Hal.Motors.T_Motors_Speed;

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: Main Motors thrust are computed and returned
   ----------------------------------------------------------------------------
   function Compute_Main_Motors_Thrust (This : in T_Motors_Mixing'Class) return T_Thrusts;

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: Thrust adjustment to apply on each motors thrust is computed and
   --      returned
   ----------------------------------------------------------------------------
   function Compute_Thrust_Adjustment (Main_Motors_Thrust : in T_Thrusts) return Float;

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: The lowest thrust is returned
   ----------------------------------------------------------------------------
   function Minimum_Thrust (Thrusts : in T_Thrusts) return Float;

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: The highest thrust is returned
   ----------------------------------------------------------------------------
   function Maximum_Thrust (Thrusts : in T_Thrusts) return Float;

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: Thrust is saturated between (Motors_Min_Speed/10)**2 and 100
   ----------------------------------------------------------------------------
   function Saturate_Motor_Thrust (Thrust : in Float) return Float;

   type T_Motors_Mixing is tagged record
      Motors                  : not null Hal.Motors.T_Motors_Class_Access;
      Attitude_Corrections    : Pulsar.Motors_Mixing.Types.T_Attitude_Corrections    := (Roll => 0.0, Pitch => 0.0, Yaw => 0.0);
      Flight_Control_Throttle : Pulsar.Motors_Mixing.Types.T_Flight_Control_Throttle := 0.0;
      Stop                    : Boolean                                              := True;
   end record;

end Pulsar.Motors_Mixing.Core;
