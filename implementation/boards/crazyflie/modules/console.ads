package Console is

   procedure Console_Init;

   procedure Print (data : String);
   procedure Println (data : String);

private

   procedure Configure_GPIO;
   procedure Configure_USART;

end Console;
