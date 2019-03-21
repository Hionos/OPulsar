with Hal.Imu; use Hal.Imu;

with IMU_Device;

package body Crazyflie.Hal_Core is

   ----------------------------------------------------------------------------
   -- New_And_Initialize                                                     --
   ----------------------------------------------------------------------------
   not overriding
   function New_And_Initialize (Battery        : Crazyflie.Battery.T_Battery_Class_Access;
                                Imu            : Crazyflie.Imu.T_Imu_Class_Access;
                                Light_Signal   : Crazyflie.Light_Signal.T_Light_Signal_Class_Access;
                                Remote_Control : Crazyflie.Remote_Control.T_Remote_Control_Class_Access;
                                Motors         : Crazyflie.Motors.T_Motors_Class_Access;
                                Logger_Stream  : Crazyflie.Logger_Stream.T_Logger_Stream_Class_Access)
                                return not null T_Hal_Class_Access is
      Hal_Core : constant T_Hal_Class_Access := new Crazyflie.Hal_Core.T_Hal;
   begin
      Hal_Core.Battery        := Battery;
      Hal_Core.Imu            := Imu;
      Hal_Core.Light_Signal   := Light_Signal;
      Hal_Core.Remote_Control := Remote_Control;
      Hal_Core.Motors         := Motors;
      Hal_Core.Logger_Stream  := Logger_Stream;

      return Hal_Core;
   end New_And_Initialize;

   ----------------------------------------------------------------------------
   -- Update_Board                                                           --
   ----------------------------------------------------------------------------
   overriding
   procedure Update_Board (This : not null access T_Hal) is
   begin
      if IMU_Device.IMU_Get_Status = Hal.Imu.Undefined then
         if not IMU_Device.IMU_Device_Initialized then
            IMU_Device.IMU_Init_Device;
         else
            IMU_Device.IMU_Calibrate;
         end if;
      elsif IMU_Device.IMU_Get_Status = Hal.Imu.Operational then
         IMU_Device.Start_IMU_Acquisition;
      end if;

      -- Update all the HAL upstream interfaces
      This.Battery.Update;
      This.Imu.Update;
      This.Remote_Control.Update;
   end Update_Board;

end Crazyflie.Hal_Core;
