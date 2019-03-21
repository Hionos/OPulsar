-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This package provides routines to handle the HAL core                     --
-------------------------------------------------------------------------------

with Hal.Core;
with Crazyflie.Battery;
with Crazyflie.Imu;
with Crazyflie.Light_Signal;
with Crazyflie.Remote_Control;
with Crazyflie.Motors;
with Crazyflie.Logger_Stream;

package Crazyflie.Hal_Core is

   type T_Hal is new Hal.Core.T_Hal with private;

   type T_Hal_Class_Access is access all T_Hal'Class;

   not overriding
   function New_And_Initialize (Battery        : Crazyflie.Battery.T_Battery_Class_Access;
                                Imu            : Crazyflie.Imu.T_Imu_Class_Access;
                                Light_Signal   : Crazyflie.Light_Signal.T_Light_Signal_Class_Access;
                                Remote_Control : Crazyflie.Remote_Control.T_Remote_Control_Class_Access;
                                Motors         : Crazyflie.Motors.T_Motors_Class_Access;
                                Logger_Stream  : Crazyflie.Logger_Stream.T_Logger_Stream_Class_Access)
                                return not null T_Hal_Class_Access;

   overriding
   procedure Update_Board (This : not null access T_Hal);

private
   type T_Hal is new Hal.Core.T_Hal with record
      Battery        : Crazyflie.Battery.T_Battery_Class_Access               := null;
      Imu            : Crazyflie.Imu.T_Imu_Class_Access                       := null;
      Light_Signal   : Crazyflie.Light_Signal.T_Light_Signal_Class_Access     := null;
      Remote_Control : Crazyflie.Remote_Control.T_Remote_Control_Class_Access := null;
      Motors         : Crazyflie.Motors.T_Motors_Class_Access                 := null;
      Logger_Stream  : Crazyflie.Logger_Stream.T_Logger_Stream_Class_Access   := null;
   end record;

end Crazyflie.Hal_Core;
