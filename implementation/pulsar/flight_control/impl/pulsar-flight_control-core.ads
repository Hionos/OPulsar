with Pulsar.Flight_Control.Types;
with Pulsar.Navigation_Reference.Core;
with Pulsar.Motors_Mixing.Core;
with Pulsar.Motors_Mixing.Types;
with Pulsar.Remote_Control.Core;

package Pulsar.Flight_Control.Core is

   -- Type defining the class object
   type T_Flight_Control is tagged private;

   -- Type defining a pointer to the class object
   type T_Flight_Control_Class_Access is access all T_Flight_Control'Class;

   ----------------------------------------------------------------------------
   -- REQ: Navigation_Reference_Interface is not null
   --      Remote_Control_Interface is not null
   --      Motors_Mixing_Interface is not null
   -- ENS: A new instance of T_Flight_Control is returned
   ----------------------------------------------------------------------------
   function New_And_Initialize (Navigation_Reference_Interface : in not null Pulsar.Navigation_Reference.Core.T_Navigation_Reference_Class_Access;
                                Remote_Control_Interface       : in not null Pulsar.Remote_Control.Core.T_Remote_Control_Class_Access;
                                Motors_Mixing_Interface        : in not null Pulsar.Motors_Mixing.Core.T_Motors_Mixing_Class_Access)
      return not null T_Flight_Control_Class_Access;

   ----------------------------------------------------------------------------
   -- REQ: Mode is range Pulsar.Flight_Control.Types.T_Flight_Mode
   -- ENS: Flight_Control Mode is set to the Mode value
   ----------------------------------------------------------------------------
   procedure Set_Mode (This : in out T_Flight_Control;
                       Mode : in Pulsar.Flight_Control.Types.T_Flight_Mode);

   ----------------------------------------------------------------------------
   -- REQ: None
   -- ENS: Output Throttle, Attitude Corrections and Stop Status are computed
   ----------------------------------------------------------------------------
   procedure Update (This : in out T_Flight_Control);

private
   type T_Flight_Control is tagged
      record
         Attitude_Corrections    : Pulsar.Motors_Mixing.Types.T_Attitude_Corrections := (others => 0.0);
         Mode                    : Pulsar.Flight_Control.Types.T_Flight_Mode := Pulsar.Flight_Control.Types.Stopped;
         Flight_Control_Throttle : Pulsar.Motors_Mixing.Types.T_Flight_Control_Throttle := 0.0;
         Stop                    : Boolean := True; -- Forces motor stop if equal to true

         Navigation_Reference_Interface : not null Pulsar.Navigation_Reference.Core.T_Navigation_Reference_Class_Access;
         Remote_Control_Interface       : not null Pulsar.Remote_Control.Core.T_Remote_Control_Class_Access;
         Motors_Mixing_Interface        : not null Pulsar.Motors_Mixing.Core.T_Motors_Mixing_Class_Access;
      end record;

end Pulsar.Flight_Control.Core;
