-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This package provides routines to handle the Boards Hardware Factory      --
-------------------------------------------------------------------------------

with Hal.Core;
with Hal.Battery;
with Hal.Imu;
with Hal.Light_Signal;
with Hal.Remote_Control;
with Hal.Motors;
with Hal.Logger_Stream;

package Boards.Hardware_Factory is

   -- Type defining the interface object
   type T_Hardware_Factory is tagged limited private;

   -- Type defining a pointer to the interface object
   type T_Hardware_Factory_Class_Access is access all T_Hardware_Factory'Class;

   ----------------------------------------------------------------------------
   -- REQ : None
   -- ENS : Create a new Hardware_Factory object, initialize it and return it
   ----------------------------------------------------------------------------
   function New_And_Initialize return T_Hardware_Factory_Class_Access;

   ----------------------------------------------------------------------------
   -- REQ : None
   -- ENS : Return Hal Object
   ----------------------------------------------------------------------------
   function Get_Hal (This : in out T_Hardware_Factory) return Hal.Core.T_Hal_Class_Access;

   ----------------------------------------------------------------------------
   -- REQ : None
   -- ENS : Return Battery Hardware Object
   ----------------------------------------------------------------------------
   function Get_Battery (This : in out T_Hardware_Factory) return Hal.Battery.T_Battery_Class_Access;

   ----------------------------------------------------------------------------
   -- REQ : None
   -- ENS : Return Imu Hardware Object
   ----------------------------------------------------------------------------
   function Get_Imu (This : in out T_Hardware_Factory) return Hal.Imu.T_Imu_Class_Access;

   ----------------------------------------------------------------------------
   -- REQ : None.
   -- ENS : Return the Light Signal Hardware Object
   ----------------------------------------------------------------------------
   function Get_Light_Signal (This  : in out T_Hardware_Factory) return Hal.Light_Signal.T_Light_Signal_Class_Access;

   ----------------------------------------------------------------------------
   -- REQ : None
   -- ENS : Return Remote Control Hardware Object
   ----------------------------------------------------------------------------
   function Get_Remote_Control (This : in out T_Hardware_Factory) return Hal.Remote_Control.T_Remote_Control_Class_Access;

   ----------------------------------------------------------------------------
   -- REQ : None
   -- ENS : Return Motor Hardware Object
   ----------------------------------------------------------------------------
   function Get_Motors (This : in out T_Hardware_Factory) return Hal.Motors.T_Motors_Class_Access;

   ----------------------------------------------------------------------------
   -- REQ : None
   -- ENS : Return Logger Stream Hardware Object
   ----------------------------------------------------------------------------
   function Get_Logger_Stream (This : in out T_Hardware_Factory) return Hal.Logger_Stream.T_Logger_Stream_Class_Access;

private
   type T_Hardware_Factory is tagged limited
      record
         Hal_Core              : Hal.Core.T_Hal_Class_Access                      := null;
         Battery_Hardware      : Hal.Battery.T_Battery_Class_Access               := null;
         Imu_Hardware          : Hal.Imu.T_Imu_Class_Access                       := null;
         Light_Signal_Hardware : Hal.Light_Signal.T_Light_Signal_Class_Access     := null;
         Rc_Hardware           : Hal.Remote_Control.T_Remote_Control_Class_Access := null;
         Motors_Hardware       : Hal.Motors.T_Motors_Class_Access                 := null;
         Logger_Stream         : Hal.Logger_Stream.T_Logger_Stream_Class_Access   := null;
      end record;

end Boards.Hardware_Factory;
