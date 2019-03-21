package body Pulsar.Logger.Core
is

   ----------------------------------------------------------------------------
   -- New_And_Initialize                                                     --
   ----------------------------------------------------------------------------
   function New_And_Initialize (Logger_Stream_Interface : not null Hal.Logger_Stream.T_Logger_Stream_Class_Access)
      return not null T_Logger_Class_Access is
   begin
      return new T_Logger'(Logger_Stream_Interface => Logger_Stream_Interface,
                           others                  => <>);
   end New_And_Initialize;

   ----------------------------------------------------------------------------
   -- Set_Text_Message                                                       --
   ----------------------------------------------------------------------------
   procedure Set_Text_Message (This         : in out T_Logger;
                               Text_Message : in Hal.Logger_Stream.T_Text_Message) is
   begin
      This.Text_Message := Text_Message;
   end Set_Text_Message;

   ----------------------------------------------------------------------------
   -- Update                                                                 --
   ----------------------------------------------------------------------------
   procedure Update (This : in out T_Logger) is
   begin
      This.Logger_Stream_Interface.Log_Text_Message (This.Text_Message);
   end Update;

end Pulsar.Logger.Core;
