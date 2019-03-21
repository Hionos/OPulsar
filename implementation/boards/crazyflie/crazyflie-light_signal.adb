with Crazyflie.Device; use Crazyflie.Device;

with STM32.Device; use STM32.Device;
with STM32.GPIO;   use STM32.GPIO;

package body Crazyflie.Light_Signal is

   ----------------------------------------------------------------------------
   -- New_And_Initialize                                                     --
   ----------------------------------------------------------------------------
   not overriding
   function New_And_Initialize return not null T_Light_Signal_Class_Access is
      Configuration : GPIO_Port_Configuration;
   begin
      Enable_Clock (GPIO_C);
      Enable_Clock (GPIO_D);

      Configuration.Mode        := Mode_Out;
      Configuration.Output_Type := Push_Pull;
      Configuration.Speed       := Speed_100MHz;
      Configuration.Resistors   := Floating;

      Configure_IO (GPIO_Led_Green_R, Configuration);
      Configure_IO (GPIO_Led_Green_L, Configuration);
      Configure_IO (GPIO_Led_Red_R, Configuration);
      Configure_IO (GPIO_Led_Red_L, Configuration);

      -- Light up the back blue led
      Configure_IO (GPIO_Led_Blue, Configuration);
      Set (GPIO_Led_Blue);

      return new Crazyflie.Light_Signal.T_Light_Signal;
   end New_And_Initialize;

   ----------------------------------------------------------------------------
   -- Set_State                                                              --
   ----------------------------------------------------------------------------
   overriding
   procedure Set_State (This        : in out T_Light_Signal;
                        Light_State : in Hal.Light_Signal.T_Light_State) is
      pragma Unreferenced (This);
   begin
      case Light_State is
         when Hal.Light_Signal.OFF =>
            Set (GPIO_Led_Green_R);
            Set (GPIO_Led_Green_L);
            Set (GPIO_Led_Red_R);
            Set (GPIO_Led_Red_L);

         when Hal.Light_Signal.Green =>
            Clear (GPIO_Led_Green_R);
            Clear (GPIO_Led_Green_L);
            Set (GPIO_Led_Red_R);
            Set (GPIO_Led_Red_L);

         when Hal.Light_Signal.Red =>
            Set (GPIO_Led_Green_R);
            Set (GPIO_Led_Green_L);
            Clear (GPIO_Led_Red_R);
            Clear (GPIO_Led_Red_L);
      end case;
   end Set_State;

end Crazyflie.Light_Signal;
