with Console;

package body Crazyflie.Battery is

   ----------------------------------------------------------------------------
   -- New_And_Initialize                                                     --
   ----------------------------------------------------------------------------
   not overriding
   function New_And_Initialize return not null T_Battery_Class_Access is
   begin
      Console.Console_Init;
      return new Crazyflie.Battery.T_Battery;
   end New_And_Initialize;

   ----------------------------------------------------------------------------
   -- Get_Status                                                             --
   ----------------------------------------------------------------------------
   overriding
   function Get_Status (This : not null access T_Battery) return Hal.Battery.T_Battery_Status is
   begin
      return This.Status;
   end Get_Status;

   ----------------------------------------------------------------------------
   -- Get_Charge_Ratio                                                       --
   ----------------------------------------------------------------------------
   overriding
   function Get_Charge_Ratio (This : not null access T_Battery) return Hal.Battery.T_Charge_Ratio is
   begin
      return This.Charge_Ratio;
   end Get_Charge_Ratio;

   ----------------------------------------------------------------------------
   -- Update                                                                 --
   ----------------------------------------------------------------------------
   not overriding
   procedure Update (This : not null access T_Battery) is
   begin
      -- TODO: implement the charge ratio computation.
      This.Status := Hal.Battery.Operational;
      This.Charge_Ratio := 50.0;
   end Update;

end Crazyflie.Battery;
