with Crazyflie.Device; use Crazyflie.Device;

with STM32.Device; use STM32.Device;
with STM32.GPIO;   use STM32.GPIO;
with STM32.Timers; use STM32.Timers;

with Interfaces; use Interfaces;

package body PPM is

   procedure PPM_Init is
   begin
      Configure_GPIO;
      Configure_Timer;
   end PPM_Init;

   function Get_Channel (Channel_Number : Integer) return Uint16 is
   begin
      return Radio_Channels (Channel_Number);
   end Get_Channel;

   function Get_Status return Hardware_Status is
   begin
      return Signal_Status;
   end Get_Status;

   procedure Configure_GPIO
   is
      Configuration : GPIO_Port_Configuration;
   begin
      Enable_Clock (PPM_Input.Periph.all);

      Configuration.Mode        := Mode_AF;
      Configuration.Output_Type := Push_Pull;
      Configuration.Resistors   := Floating;
      Configuration.Speed       := Speed_100MHz;

      Configure_IO (PPM_Input, Configuration);
      Configure_Alternate_Function (PPM_Input, PPM_AF);
   end Configure_GPIO;

   procedure Configure_Timer is
   begin
      Enable_Clock (PPM_Timer);
      Reset (PPM_Timer);

      --  Configure timer frequencie at 1MHz with full period
      Configure (This          => PPM_Timer,
                 Prescaler     => UInt16 ((System_Clock_Frequencies.TIMCLK1 / 1_000_000) - 1),
                 Period        => 16#FFFF#);

      Enable (This => PPM_Timer);

      Configure_Channel_Input (This      => PPM_Timer,
                               Channel   => PPM_Channel,
                               Polarity  => Falling,
                               Selection => Direct_TI,
                               Prescaler => Div1,
                               Filter    => 0);

      Enable_Interrupt (This   => PPM_Timer,
                        Source => Timer_CC1_Interrupt);

      -- Enable interrupt when timer overflow to detect loss of signal
      Enable_Interrupt (This   => PPM_Timer,
                        Source => Timer_Update_Interrupt);

      Enable_Channel (This    => PPM_Timer,
                      Channel => PPM_Channel);
   end Configure_Timer;

   protected body Handler is

      -----------------
      -- IRQ_Handler --
      -----------------

      procedure IRQ_Handler is
         Min_Width : constant Uint16 := 700;
         Max_Width : constant Uint16 := 2300;
      begin
         if Status (This => PPM_Timer, Flag => Timer_CC1_Indicated) then
            -- PPM signal detected
            Clear_Pending_Interrupt (This   => PPM_Timer,
                                     Source => Timer_CC1_Interrupt);

            -- Reset the number of overflow
            Number_Of_Overflow := 0;

            --  Time values are in us
            Last_Time_Interrupt := Current_Time_Interrupt;
            Current_Time_Interrupt := Current_Capture_Value (This    => PPM_Timer,
                                                             Channel => PPM_Channel);

            if Current_Time_Interrupt >= Last_Time_Interrupt then
               Time_Difference := Current_Time_Interrupt - Last_Time_Interrupt;
            else
               Time_Difference := Uint16'Last - Last_Time_Interrupt + Current_Time_Interrupt;
            end if;

            if Time_Difference > Max_Width then
               Channel_Number := 1;
            elsif Channel_Number > 0 then
               if Time_Difference > Min_Width and Time_Difference < Max_Width
               then
                  if Time_Difference > 2000 then
                     Time_Difference := 2000;
                  elsif Time_Difference < 1000 then
                     Time_Difference := 1000;
                  end if;

                  Radio_Channels (Channel_Number) := Time_Difference;

                  -- Update PPM status
                  Signal_Status := Operational;
               end if;

               if Channel_Number < 16 then
                  Channel_Number := Channel_Number + 1;
               end if;
            end if;
         elsif Status (This => PPM_Timer, Flag => Timer_Update_Indicated) then
            -- Timer overflow
            Clear_Pending_Interrupt (This   => PPM_Timer,
                                     Source => Timer_Update_Interrupt);

            Number_Of_Overflow := Number_Of_Overflow + 1;

            if Number_Of_Overflow >= 2 then
               -- If the timer reach 2 consecutives overflow then the PPM signal is lost
               -- It means that we do not detect falling edge for at least 65 milliseconds (16 bits timer, count at 1MHz)
               -- PPM Signal generates edges at, at least, 50Hz (20 milliseconds)
               -- Set status to failure
               Signal_Status := Failure;
            end if;
         end if;
      end IRQ_Handler;

   end Handler;

end PPM;
