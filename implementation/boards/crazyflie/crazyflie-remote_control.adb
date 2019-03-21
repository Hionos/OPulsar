with Interfaces; use Interfaces;

with PPM; use PPM;

package body Crazyflie.Remote_Control is

   ----------------------------------------------------------------------------
   -- New_And_Initialize                                                     --
   ----------------------------------------------------------------------------
   function New_And_Initialize return not null T_Remote_Control_Class_Access is
   begin
      PPM.PPM_Init;

      return new Crazyflie.Remote_Control.T_Remote_Control;
   end New_And_Initialize;

   ----------------------------------------------------------------------------
   -- Get_Arming                                                             --
   ----------------------------------------------------------------------------
   overriding
   function Get_Arming (This : T_Remote_Control) return Hal.Remote_Control.T_Arming_State is
   begin
      return This.Arming_State;
   end Get_Arming;

   ----------------------------------------------------------------------------
   -- Get_Elapsed_Time_From_Reception                                        --
   ----------------------------------------------------------------------------
   overriding
   function Get_Elapsed_Time_From_Reception (This : T_Remote_Control) return Hal.Remote_Control.T_Elapsed_Time is
   begin
      return This.Elapsed_Time_From_Reception;
   end Get_Elapsed_Time_From_Reception;

   ----------------------------------------------------------------------------
   -- Get_Flight_Mode                                                        --
   ----------------------------------------------------------------------------
   overriding
   function Get_Flight_Mode (This : T_Remote_Control) return Hal.Remote_Control.T_Flight_Mode is
   begin
      return This.Flight_Mode;
   end Get_Flight_Mode;

   ----------------------------------------------------------------------------
   -- Get_Throttle_Ratio                                                     --
   ----------------------------------------------------------------------------
   overriding
   function Get_Throttle_Ratio (This : T_Remote_Control) return Hal.Remote_Control.T_Ratio is
   begin
      return This.Throttle;
   end Get_Throttle_Ratio;

   ----------------------------------------------------------------------------
   -- Get_Roll_Ratio                                                         --
   ----------------------------------------------------------------------------
   overriding
   function Get_Roll_Ratio (This : T_Remote_Control) return Hal.Remote_Control.T_Ratio is
   begin
      return This.Roll;
   end Get_Roll_Ratio;

   ----------------------------------------------------------------------------
   -- Get_Pitch_Ratio                                                        --
   ----------------------------------------------------------------------------
   overriding
   function Get_Pitch_Ratio (This : T_Remote_Control) return Hal.Remote_Control.T_Ratio is
   begin
      return This.Pitch;
   end Get_Pitch_Ratio;

   ----------------------------------------------------------------------------
   -- Get_Yaw_Ratio                                                          --
   ----------------------------------------------------------------------------
   overriding
   function Get_Yaw_Ratio (This : T_Remote_Control) return HAL.Remote_Control.T_Ratio is
   begin
      return This.Yaw;
   end Get_Yaw_Ratio;

   ----------------------------------------------------------------------------
   -- Update                                                                 --
   ----------------------------------------------------------------------------
   not overriding
   procedure Update (This : in out T_Remote_Control) is
      Elapsed_Time : Float := 0.0;
   begin
      if PPM.Get_Channel (5) > 1500 then
         This.Arming_State := Hal.Remote_Control.Armed;
      else
         This.Arming_State := Hal.Remote_Control.Disarmed;
      end if;

      if PPM.Get_Status = PPM.Operational then
         This.Timeout_Start_Time := Clock;
      end if;

      Elapsed_Time := Float (To_Duration (Clock - This.Timeout_Start_Time));

      if Elapsed_Time < 65.535 then
         This.Elapsed_Time_From_Reception := Hal.Remote_Control.T_Elapsed_Time (Elapsed_Time);
      else
         This.Elapsed_Time_From_Reception := 65.535;
      end if;


      if PPM.Get_Channel (6) > 1250 then
         This.Flight_Mode := Hal.Remote_Control.Rates;
      else
         This.Flight_Mode := Hal.Remote_Control.Stabilized;
      end if;

      This.Throttle := Hal.Remote_Control.T_Ratio (Float (PPM.Get_Channel (3) - 1000) / 10.0);
      This.Roll     := Hal.Remote_Control.T_Ratio (Float (PPM.Get_Channel (1) - 1000) / 10.0);
      This.Pitch    := Hal.Remote_Control.T_Ratio (Float (PPM.Get_Channel (2) - 1000) / 10.0);
      This.Yaw      := Hal.Remote_Control.T_Ratio (Float (PPM.Get_Channel (4) - 1000) / 10.0);
   end Update;

end Crazyflie.Remote_Control;
