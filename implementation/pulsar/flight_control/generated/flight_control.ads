--  Copyright (C) Your Company Name
--
--  @generated with QGen Code Generator 19.0w (20180218)
--  Command line arguments: model/Flight_Control.mdl
--    --clean
--    --language ada
--    --typing model/Flight_Control_types.txt
--    --matlab model/Flight_Control_parameters.m
--    --output ./generated

pragma Style_Checks ("M999");  --  ignore long lines

with Flight_Control_types; use Flight_Control_types;
with Interfaces; use Interfaces;

package Flight_Control is

   procedure init;

   procedure initStates;

   procedure comp
      (Rc_Orders_Throttle : Float;
       Rc_Orders_Rates : Float_Array_3;
       Attitude_Rates : Float_Array_3;
       Flight_Mode : Unsigned_8;
       Rc_Orders_Angles : Float_Array_2;
       Attitude_Angles : Float_Array_2;
       Flight_Control_Throttle : out Float;
       Attitude_Corrections : out Float_Array_3;
       Stop : out Boolean);

end Flight_Control;
--  @EOF
