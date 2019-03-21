-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This package provides routines to handle the logger output stream         --
-- hardware abstraction Layer                                                --
-------------------------------------------------------------------------------

package Hal.Logger_Stream
is

   -- Type defining the interface object
   type T_Logger_Stream is limited interface;

   -- Type defining a pointer to the interface object
   type T_Logger_Stream_Class_Access is access all T_Logger_Stream'Class;

   subtype T_Text_Message is String (1 .. 255);

   ----------------------------------------------------------------------------
   -- REQ : Message is the text message to log
   -- ENS : Message has been logged onto logger output stream
   ----------------------------------------------------------------------------
   procedure Log_Text_Message (This    : in out T_Logger_Stream;
                               Message : in T_Text_Message) is abstract;

end Hal.Logger_Stream;
