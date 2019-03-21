with Crazyflie.Device; use Crazyflie.Device;

with STM32.Device; use STM32.Device;
with STM32.GPIO;   use STM32.GPIO;
with STM32.Timers; use STM32.Timers;

with Interfaces; use Interfaces;

package body PWM is

   procedure PWM_Init is
   begin
      Configure_GPIO;
      Configure_Timer;
   end PWM_Init;

   procedure Set_Motor1_Speed (Speed : Hal.Motors.T_Speed) is
   begin
      Set_PWM_Motor_1 (PWM_Value (Float (Speed) * 2.56));
   end Set_Motor1_Speed;

   procedure Set_Motor2_Speed (Speed : Hal.Motors.T_Speed) is
   begin
      Set_PWM_Motor_2 (PWM_Value (Float (Speed) * 2.56));
   end Set_Motor2_Speed;

   procedure Set_Motor3_Speed (Speed : Hal.Motors.T_Speed) is
   begin
      Set_PWM_Motor_3 (PWM_Value (Float (Speed) * 2.56));
   end Set_Motor3_Speed;

   procedure Set_Motor4_Speed (Speed : Hal.Motors.T_Speed) is
   begin
      Set_PWM_Motor_4 (PWM_Value (Float (Speed) * 2.56));
   end Set_Motor4_Speed;

   procedure Configure_GPIO
   is
      Configuration : GPIO_Port_Configuration;
   begin
      Enable_Clock (Motor_1.Periph.all);
      Enable_Clock (Motor_2.Periph.all);
      Enable_Clock (Motor_3.Periph.all);
      Enable_Clock (Motor_4.Periph.all);

      Configuration.Mode        := Mode_AF;
      Configuration.Output_Type := Push_Pull;
      Configuration.Resistors   := Floating;
      Configuration.Speed       := Speed_100MHz;

      Configure_IO (Motor_1, Configuration);
      Configure_IO (Motor_2, Configuration);
      Configure_IO (Motor_3, Configuration);
      Configure_IO (Motor_4, Configuration);

      Configure_Alternate_Function (Motor_1, Motor_1_AF);
      Configure_Alternate_Function (Motor_2, Motor_2_AF);
      Configure_Alternate_Function (Motor_3, Motor_3_AF);
      Configure_Alternate_Function (Motor_4, Motor_4_AF);
   end Configure_GPIO;

   procedure Configure_Timer is
   begin
      Enable_Clock (Motor_123_Timer);
      Enable_Clock (Motor_4_Timer);
      Reset (Motor_123_Timer);
      Reset (Motor_4_Timer);

	  --  Configure PWM frequency at 328KHz
      Configure (This          => Motor_123_Timer,
                 Prescaler     => 0,
                 Period        => UInt32 (System_Clock_Frequencies.TIMCLK1 / 328_000) - 1);
      Configure (This          => Motor_4_Timer,
                 Prescaler     => 0,
                 Period        => UInt32 (System_Clock_Frequencies.TIMCLK1 / 328_000) - 1);

      Enable (This => Motor_123_Timer);
      Enable (This => Motor_4_Timer);

      Configure_Channel_Output (This     => Motor_123_Timer,
                                Channel  => Motor_1_Channel,
                                Mode     => PWM1,
                                State    => Enable,
                                Pulse    => 0,
                                Polarity => High);
      Configure_Channel_Output (This     => Motor_123_Timer,
                                Channel  => Motor_2_Channel,
                                Mode     => PWM1,
                                State    => Enable,
                                Pulse    => 0,
                                Polarity => High);
      Configure_Channel_Output (This     => Motor_123_Timer,
                                Channel  => Motor_3_Channel,
                                Mode     => PWM1,
                                State    => Enable,
                                Pulse    => 0,
                                Polarity => High);
      Configure_Channel_Output (This     => Motor_4_Timer,
                                Channel  => Motor_4_Channel,
                                Mode     => PWM1,
                                State    => Enable,
                                Pulse    => 0,
                                Polarity => High);

      Enable_Channel (This    => Motor_123_Timer,
                      Channel => Motor_1_Channel);
      Enable_Channel (This    => Motor_123_Timer,
                      Channel => Motor_2_Channel);
      Enable_Channel (This    => Motor_123_Timer,
                      Channel => Motor_3_Channel);
      Enable_Channel (This    => Motor_4_Timer,
                      Channel => Motor_4_Channel);
   end Configure_Timer;

   procedure Set_PWM_Motor_1 (PWM : PWM_Value) is
   begin
      Set_Compare_Value (This       => Motor_123_Timer,
                         Channel    => Motor_1_Channel,
                         Word_Value => UInt32 (PWM));
   end Set_PWM_Motor_1;

   procedure Set_PWM_Motor_2 (PWM : PWM_Value) is
   begin
      Set_Compare_Value (This       => Motor_123_Timer,
                         Channel    => Motor_2_Channel,
                         Word_Value => UInt32 (PWM));
   end Set_PWM_Motor_2;

   procedure Set_PWM_Motor_3 (PWM : PWM_Value) is
   begin
      Set_Compare_Value (This       => Motor_123_Timer,
                         Channel    => Motor_3_Channel,
                         Word_Value => UInt32 (PWM));
   end Set_PWM_Motor_3;

   procedure Set_PWM_Motor_4 (PWM : PWM_Value) is
   begin
      Set_Compare_Value (This    => Motor_4_Timer,
                         Channel => Motor_4_Channel,
                         Value   => PWM);
   end Set_PWM_Motor_4;

end PWM;
