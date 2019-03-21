-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This package provides routines to handle the Remote_Control component     --
-- hardware abstraction Layer                                                --
-------------------------------------------------------------------------------

package Hal.Remote_Control is

   -- Enum type representing possible arming states
   type T_Arming_State is (Disarmed, Armed);

   -- Constrained type to count elapsed time since last data reception
   type T_Elapsed_Time is delta 0.001 range 0.000 .. 65.535 with Small => 0.001;

   -- Enum type representing possible flight modes
   type T_Flight_Mode is (Stabilized, Rates);

   -- Constrained type defining remote control commands ratio
   type T_Ratio is delta 0.01 range 0.00 .. 100.00 with Small => 0.01;

   -- Type defining the interface object
   type T_Remote_Control is limited interface;

   -- Type defining a pointer to the interface object
   type T_Remote_Control_Class_Access is access all T_Remote_Control'Class;

   ----------------------------------------------------------------------------
   -- REQ : None
   -- ENS : Remote Control Hardware Arming state is returned
   ----------------------------------------------------------------------------
   function Get_Arming (This : in T_Remote_Control) return T_Arming_State is abstract;

   ----------------------------------------------------------------------------
   -- REQ : None
   -- ENS : Remote Control Hardware elapsed time since last data reception
   --       is returned
   ----------------------------------------------------------------------------
   function Get_Elapsed_Time_From_Reception (This : in T_Remote_Control) return T_Elapsed_Time is abstract;

   ----------------------------------------------------------------------------
   -- REQ : None
   -- ENS : Remote Control Hardware Flight Mode switch is returned
   ----------------------------------------------------------------------------
   function Get_Flight_Mode (This : in T_Remote_Control) return T_Flight_Mode is abstract;

   ----------------------------------------------------------------------------
   -- REQ : None
   -- ENS : Remote Control Hardware Throttle Ratio is returned
   ----------------------------------------------------------------------------
   function Get_Throttle_Ratio (This : in T_Remote_Control) return T_Ratio is abstract;
     --with Pre'Class => Get_Status (This) = Operational; -- This currently makes gcc bug, Ticket N° [Q317-009]

   ----------------------------------------------------------------------------
   -- REQ : None
   -- ENS : Remote Control Hardware Roll Ratio is returned
   ----------------------------------------------------------------------------
   function Get_Roll_Ratio (This : in T_Remote_Control) return T_Ratio is abstract;
     --with Pre'Class => Get_Status (This) = Operational; -- This currently makes gcc bug, Ticket N° [Q317-009]

   ----------------------------------------------------------------------------
   -- REQ : None
   -- ENS : Remote Control Hardware Pitch Ratio is returned
   ----------------------------------------------------------------------------
   function Get_Pitch_Ratio (This : in T_Remote_Control) return T_Ratio is abstract;
     --with Pre'Class => Get_Status (This) = Operational; -- This currently makes gcc bug, Ticket N° [Q317-009]

   ----------------------------------------------------------------------------
   -- REQ : None
   -- ENS : Remote Control Hardware Yaw Ratio is returned
   ----------------------------------------------------------------------------
   function Get_Yaw_Ratio (This : in T_Remote_Control) return T_Ratio is abstract;
     --with Pre'Class => Get_Status (This) = Operational; -- This currently makes gcc bug, Ticket N° [Q317-009]

end Hal.Remote_Control;
