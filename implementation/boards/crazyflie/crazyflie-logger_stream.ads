-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This package provides routines to handle the Logger Stream hardware for   --
-- Crazyflie                                                                 --
-------------------------------------------------------------------------------

with Hal.Logger_Stream;

package Crazyflie.Logger_Stream is

   -- Type defining the class object
   type T_Logger_Stream is new Hal.Logger_Stream.T_Logger_Stream with private;

   -- Type defining a pointer to the class object
   type T_Logger_Stream_Class_Access is access all T_Logger_Stream'Class;

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: Return new instance of T_Logger_Stream
   ----------------------------------------------------------------------------
   not overriding
   function New_And_Initialize return not null T_Logger_Stream_Class_Access;

   ----------------------------------------------------------------------------
   -- REQ : Message is the text message to log
   -- ENS : Message has been logged onto logger output stream
   ----------------------------------------------------------------------------
   overriding
   procedure Log_Text_Message (This    : in out T_Logger_Stream;
                               Message : Hal.Logger_Stream.T_Text_Message);

private

   type T_Logger_Stream is new Hal.Logger_Stream.T_Logger_Stream with
      record
         Text_Message : Hal.Logger_Stream.T_Text_Message := (others => Character'Val (0));
      end record;

end Crazyflie.Logger_Stream;
