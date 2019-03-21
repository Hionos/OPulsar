with Crazyflie.Hal_Core;
with Crazyflie.Battery;
with Crazyflie.Imu;
with Crazyflie.Light_Signal;
with Crazyflie.Remote_Control;
with Crazyflie.Motors;
with Crazyflie.Logger_Stream;

package body Boards.Hardware_Factory is

   ----------------------------------------------------------------------------
   -- New_And_Initialize                                                     --
   ----------------------------------------------------------------------------
   function New_And_Initialize return T_Hardware_Factory_Class_Access is
      Hardware_Factory : constant T_Hardware_Factory_Class_Access := new T_Hardware_Factory;

      Crazyflie_Battery        : constant Crazyflie.Battery.T_Battery_Class_Access := Crazyflie.Battery.New_And_Initialize;
      Crazyflie_Imu            : constant Crazyflie.Imu.T_Imu_Class_Access := Crazyflie.Imu.New_And_Initialize;
      Crazyflie_Light_Signal   : constant Crazyflie.Light_Signal.T_Light_Signal_Class_Access := Crazyflie.Light_Signal.New_And_Initialize;
      Crazyflie_Remote_Control : constant Crazyflie.Remote_Control.T_Remote_Control_Class_Access := Crazyflie.Remote_Control.New_And_Initialize;
      Crazyflie_Motors         : constant Crazyflie.Motors.T_Motors_Class_Access := Crazyflie.Motors.New_And_Initialize;
      Crazyflie_Logger_Stream  : constant Crazyflie.Logger_Stream.T_Logger_Stream_Class_Access := Crazyflie.Logger_Stream.New_And_Initialize;
   begin
      Hardware_Factory.Battery_Hardware      := Hal.Battery.T_Battery_Class_Access (Crazyflie_Battery);
      Hardware_Factory.Imu_Hardware          := Hal.Imu.T_Imu_Class_Access (Crazyflie_Imu);
      Hardware_Factory.Light_Signal_Hardware := Hal.Light_Signal.T_Light_Signal_Class_Access (Crazyflie_Light_Signal);
      Hardware_Factory.Rc_Hardware           := Hal.Remote_Control.T_Remote_Control_Class_Access (Crazyflie_Remote_Control);
      Hardware_Factory.Motors_Hardware       := Hal.Motors.T_Motors_Class_Access (Crazyflie_Motors);
      Hardware_Factory.Logger_Stream         := Hal.Logger_Stream.T_Logger_Stream_Class_Access (Crazyflie_Logger_Stream);

      Hardware_Factory.Hal_Core := Hal.Core.T_Hal_Class_Access (Crazyflie.Hal_Core.New_And_Initialize(
            Battery        => Crazyflie_Battery,
            Imu            => Crazyflie_Imu,
            Light_Signal   => Crazyflie_Light_Signal,
            Remote_Control => Crazyflie_Remote_Control,
            Motors         => Crazyflie_Motors,
            Logger_Stream  => Crazyflie_Logger_Stream));

      return Hardware_Factory;
   end New_And_Initialize;

   ----------------------------------------------------------------------------
   -- Get_Hal                                                                --
   ----------------------------------------------------------------------------
   function Get_Hal (This : in out T_Hardware_Factory) return Hal.Core.T_Hal_Class_Access is
   begin
      return This.Hal_Core;
   end Get_Hal;

   ----------------------------------------------------------------------------
   -- Get_Battery                                                            --
   ----------------------------------------------------------------------------
   function Get_Battery (This : in out T_Hardware_Factory) return Hal.Battery.T_Battery_Class_Access is
   begin
      return This.Battery_Hardware;
   end Get_Battery;

   ----------------------------------------------------------------------------
   -- Get_Imu                                                                --
   ----------------------------------------------------------------------------
   function Get_Imu (This : in out T_Hardware_Factory) return Hal.Imu.T_Imu_Class_Access is
   begin
      return This.Imu_Hardware;
   end Get_Imu;

   ----------------------------------------------------------------------------
   -- Get_Light_Signal                                                       --
   ----------------------------------------------------------------------------
   function Get_Light_Signal (This  : in out T_Hardware_Factory) return Hal.Light_Signal.T_Light_Signal_Class_Access is
   begin
      return This.Light_Signal_Hardware;
   end Get_Light_Signal;

   ----------------------------------------------------------------------------
   -- Get_Remote_Control                                                     --
   ----------------------------------------------------------------------------
   function Get_Remote_Control (This : in out T_Hardware_Factory) return Hal.Remote_Control.T_Remote_Control_Class_Access is
   begin
      return This.Rc_Hardware;
   end Get_Remote_Control;

   ----------------------------------------------------------------------------
   -- Get_Motors                                                             --
   ----------------------------------------------------------------------------
   function Get_Motors (This : in out T_Hardware_Factory) return Hal.Motors.T_Motors_Class_Access is
   begin
      return This.Motors_Hardware;
   end Get_Motors;

   ----------------------------------------------------------------------------
   -- Get_Logger_Stream                                                      --
   ----------------------------------------------------------------------------
   function Get_Logger_Stream (This : in out T_Hardware_Factory) return Hal.Logger_Stream.T_Logger_Stream_Class_Access is
   begin
      return This.Logger_Stream;
   end Get_Logger_Stream;

end Boards.Hardware_Factory;
