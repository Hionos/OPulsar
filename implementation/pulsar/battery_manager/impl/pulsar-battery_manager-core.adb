-------------------------------------------------------------------------------
--                       PULSAR FLIGHT SYSTEM                                --
--                                                                           --
--           Copyright (C) 2016-2017, SOGILIS <http://sogilis.com>           --
--                                                                           --
-------------------------------------------------------------------------------

with Pulsar.Battery_Manager.Types; use Pulsar.Battery_Manager.Types;
with Hal.Battery; use Hal.Battery;

package body Pulsar.Battery_Manager.Core
is

   Low_Battery_Level_Ratio : constant := 10.0;

   ----------------------------------------------------------------------------
   -- New_And_Initialize                                                     --
   ----------------------------------------------------------------------------
   function New_And_Initialize (Battery_Interface : not null Hal.Battery.T_Battery_Class_Access)
      return not null T_Battery_Manager_Class_Access
   is
   begin
      -- Return the instance
      return new T_Battery_Manager'(Battery_Interface                   => Battery_Interface,
                                    Battery_Level_Sufficient_For_Flight => False,
                                    Battery_Status                      => Pulsar.Battery_Manager.Types.Initialization);
   end New_And_Initialize;

   ----------------------------------------------------------------------------
   -- Is_Battery_Level_Sufficient_For_Flight                                 --
   ----------------------------------------------------------------------------
   function Is_Battery_Level_Sufficient_For_Flight (This : T_Battery_Manager) return Boolean is
   begin
      return This.Battery_Level_Sufficient_For_Flight;
   end Is_Battery_Level_Sufficient_For_Flight;

   ----------------------------------------------------------------------------
   -- Get_Battery_Status                                                     --
   ----------------------------------------------------------------------------
   function Get_Battery_Status (This : T_Battery_Manager) return Pulsar.Battery_Manager.Types.T_Battery_Manager_Status is
   begin
      return This.Battery_Status;
   end Get_Battery_Status;

   ----------------------------------------------------------------------------
   -- Update                                                                 --
   ----------------------------------------------------------------------------
   procedure Update (This : in out T_Battery_Manager) is
      Status_To_Status : constant array (T_Battery_Status) of T_Battery_Manager_Status :=
         (Undefined   => Initialization,
          Operational => Operational,
          Failure     => Failure);
   begin
      This.Battery_Level_Sufficient_For_Flight := (This.Battery_Interface.Get_Charge_Ratio >= Low_Battery_Level_Ratio) and
        (This.Battery_Interface.Get_Status = Operational);

      This.Battery_Status := Status_To_Status (This.Battery_Interface.Get_Status);
   end Update;

end Pulsar.Battery_Manager.Core;
