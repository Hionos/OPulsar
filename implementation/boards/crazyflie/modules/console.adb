with Crazyflie.Device; use Crazyflie.Device;

with STM32.Device; use STM32.Device;
with STM32.GPIO;   use STM32.GPIO;
with STM32.USARTs;  use STM32.USARTs;

with HAL_Type; use HAL_Type;

package body Console is

   procedure Console_Init is
   begin
      Configure_GPIO;
      Configure_USART;
   end Console_Init;

   procedure Print (data : String) is
   begin
      for c in Data'Range loop
         Transmit (EXT_SERIAL, Character'Pos(Data (c)));
      end loop;
   end Print;

   procedure Println (data : String) is
   begin
      for c in Data'Range loop
         Transmit (EXT_SERIAL, Character'Pos(Data (c)));
      end loop;

	  -- Transmit new line character (\n)
      Transmit (EXT_SERIAL, UInt9 (16#0A#));
   end Println;

   procedure Configure_GPIO
   is
      Configuration : GPIO_Port_Configuration;
   begin
      Enable_Clock (EXT_SERIAL_TX.Periph.all);

      Configuration.Mode        := Mode_AF;
      Configuration.Output_Type := Push_Pull;
      Configuration.Resistors   := Floating;
      Configuration.Speed       := Speed_100MHz;

      Configure_IO (EXT_SERIAL_TX, Configuration);
      Configure_Alternate_Function (EXT_SERIAL_TX, EXT_SERIAL_AF);
   end Configure_GPIO;

   procedure Configure_USART is
   begin
      Enable_Clock (EXT_SERIAL);
      Reset (EXT_SERIAL);

      Set_Baud_Rate (EXT_SERIAL, 921600);
      Set_Mode (EXT_SERIAL, Tx_Mode);

      Enable (EXT_SERIAL);
   end Configure_USART;

end Console;
