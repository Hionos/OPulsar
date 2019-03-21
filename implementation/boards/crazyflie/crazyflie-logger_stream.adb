package body Crazyflie.Logger_Stream is

   ----------------------------------------------------------------------------
   -- New_And_Initialize                                                     --
   ----------------------------------------------------------------------------
   not overriding
   function New_And_Initialize return not null T_Logger_Stream_Class_Access is
   begin
      return new Crazyflie.Logger_Stream.T_Logger_Stream;
   end New_And_Initialize;

   ----------------------------------------------------------------------------
   -- Log_Text_Message                                                       --
   ----------------------------------------------------------------------------
   overriding
   procedure Log_Text_Message (This    : in out T_Logger_Stream;
                               Message : Hal.Logger_Stream.T_Text_Message) is
   begin
      This.Text_Message := Message;
   end Log_Text_Message;

end Crazyflie.Logger_Stream;
