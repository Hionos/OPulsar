-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This package provides routines to handle the external communication       --
-- Hardware Abstraction Layer                                                --
-------------------------------------------------------------------------------

with Interfaces;

package Hal.External_Communication is

   -- Type defining the interface object
   type T_External_Communication is limited interface;

   -- Type defining a pointer to the interface object
   type T_External_Communication_Class_Access is access all T_External_Communication'Class;

   subtype uint8 is Interfaces.Unsigned_8;
   type T_Byte_Message is array (Natural range <>) of uint8;

   ----------------------------------------------------------------------------
   -- REQ : Message is the byte array to send
   -- ENS : Message has been sent
   ----------------------------------------------------------------------------
   procedure Send_Message (This    : in out T_External_Communication;
                           Message : in T_Byte_Message) is abstract;

end Hal.External_Communication;
