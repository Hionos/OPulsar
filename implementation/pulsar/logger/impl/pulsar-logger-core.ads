-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This is the main Logger Package definition                                --
-------------------------------------------------------------------------------

with Hal.Logger_Stream;

package Pulsar.Logger.Core
is

   -- Type defining the class object
   type T_Logger is tagged private;

   -- Type defining a pointer to the class object
   type T_Logger_Class_Access is access all T_Logger'Class;

   ----------------------------------------------------------------------------
   -- REQ: Logger_Stream_Interface is not null
   -- ENS: Return new instance of T_Logger
   ----------------------------------------------------------------------------
   function New_And_Initialize (Logger_Stream_Interface : not null Hal.Logger_Stream.T_Logger_Stream_Class_Access) return not null T_Logger_Class_Access;

   ----------------------------------------------------------------------------
   -- REQ : Text_Message is a text message
   -- ENS : Logger Text Message is set with Text_Message value
   ----------------------------------------------------------------------------
   procedure Set_Text_Message (This         : in out T_Logger;
                               Text_Message : in Hal.Logger_Stream.T_Text_Message);

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: The Text Message is logged onto logger stream interface
   ----------------------------------------------------------------------------
   procedure Update (This : in out T_Logger);

private
   type T_Logger is tagged
      record
         Text_Message            : Hal.Logger_Stream.T_Text_Message;
         Logger_Stream_Interface : not null Hal.Logger_Stream.T_Logger_Stream_Class_Access;
      end record;

end Pulsar.Logger.Core;
