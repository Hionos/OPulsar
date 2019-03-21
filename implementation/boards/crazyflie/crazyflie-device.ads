with STM32.Device; use STM32.Device;
with STM32.GPIO;   use STM32.GPIO;
with STM32.USARTs; use STM32.USARTs;
with STM32.Timers; use STM32.Timers;
with STM32.I2C;    use STM32.I2C;

package Crazyflie.Device is

   ---------
   -- Led --
   ---------

   GPIO_Led_Green_R : GPIO_Point renames PC2;
   GPIO_Led_Green_L : GPIO_Point renames PC1;
   GPIO_Led_Red_R   : GPIO_Point renames PC3;
   GPIO_Led_Red_L   : GPIO_Point renames PC0;
   GPIO_Led_Blue    : GPIO_Point renames PD2;

   -------------
   -- Console --
   -------------

   EXT_SERIAL_TX : GPIO_Point renames PC10;
   EXT_SERIAL_AF : GPIO_Alternate_Function renames GPIO_AF_USART3;
   EXT_SERIAL    : USART renames USART_3;

   -----------------
   ---- PPM input --
   -----------------

   PPM_Input   : GPIO_Point renames PB4;
   PPM_AF      : GPIO_Alternate_Function renames GPIO_AF_TIM3;
   PPM_Timer   : Timer renames Timer_3;
   PPM_Channel : Timer_Channel renames Channel_1;

   ---------
   -- IMU --
   ---------

   IMU_SCL   : GPIO_Point renames PA8;
   IMU_SDA   : GPIO_Point renames PC9;

   IMU_AF  : GPIO_Alternate_Function renames GPIO_AF_I2C;
   IMU_I2C : I2C_Port renames I2C_3;

   ------------
   -- Motors --
   ------------

   Motor_1         : GPIO_Point renames PA1;
   Motor_2         : GPIO_Point renames PB11;
   Motor_3         : GPIO_Point renames PA15;
   Motor_4         : GPIO_Point renames PB9;

   Motor_1_AF      : GPIO_Alternate_Function renames GPIO_AF_TIM2;
   Motor_2_AF      : GPIO_Alternate_Function renames GPIO_AF_TIM2;
   Motor_3_AF      : GPIO_Alternate_Function renames GPIO_AF_TIM2;
   Motor_4_AF      : GPIO_Alternate_Function renames GPIO_AF_TIM4;

   Motor_1_Channel : Timer_Channel renames Channel_2;
   Motor_2_Channel : Timer_Channel renames Channel_4;
   Motor_3_Channel : Timer_Channel renames Channel_1;
   Motor_4_Channel : Timer_Channel renames Channel_4;

   Motor_123_Timer : Timer renames Timer_2;
   Motor_4_Timer   : Timer renames Timer_4;

   --------------------
   -- Modules Update --
   --------------------

   Modules_Update_Timer : Timer renames Timer_5;

end Crazyflie.Device;
