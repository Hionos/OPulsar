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

package Flight_Control_types is

   type slhistoryListType is (Favorites, Projects, Models);
   for slhistoryListType use (Favorites=>0, Projects=>1, Models=>2);

   subtype Float_Array_1_Range_1 is Integer range 1 .. 1;
   type Float_Array_1 is array (Float_Array_1_Range_1) of Float;
   subtype Float_Array_3_Range_1 is Integer range 1 .. 3;
   type Float_Array_3 is array (Float_Array_3_Range_1) of Float;
   subtype Float_Array_2_Range_1 is Integer range 1 .. 2;
   type Float_Array_2 is array (Float_Array_2_Range_1) of Float;
end Flight_Control_types;
--  @EOF
