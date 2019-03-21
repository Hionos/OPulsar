with Ada.Numerics; use Ada.Numerics;

with Crazyflie.Device; use Crazyflie.Device;

with STM32.Device; use STM32.Device;
with STM32.GPIO;   use STM32.GPIO;
with STM32.I2C;    use STM32.I2C;

with Crazyflie.Maths;

package body Imu_Device is

   procedure IMU_Init_Registers is
   begin
      Configure_GPIO;
      Configure_I2C;

      MPU9250_Init_Start_Time := Clock;
   end IMU_Init_Registers;

   procedure IMU_Init_Device is
   begin
      if To_Duration (Clock - MPU9250_Init_Start_Time) >= 1.0
        and not Is_Device_Reset
        and not Is_Device_Initialized then
         MPU9250_Reset;
         Is_Device_Reset := True;
         MPU9250_Reset_Start_Time := Clock;
      elsif To_Duration (Clock - MPU9250_Reset_Start_Time) >= 0.05
        and Is_Device_Reset
        and not Is_Device_Initialized then
         --  Activate MPU9250
         MPU9250_Set_Sleep_Enabled (False);
         --  Enable temp sensor
         MPU9250_Set_Temp_Sensor_Enabled (True);
         --  Disable interrupts
         MPU9250_Set_Int_Enabled (False);
         --  Connect the HMC5883L to the main I2C bus
         MPU9250_Set_I2C_Bypass_Enabled (True);
         --  Set x-axis gyro as clock source
         MPU9250_Set_Clock_Source (X_Gyro_Clk);
         --  Set gyro full-scale range
         MPU9250_Set_Full_Scale_Gyro_Range (IMU_GYRO_FS_CONFIG);
         --  Set accel full-scale range
         MPU9250_Set_Full_Scale_Accel_Range (IMU_ACCEL_FS_CONFIG);

         --  To low DLPF bandwidth might cause instability and decrease
         --  agility but it works well for handling vibrations and
         --  unbalanced propellers.
         --  Set output rate (0): 1000 / (1 + 0) = 1kHz
         MPU9250_Set_Rate (0);
         --  Set digital low-pass bandwidth
         MPU9250_Set_DLPF_Mode (MPU9250_DLPF_BW_20);

         -- Reset bias before calibration
         IMU_Reset_Bias;

         Is_Device_Initialized := True;
      end if;
   end IMU_Init_Device;

   procedure IMU_Calibrate is
      Bias_Norme : Float;
   begin
      if Status = Hal.Imu.Undefined then
         if Gyro_Bias.Is_Buffer_Filled and Acc_Bias.Is_Buffer_Filled then
            if Gyro_Bias.Is_Bias_Value_Found and Acc_Bias.Is_Bias_Value_Found then
               Bias_Norme := Crazyflie.Maths.Sqrt ((Acc_Bias.Bias.X ** 2)
                                                 + (Acc_Bias.Bias.Y ** 2)
                                                 + (Acc_Bias.Bias.Z ** 2));
               Acc_Calibration_Scale := 1.0 / Bias_Norme;
               Status := Hal.Imu.Operational;
            else
               IMU_Reset_Bias;
            end if;
         else
            IMU_Calibrate_Gyro;
            IMU_Calibrate_Acc;
         end if;
      end if;
   end IMU_Calibrate;

   function IMU_Device_Initialized return Boolean is
   begin
      return Is_Device_Initialized;
   end IMU_Device_Initialized;

   function IMU_Get_Status return Hal.Imu.T_Hardware_Status is
   begin
      return Status;
   end IMU_Get_Status;

   function IMU_Get_Gyro return Hal.Imu.T_Gyro_Increments is
      Gyro     : Hal.Imu.T_Gyro_Increments;
      Gyro_IMU : Axis3_T_Int16;
      --Gyro_LPF : Axis3_T_Int32;
   begin
      -- We invert X and Y axis to be in the right referential
      MPU9250_Get_Gyro (Gyro_IMU.Y,  Gyro_IMU.X,  Gyro_IMU.Z);

      --  Filter gyrometer data
      --IMU_Acc_IRR_LP_Filter (Input         => Gyro_IMU,
      --                       Output        => Gyro_LPF,
      --                       Stored_Values => Gyro_Stored_Values,
      --                       Attenuation   => Integer_32 (IMU_GYRO_IIR_LPF_ATT_FACTOR));

      Gyro.x := -(Float (Gyro_IMU.X) - Gyro_Bias.Bias.X) * IMU_DEG_PER_LSB_CFG * Pi / 180.0;
      Gyro.y := -(Float (Gyro_IMU.Y) - Gyro_Bias.Bias.Y) * IMU_DEG_PER_LSB_CFG * Pi / 180.0;
      Gyro.z := -(Float (Gyro_IMU.Z) - Gyro_Bias.Bias.Z) * IMU_DEG_PER_LSB_CFG * Pi / 180.0;

      return Gyro;
   end IMU_Get_Gyro;

   function IMU_Get_Acc return Hal.Imu.T_Acceleration_Increments is
      Acc     : Hal.Imu.T_Acceleration_Increments;
      Acc_IMU : Axis3_T_Int16;
      --Acc_LPF : Axis3_T_Int32;
   begin
      -- We invert X and Y axis to be in the right referential
      MPU9250_Get_Acc (Acc_IMU.Y, Acc_IMU.X, Acc_IMU.Z);

      --  Filter accelerometer data
      --IMU_Acc_IRR_LP_Filter (Input         => Acc_IMU,
      --                       Output        => Acc_LPF,
      --                       Stored_Values => Acc_Stored_Values,
      --                       Attenuation   => Integer_32 (IMU_ACC_IIR_LPF_ATT_FACTOR));

      Acc.x := -Float (Acc_IMU.X) * Acc_Calibration_Scale * 9.81;
      Acc.y := -Float (Acc_IMU.Y) * Acc_Calibration_Scale * 9.81;
      Acc.z := -Float (Acc_IMU.Z) * Acc_Calibration_Scale * 9.81;

      return Acc;
   end IMU_Get_Acc;

   --procedure IMU_Get_Motion_6
   --  (Gyro : out Hal.Imu.T_Gyro_Increments;
   --   Acc  : out Hal.Imu.T_Acceleration_Increments)
   --is
   --   Accel_IMU : Axis3_T_Int16;
   --   Gyro_IMU  : Axis3_T_Int16;
   --begin
   --   -- We invert X and Y axis to be in the right referential
   --   MPU9250_Get_Motion_6 (Accel_IMU.Y,
   --                         Accel_IMU.X,
   --                         Accel_IMU.Z,
   --                         Gyro_IMU.Y,
   --                         Gyro_IMU.X,
   --                         Gyro_IMU.Z);

   --   --  Filter accelerometer data
   --   --IMU_Acc_IRR_LP_Filter (Input         => Accel_IMU,
   --   --                       Output        => Accel_LPF,
   --   --                       Stored_Values => Accel_Stored_Values,
   --   --                       Attenuation   => Integer_32 (IMU_ACC_IIR_LPF_ATT_FACTOR));

   --   --  Filter gyrometer data
   --   --IMU_Acc_IRR_LP_Filter (Input         => Gyro_IMU,
   --   --                       Output        => Gyro_LPF,
   --   --                       Stored_Values => Gyro_Stored_Values,
   --   --                       Attenuation   => Integer_32 (IMU_GYRO_IIR_LPF_ATT_FACTOR));

   --   Gyro.x := -(Float (Gyro_IMU.X) - Gyro_Bias.Bias.X) * IMU_DEG_PER_LSB_CFG * Pi / 180.0;
   --   Gyro.y := -(Float (Gyro_IMU.Y) - Gyro_Bias.Bias.Y) * IMU_DEG_PER_LSB_CFG * Pi / 180.0;
   --   Gyro.z := -(Float (Gyro_IMU.Z) - Gyro_Bias.Bias.Z) * IMU_DEG_PER_LSB_CFG * Pi / 180.0;

   --   Acc.x := -Float (Accel_IMU.X) * Acc_Calibration_Scale * 9.81;
   --   Acc.y := -Float (Accel_IMU.Y) * Acc_Calibration_Scale * 9.81;
   --   Acc.z := -Float (Accel_IMU.Z) * Acc_Calibration_Scale * 9.81;
   --end IMU_Get_Motion_6;

   procedure Start_IMU_Acquisition is
   begin
      MPU9250_Read_Motion_6;
   end Start_IMU_Acquisition;

   --procedure IMU_6_Read
   --  (Gyro : out Hal.Imu.T_Gyro_Increments;
   --   Acc  : out Hal.Imu.T_Acceleration_Increments)
   --is
   --   Accel_IMU : Axis3_T_Int16;
   --   Gyro_IMU  : Axis3_T_Int16;
   --   --Accel_LPF : Axis3_T_Int32;
   --begin
   --   --  We invert X and Y because the chip is also inverted.
   --   MPU9250_Read_Motion_6 (
   --     Accel_IMU.Y, Accel_IMU.X, Accel_IMU.Z,
   --     Gyro_IMU.Y,  Gyro_IMU.X,  Gyro_IMU.Z);

   --   --  Filter accelerometer data
   --   --IMU_Acc_IRR_LP_Filter (Input         => Accel_IMU,
   --   --                       Output        => Accel_LPF,
   --   --                       Stored_Values => Accel_Stored_Values,
   --   --                       Attenuation   => Integer_32 (IMU_ACC_IIR_LPF_ATT_FACTOR));

   --   --  Re-map outputs
   --   Gyro.x := (Float (Gyro_IMU.X) - Gyro_Bias.Bias.X) * IMU_DEG_PER_LSB_CFG * Pi / 180.0;
   --   Gyro.y := (Float (Gyro_IMU.Y) - Gyro_Bias.Bias.Y) * IMU_DEG_PER_LSB_CFG * Pi / 180.0;
   --   Gyro.z := (Float (Gyro_IMU.Z) - Gyro_Bias.Bias.Z) * IMU_DEG_PER_LSB_CFG * Pi / 180.0;

   --   Acc.x := Float (Accel_IMU.X) * Acc_Calibration_Scale * 9.81;
   --   Acc.y := Float (Accel_IMU.Y) * Acc_Calibration_Scale * 9.81;
   --   Acc.z := Float (Accel_IMU.Z) * Acc_Calibration_Scale * 9.81;
   --end IMU_6_Read;

   --procedure IMU_Read_Gyro (Gyro : out Hal.Imu.T_Gyro_Increments)
   --is
   --   Gyro_IMU  : Axis3_T_Int16;
   --begin
   --   --  We invert X and Y because the chip is also inverted.
   --   MPU9250_Get_Motion_Gyro (Gyro_IMU.Y,  Gyro_IMU.X,  Gyro_IMU.Z);

   --   --  Re-map outputs
   --   Gyro.x := -(Float (Gyro_IMU.X) - Gyro_Bias.Bias.X) * IMU_DEG_PER_LSB_CFG * Pi / 180.0;
   --   Gyro.y := (Float (Gyro_IMU.Y) - Gyro_Bias.Bias.Y) * IMU_DEG_PER_LSB_CFG * Pi / 180.0;
   --   Gyro.z := (Float (Gyro_IMU.Z) - Gyro_Bias.Bias.Z) * IMU_DEG_PER_LSB_CFG * Pi / 180.0;
   --end IMU_Read_Gyro;

   --procedure IMU_Read_Acc (Acc : out Hal.Imu.T_Acceleration_Increments)
   --is
   --   Accel_IMU : Axis3_T_Int16;
   --   --Accel_LPF : Axis3_T_Int32;
   --begin
   --   --  We invert X and Y because the chip is also inverted.
   --   MPU9250_Get_Motion_Acc (Accel_IMU.Y, Accel_IMU.X, Accel_IMU.Z);

   --   --  Filter accelerometer data
   --   --IMU_Acc_IRR_LP_Filter (Input         => Accel_IMU,
   --   --                       Output        => Accel_LPF,
   --   --                       Stored_Values => Accel_Stored_Values,
   --   --                       Attenuation   => Integer_32 (IMU_ACC_IIR_LPF_ATT_FACTOR));

   --   --  Re-map outputs
   --   Acc.x := Float (Accel_IMU.X) * IMU_G_PER_LSB_CFG * 9.807;
   --   Acc.y := -Float (Accel_IMU.Y) * IMU_G_PER_LSB_CFG * 9.807;
   --   Acc.z := -Float (Accel_IMU.Z) * IMU_G_PER_LSB_CFG * 9.807;
   --end IMU_Read_Acc;

   procedure Configure_GPIO is
      Configuration : GPIO_Port_Configuration;
   begin
      Enable_Clock (IMU_SCL.Periph.all);
      Enable_Clock (IMU_SDA.Periph.all);

      Configuration.Mode        := Mode_AF;
      Configuration.Output_Type := Open_Drain;
      Configuration.Resistors   := Floating;
      Configuration.Speed       := Speed_25MHz;

      Configure_IO (IMU_SCL, Configuration);
      Configure_IO (IMU_SDA, Configuration);
      Configure_Alternate_Function (IMU_SCL, IMU_AF);
      Configure_Alternate_Function (IMU_SDA, IMU_AF);
   end Configure_GPIO;

   procedure Configure_I2C is
   begin
      Enable_Clock (IMU_I2C);
      Reset (IMU_I2C);

      Configure
        (Handle => IMU_I2C,
         Conf   =>
           (Clock_Speed     => 400_000,
            Mode            => I2C_Mode,
            Duty_Cycle      => DutyCycle_16_9,
            Addressing_Mode => Addressing_Mode_7bit,
            Own_Address     => 0,
            others          => <>));
   end Configure_I2C;

   procedure IMU_Calibrate_Gyro is
      Gyro_IMU : Axis3_T_Int16;
   begin
      -- We invert X and Y axis to be in the right referential
      MPU9250_Read_Gyro (Gyro_IMU.Y,  Gyro_IMU.X,  Gyro_IMU.Z);
      IMU_Add_Bias_Value (Gyro_Bias, Gyro_IMU);

      if Gyro_Bias.Is_Buffer_Filled then
         IMU_Find_Bias_Value (Gyro_Bias);
      end if;
   end IMU_Calibrate_Gyro;

   procedure IMU_Calibrate_Acc is
      Acc_IMU : Axis3_T_Int16;
   begin
      -- We invert X and Y axis to be in the right referential
      MPU9250_Read_Acc (Acc_IMU.Y,  Acc_IMU.X,  Acc_IMU.Z);
      IMU_Add_Bias_Value (Acc_Bias, Acc_IMU);

      if Acc_Bias.Is_Buffer_Filled then
         IMU_Find_Bias_Value (Acc_Bias);
      end if;
   end IMU_Calibrate_Acc;

   procedure IMU_Add_Bias_Value
     (Bias_Obj : in out Bias_Object;
      Value    : Axis3_T_Int16) is
   begin
      Bias_Obj.Buffer (Bias_Obj.Buffer_Index) := Value;

      Bias_Obj.Buffer_Index := Bias_Obj.Buffer_Index + 1;

      if Bias_Obj.Buffer_Index > Bias_Obj.Buffer'Last then
         Bias_Obj.Is_Buffer_Filled := True;
         Bias_Obj.Buffer_Index := Bias_Obj.Buffer'First;
      end if;
   end IMU_Add_Bias_Value;

   procedure IMU_Find_Bias_Value (Bias_Obj : in out Bias_Object) is
   begin
      if Bias_Obj.Is_Buffer_Filled then
         declare
            Variance : Axis3_Float;
            Mean     : Axis3_Float;
         begin
            IMU_Calculate_Variance_And_Mean (Bias_Obj, Variance, Mean);

            if Variance.X < Bias_Obj.Variance_Base
              and Variance.Y < Bias_Obj.Variance_Base
              and Variance.Z < Bias_Obj.Variance_Base then
               Bias_Obj.Bias.X := Mean.X;
               Bias_Obj.Bias.Y := Mean.Y;
               Bias_Obj.Bias.Z := Mean.Z;
               Bias_Obj.Is_Bias_Value_Found := True;
            end if;
         end;
      end if;
   end IMU_Find_Bias_Value;

   procedure IMU_Calculate_Variance_And_Mean
     (Bias_Obj : Bias_Object;
      Variance : out Axis3_Float;
      Mean     : out Axis3_Float)
   is
      Sum : Axis3_Float := (others => 0.0);
   begin
      for Value of Bias_Obj.Buffer loop
         Sum := Sum + Value;
      end loop;

      Mean := Sum / IMU_NBR_OF_BIAS_SAMPLES;

      Sum := (others => 0.0);

      for Value of Bias_Obj.Buffer loop
         Sum := Sum + (Mean - Value) ** 2;
      end loop;

      Variance := Sum / IMU_NBR_OF_BIAS_SAMPLES;
   end IMU_Calculate_Variance_And_Mean;

   procedure IMU_Reset_Bias is
   begin
      Gyro_Bias.Buffer_Index := Bias_Buffer_Array'First;
      Gyro_Bias.Is_Bias_Value_Found := False;
      Gyro_Bias.Is_Buffer_Filled := False;
      Gyro_Bias.Variance_Base := GYRO_VARIANCE_BASE;

      Acc_Bias.Buffer_Index := Bias_Buffer_Array'First;
      Acc_Bias.Is_Bias_Value_Found := False;
      Acc_Bias.Is_Buffer_Filled := False;
      Acc_Bias.Variance_Base := ACC_VARIANCE_BASE;
   end IMU_Reset_Bias;

   --procedure IMU_Acc_IRR_LP_Filter
   --  (Input         : Axis3_T_Int16;
   --   Output        : out Axis3_T_Int32;
   --   Stored_Values : in out Axis3_T_Int32;
   --   Attenuation   : Integer_32) is
   --begin
   --   IIR_LP_Filter_Single (Integer_32 (Input.X), Attenuation, Stored_Values.X, Output.X);
   --   IIR_LP_Filter_Single (Integer_32 (Input.Y), Attenuation, Stored_Values.Y, Output.Y);
   --   IIR_LP_Filter_Single (Integer_32 (Input.Z), Attenuation, Stored_Values.Z, Output.Z);
   --end IMU_Acc_IRR_LP_Filter;

end Imu_Device;
