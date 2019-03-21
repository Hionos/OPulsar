with PWM;

package body Crazyflie.Motors is

   ----------------------------------------------------------------------------
   -- New_And_Initialize                                                     --
   ----------------------------------------------------------------------------
   not overriding
   function New_And_Initialize return not null T_Motors_Class_Access is
   begin
      PWM.PWM_Init;

      return new Crazyflie.Motors.T_Motors;
   end New_And_Initialize;

   ----------------------------------------------------------------------------
   -- Set_Motors_Speed                                                       --
   ----------------------------------------------------------------------------
   overriding
   procedure Set_Motors_Speed (This         : in out T_Motors;
                               Motors_Speed : in Hal.Motors.T_Motors_Speed) is
   begin
      This.Motors_Speed := Motors_Speed;

      This.Update_PWMs;
   end Set_Motors_Speed;

   ----------------------------------------------------------------------------
   -- Set_Motors_Command                                                     --
   ----------------------------------------------------------------------------
   overriding
   procedure Set_Motors_Command (This    : in out T_Motors;
                                 Command : in Hal.Motors.T_Command) is
   begin
      This.Motors_Command := Command;

      This.Update_PWMs;
   end Set_Motors_Command;

   ----------------------------------------------------------------------------
   -- Update_PWMs                                                            --
   ----------------------------------------------------------------------------
   not overriding
   procedure Update_PWMs (This : in T_Motors) is
   begin
      if This.Motors_Command = Hal.Motors.Run then
         PWM.Set_Motor1_Speed (This.Motors_Speed (Hal.Motors.Motor1));
         PWM.Set_Motor2_Speed (This.Motors_Speed (Hal.Motors.Motor2));
         PWM.Set_Motor3_Speed (This.Motors_Speed (Hal.Motors.Motor3));
         PWM.Set_Motor4_Speed (This.Motors_Speed (Hal.Motors.Motor4));
      else
         PWM.Set_Motor1_Speed (Hal.Motors.T_Speed'First);
         PWM.Set_Motor2_Speed (Hal.Motors.T_Speed'First);
         PWM.Set_Motor3_Speed (Hal.Motors.T_Speed'First);
         PWM.Set_Motor4_Speed (Hal.Motors.T_Speed'First);
      end if;
   end Update_PWMs;

end Crazyflie.Motors;
