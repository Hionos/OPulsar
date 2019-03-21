--  Copyright (C) Your Company Name
--
--  @generated with QGen Code Generator 19.0w (20180218)
--  Command line arguments: attitude_estimator/model/Attitude_Estimator.mdl
--    --clean
--    --language ada
--    --typing attitude_estimator/model/Attitude_Estimator_types.txt
--    --matlab attitude_estimator/model/Attitude_Estimator_parameters.m
--    --output attitude_estimator/generated

pragma Style_Checks ("M999");  --  ignore long lines

package Attitude_Estimator_types is

   type slhistoryListType is (Favorites, Projects, Models);
   for slhistoryListType use (Favorites=>0, Projects=>1, Models=>2);

   subtype Long_Float_Array_4_Range_1 is Integer range 1 .. 4;
   type Long_Float_Array_4 is array (Long_Float_Array_4_Range_1) of Long_Float;
   subtype Float_Array_4_Range_1 is Integer range 1 .. 4;
   type Float_Array_4 is array (Float_Array_4_Range_1) of Float;
   subtype Float_Array_3_Range_1 is Integer range 1 .. 3;
   type Float_Array_3 is array (Float_Array_3_Range_1) of Float;
   subtype Float_Array_5_Range_1 is Integer range 1 .. 5;
   type Float_Array_5 is array (Float_Array_5_Range_1) of Float;
   subtype Float_Array_2_Range_1 is Integer range 1 .. 2;
   type Float_Array_2 is array (Float_Array_2_Range_1) of Float;
   subtype Long_Float_Array_3_Range_1 is Integer range 1 .. 3;
   type Long_Float_Array_3 is array (Long_Float_Array_3_Range_1) of Long_Float;
end Attitude_Estimator_types;
--  @EOF
