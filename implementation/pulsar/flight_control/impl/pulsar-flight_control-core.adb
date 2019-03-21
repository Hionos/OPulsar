with Flight_Control;
with Flight_Control_types;
with Interfaces; use Interfaces;

package body Pulsar.Flight_Control.Core is

   ----------------------------------------------------------------------------
   --  New_And_Initialize                                                    --
   ----------------------------------------------------------------------------
   function New_And_Initialize (Navigation_Reference_Interface : in not null Pulsar.Navigation_Reference.Core.T_Navigation_Reference_Class_Access;
                                Remote_Control_Interface       : in not null Pulsar.Remote_Control.Core.T_Remote_Control_Class_Access;
                                Motors_Mixing_Interface        : in not null Pulsar.Motors_Mixing.Core.T_Motors_Mixing_Class_Access) return not null T_Flight_Control_Class_Access is
   begin
      --  Initialize the Matlab/Simulink Model
      Standard.Flight_Control.init;

      --  Return the new instance of Flight_Control object
      return new T_Flight_Control'(Attitude_Corrections           => Pulsar.Motors_Mixing.Types.T_Attitude_Corrections'(others => 0.0),
                                   Mode                           => Pulsar.Flight_Control.Types.Stopped,
                                   Flight_Control_Throttle        => 0.0,
                                   Stop                           => True,
                                   Navigation_Reference_Interface => Navigation_Reference_Interface,
                                   Remote_Control_Interface       => Remote_Control_Interface,
                                   Motors_Mixing_Interface        => Motors_Mixing_Interface);
   end New_And_Initialize;

   ----------------------------------------------------------------------------
   --  Set_Mode                                                              --
   ----------------------------------------------------------------------------
   procedure Set_Mode (This: in out T_Flight_Control;
                       Mode: in Pulsar.Flight_Control.Types.T_Flight_Mode) is
   begin
      This.Mode := Mode;
   end Set_Mode;

   ----------------------------------------------------------------------------
   --  Update                                                                --
   ----------------------------------------------------------------------------
   procedure Update (This : in out T_Flight_Control) is
      Model_Rc_Throttle     : constant Float := Float(This.Remote_Control_Interface.Get_Rc_Orders.Throttle);
      Model_Rc_Rates        : constant Flight_Control_types.Float_Array_3 := (
         Float (This.Remote_Control_Interface.Get_Rc_Orders.Rates.Roll),
         Float (This.Remote_Control_Interface.Get_Rc_Orders.Rates.Pitch),
         Float (This.Remote_Control_Interface.Get_Rc_Orders.Rates.Yaw)
         );
      Model_Attitude_Rates  : constant Flight_Control_types.Float_Array_3 := (
         Float (This.Navigation_Reference_Interface.Get_Attitude.Rates.Roll),
         Float (This.Navigation_Reference_Interface.Get_Attitude.Rates.Pitch),
         Float (This.Navigation_Reference_Interface.Get_Attitude.Rates.Yaw)
         );
      Model_Flight_Mode     : constant Unsigned_8 := Pulsar.Flight_Control.Types.T_Flight_Mode'Pos(This.Mode) + 1;
      Model_Rc_Angles       : constant Flight_Control_types.Float_Array_2 := (
         Float (This.Remote_Control_Interface.Get_Rc_Orders.Angles.Roll),
         Float (This.Remote_Control_Interface.Get_Rc_Orders.Angles.Pitch)
      );
      Model_Attitude_Angles : constant Flight_Control_types.Float_Array_2 := (
         Float (This.Navigation_Reference_Interface.Get_Attitude.Angles.Roll),
         Float (This.Navigation_Reference_Interface.Get_Attitude.Angles.Pitch)
      );

      Model_Flight_Control_Throttle : Float;
      Model_Attitude_Corrections    : Flight_Control_types.Float_Array_3;
      Model_Stop                    : Boolean;
   begin
      --  Should set the inputs to the model and exercize it
      Standard.Flight_Control.comp (Rc_Orders_Throttle      => Model_Rc_Throttle,
                                    Rc_Orders_Rates         => Model_Rc_Rates,
                                    Attitude_Rates          => Model_Attitude_Rates,
                                    Flight_Mode             => Model_Flight_Mode,
                                    Rc_Orders_Angles        => Model_Rc_Angles,
                                    Attitude_Angles         => Model_Attitude_Angles,
                                    Flight_Control_Throttle => Model_Flight_Control_Throttle,
                                    Attitude_Corrections    => Model_Attitude_Corrections,
                                    Stop                    => Model_Stop);

      --  Then get and store the outputs
      This.Flight_Control_Throttle    := Pulsar.Motors_Mixing.Types.T_Flight_Control_Throttle (Model_Flight_Control_Throttle);
      This.Attitude_Corrections.Roll  := Pulsar.Motors_Mixing.Types.T_Attitude_Correction (Model_Attitude_Corrections (1));
      This.Attitude_Corrections.Pitch := Pulsar.Motors_Mixing.Types.T_Attitude_Correction (Model_Attitude_Corrections (2));
      This.Attitude_Corrections.Yaw   := Pulsar.Motors_Mixing.Types.T_Attitude_Correction (Model_Attitude_Corrections (3));
      This.Stop                       := Model_Stop;

      --  Set the outputs to Motors_Mixing component
      This.Motors_Mixing_Interface.Set_Stop (This.Stop);
      This.Motors_Mixing_Interface.Set_Flight_Control_Throttle (This.Flight_Control_Throttle);
      This.Motors_Mixing_Interface.Set_Attitude_Corrections (This.Attitude_Corrections);
   end Update;

end Pulsar.Flight_Control.Core;
