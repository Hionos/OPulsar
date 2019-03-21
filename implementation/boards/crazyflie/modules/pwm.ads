with HAL_Type; use HAL_Type;

with Hal.Motors;

package PWM is

   procedure PWM_Init;

   procedure Set_Motor1_Speed (Speed : Hal.Motors.T_Speed);
   procedure Set_Motor2_Speed (Speed : Hal.Motors.T_Speed);
   procedure Set_Motor3_Speed (Speed : Hal.Motors.T_Speed);
   procedure Set_Motor4_Speed (Speed : Hal.Motors.T_Speed);

private

   subtype PWM_Value is UInt16 range 0 .. 256;

   procedure Configure_GPIO;
   procedure Configure_Timer;

   procedure Set_PWM_Motor_1 (PWM : PWM_Value);
   procedure Set_PWM_Motor_2 (PWM : PWM_Value);
   procedure Set_PWM_Motor_3 (PWM : PWM_Value);
   procedure Set_PWM_Motor_4 (PWM : PWM_Value);

end PWM;
