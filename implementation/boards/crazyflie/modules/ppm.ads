with Ada.Interrupts.Names; use Ada.Interrupts.Names;

with HAL_Type; use HAL_Type;

package PPM is

   type Channels is array (1..16) of UInt16;
   type Hardware_Status is (Operational, Failure);

   procedure PPM_Init;

   function Get_Channel (Channel_Number : Integer) return UInt16;
   function Get_Status return Hardware_Status;

   protected Handler is
      pragma Interrupt_Priority;
   private

      procedure IRQ_Handler;
      pragma Attach_Handler (IRQ_Handler, TIM3_Interrupt);

   end Handler;

private

   procedure Configure_GPIO;
   procedure Configure_Timer;

   Radio_Channels : Channels := (1500, 1500, 1000, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500 ,1500, 1500, 1500, 1500);
   Signal_Status : Hardware_Status := Failure;

   Last_Time_Interrupt    : Uint16 := 0;
   Current_Time_Interrupt : Uint16 := 0;
   Time_Difference        : Uint16 := 0;
   Channel_Number         : Integer range 0 .. 16 := 0;
   Number_Of_Overflow     : Integer := 0;

end PPM;
