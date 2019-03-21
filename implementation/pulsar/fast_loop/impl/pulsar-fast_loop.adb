with Pulsar.Constants;
with Pulsar.Autopilot;
with Boards.Hardware_Factory;
with Hal.Core;

with Ada.Real_Time; use Ada.Real_Time;

package body Pulsar.Fast_Loop is

   task body Fast_Loop is
      --  Update delay in milliseconds, it takes into account the configure Fast_Loop_Frequency
      Update_Delay_In_Ms : constant Time_Span := Milliseconds (1000 / Pulsar.Constants.Fast_Loop_Frequency);

      --  Next time to process the fast loop
      Time_To_Wake_Up : Time := Clock;

      --  Hardware factory (object implementation depends on the switch passed on command line at build process)
      Hardware_Factory : constant Boards.Hardware_Factory.T_Hardware_Factory_Class_Access := Boards.Hardware_Factory.New_And_Initialize;

      Hal_Core : constant Hal.Core.T_Hal_Class_Access := Hardware_Factory.Get_Hal;

      Autopilot : constant Pulsar.Autopilot.T_Autopilot_Class_Access := Pulsar.Autopilot.New_And_Initialize (Hardware_Factory);
   begin
      --  Initialize the next time to process the main loop at "now", to ensure we don't miss any update periods
      --  due to autopilot initialization.
      Time_To_Wake_Up := Clock;

      --  Entering the main loop
      loop
         Hal_Core.Update_Board;

         Autopilot.Update;

         --  Now wait the necessary amount of time before restarting the loop
         Time_To_Wake_Up := Time_To_Wake_Up + Update_Delay_In_Ms;
         if Time_To_Wake_Up > Clock then
            delay until Time_To_Wake_Up;
         end if;
      end loop;
   end Fast_Loop;

end Pulsar.Fast_Loop;
