with Ada.Real_Time; use Ada.Real_Time;
with Ada.Unchecked_Conversion;

with Crazyflie.Device; use Crazyflie.Device;

package body MPU9250 is

   procedure MPU9250_Init
   is
      Delay_Startup : Time;
   begin
      --  Wait for MPU9250 startup
      Delay_Startup := Clock + Milliseconds (MPU9250_STARTUP_TIME_MS);
      delay until Delay_Startup;
   end MPU9250_Init;

   procedure MPU9250_Reset is
   begin
      MPU9250_Write_Bit_At_Register
        (Reg_Addr  => MPU9250_RA_PWR_MGMT_1,
         Bit_Pos   => MPU9250_PWR1_DEVICE_RESET_BIT,
         Bit_Value => True);
   end MPU9250_Reset;

   procedure MPU9250_Set_Clock_Source (Clock_Source : MPU9250_Clock_Source) is
   begin
      MPU9250_Write_Bits_At_Register
        (Reg_Addr      => MPU9250_RA_PWR_MGMT_1,
         Start_Bit_Pos => MPU9250_PWR1_CLKSEL_BIT,
         Data          => MPU9250_Clock_Source'Enum_Rep (Clock_Source),
         Length        => MPU9250_PWR1_CLKSEL_LENGTH);
   end MPU9250_Set_Clock_Source;

   procedure MPU9250_Set_DLPF_Mode (DLPF_Mode : MPU9250_DLPF_Bandwidth_Mode) is
   begin
      MPU9250_Write_Bits_At_Register
        (Reg_Addr      => MPU9250_RA_CONFIG,
         Start_Bit_Pos => MPU9250_CFG_DLPF_CFG_BIT,
         Data          => MPU9250_DLPF_Bandwidth_Mode'Enum_Rep (DLPF_Mode),
         Length        => MPU9250_CFG_DLPF_CFG_LENGTH);
   end MPU9250_Set_DLPF_Mode;

   procedure MPU9250_Set_Full_Scale_Gyro_Range (FS_Range : MPU9250_FS_Gyro_Range) is
   begin
      MPU9250_Write_Bits_At_Register
        (Reg_Addr      => MPU9250_RA_GYRO_CONFIG,
         Start_Bit_Pos => MPU9250_GCONFIG_FS_SEL_BIT,
         Data          => MPU9250_FS_Gyro_Range'Enum_Rep (FS_Range),
         Length        => MPU9250_GCONFIG_FS_SEL_LENGTH);
   end MPU9250_Set_Full_Scale_Gyro_Range;

   procedure MPU9250_Set_Full_Scale_Accel_Range (FS_Range : MPU9250_FS_Accel_Range) is
   begin
      MPU9250_Write_Bits_At_Register
        (Reg_Addr      => MPU9250_RA_ACCEL_CONFIG,
         Start_Bit_Pos => MPU9250_ACONFIG_AFS_SEL_BIT,
         Data          => MPU9250_FS_Accel_Range'Enum_Rep (FS_Range),
         Length        => MPU9250_ACONFIG_AFS_SEL_LENGTH);
   end MPU9250_Set_Full_Scale_Accel_Range;

   procedure MPU9250_Set_I2C_Bypass_Enabled (Value : Boolean) is
   begin
      MPU9250_Write_Bit_At_Register
        (Reg_Addr  => MPU9250_RA_INT_PIN_CFG,
         Bit_Pos   => MPU9250_INTCFG_I2C_BYPASS_EN_BIT,
         Bit_Value => Value);
   end MPU9250_Set_I2C_Bypass_Enabled;

   procedure MPU9250_Set_Int_Enabled (Value : Boolean) is
   begin
      --  Full register byte for all interrupts, for quick reading.
      --  Each bit should be set 0 for disabled, 1 for enabled.
      if Value then
         MPU9250_Write_Byte_At_Register
           (Reg_Addr => MPU9250_RA_INT_ENABLE,
            Data     => 16#FF#);
      else
         MPU9250_Write_Byte_At_Register
           (Reg_Addr => MPU9250_RA_INT_ENABLE,
            Data     => 16#00#);
      end if;
   end MPU9250_Set_Int_Enabled;

   procedure MPU9250_Set_Rate (Rate_Div : UInt8) is
   begin
      MPU9250_Write_Byte_At_Register
        (Reg_Addr => MPU9250_RA_SMPLRT_DIV,
         Data     => Rate_Div);
   end MPU9250_Set_Rate;

   procedure MPU9250_Set_Sleep_Enabled (Value : Boolean) is
   begin
      MPU9250_Write_Bit_At_Register
        (Reg_Addr  => MPU9250_RA_PWR_MGMT_1,
         Bit_Pos   => MPU9250_PWR1_SLEEP_BIT,
         Bit_Value => Value);
   end MPU9250_Set_Sleep_Enabled;

   procedure MPU9250_Set_Temp_Sensor_Enabled (Value : Boolean) is
   begin
      --  True value for this bit actually disables it.
      MPU9250_Write_Bit_At_Register
        (Reg_Addr  => MPU9250_RA_PWR_MGMT_1,
         Bit_Pos   => MPU9250_PWR1_TEMP_DIS_BIT,
         Bit_Value => not Value);
   end MPU9250_Set_Temp_Sensor_Enabled;

   procedure MPU9250_Read_Motion_6
     (Acc_X  : out Integer_16;
      Acc_Y  : out Integer_16;
      Acc_Z  : out Integer_16;
      Gyro_X : out Integer_16;
      Gyro_Y : out Integer_16;
      Gyro_Z : out Integer_16)
   is
      Raw_Data : I2C_Data (1 .. 14);
   begin
      MPU9250_Read_Register
        (Reg_Addr => MPU9250_RA_ACCEL_XOUT_H,
         Data     => Raw_Data);

      Acc_X := Fuse_Low_And_High_Register_Parts (Raw_Data (1), Raw_Data (2));
      Acc_Y := Fuse_Low_And_High_Register_Parts (Raw_Data (3), Raw_Data (4));
      Acc_Z := Fuse_Low_And_High_Register_Parts (Raw_Data (5), Raw_Data (6));

      Gyro_X := Fuse_Low_And_High_Register_Parts (Raw_Data (9), Raw_Data (10));
      Gyro_Y := Fuse_Low_And_High_Register_Parts (Raw_Data (11), Raw_Data (12));
      Gyro_Z := Fuse_Low_And_High_Register_Parts (Raw_Data (13), Raw_Data (14));
   end MPU9250_Read_Motion_6;

   procedure MPU9250_Read_Motion_6 is
      Raw_Data : I2C_Data (1 .. 14);
   begin
      MPU9250_Read_Register
        (Reg_Addr => MPU9250_RA_ACCEL_XOUT_H,
         Data     => Raw_Data);

      Last_Acc_X := Fuse_Low_And_High_Register_Parts (Raw_Data (1), Raw_Data (2));
      Last_Acc_Y := Fuse_Low_And_High_Register_Parts (Raw_Data (3), Raw_Data (4));
      Last_Acc_Z := Fuse_Low_And_High_Register_Parts (Raw_Data (5), Raw_Data (6));

      Last_Gyro_X := Fuse_Low_And_High_Register_Parts (Raw_Data (9), Raw_Data (10));
      Last_Gyro_Y := Fuse_Low_And_High_Register_Parts (Raw_Data (11), Raw_Data (12));
      Last_Gyro_Z := Fuse_Low_And_High_Register_Parts (Raw_Data (13), Raw_Data (14));
   end MPU9250_Read_Motion_6;

   procedure MPU9250_Read_Gyro
     (Gyro_X : out Integer_16;
      Gyro_Y : out Integer_16;
      Gyro_Z : out Integer_16)
   is
      Raw_Data : I2C_Data (1 .. 6);
   begin
      MPU9250_Read_Register
        (Reg_Addr => MPU9250_RA_GYRO_XOUT_H,
         Data     => Raw_Data);

      Gyro_X := Fuse_Low_And_High_Register_Parts (Raw_Data (1), Raw_Data (2));
      Gyro_Y := Fuse_Low_And_High_Register_Parts (Raw_Data (3), Raw_Data (4));
      Gyro_Z := Fuse_Low_And_High_Register_Parts (Raw_Data (5), Raw_Data (6));
   end MPU9250_Read_Gyro;

   procedure MPU9250_Read_Gyro is
      Raw_Data : I2C_Data (1 .. 6);
   begin
      MPU9250_Read_Register
        (Reg_Addr => MPU9250_RA_GYRO_XOUT_H,
         Data     => Raw_Data);

      Last_Gyro_X := Fuse_Low_And_High_Register_Parts (Raw_Data (1), Raw_Data (2));
      Last_Gyro_Y := Fuse_Low_And_High_Register_Parts (Raw_Data (3), Raw_Data (4));
      Last_Gyro_Z := Fuse_Low_And_High_Register_Parts (Raw_Data (5), Raw_Data (6));
   end MPU9250_Read_Gyro;

   procedure MPU9250_Read_Acc
     (Acc_X  : out Integer_16;
      Acc_Y  : out Integer_16;
      Acc_Z  : out Integer_16)
   is
      Raw_Data : I2C_Data (1 .. 6);
   begin
      MPU9250_Read_Register
        (Reg_Addr => MPU9250_RA_ACCEL_XOUT_H,
         Data     => Raw_Data);

      Acc_X := Fuse_Low_And_High_Register_Parts (Raw_Data (1), Raw_Data (2));
      Acc_Y := Fuse_Low_And_High_Register_Parts (Raw_Data (3), Raw_Data (4));
      Acc_Z := Fuse_Low_And_High_Register_Parts (Raw_Data (5), Raw_Data (6));
   end MPU9250_Read_Acc;

   procedure MPU9250_Read_Acc is
      Raw_Data : I2C_Data (1 .. 6);
   begin
      MPU9250_Read_Register
        (Reg_Addr => MPU9250_RA_ACCEL_XOUT_H,
         Data     => Raw_Data);

      Last_Acc_X := Fuse_Low_And_High_Register_Parts (Raw_Data (1), Raw_Data (2));
      Last_Acc_Y := Fuse_Low_And_High_Register_Parts (Raw_Data (3), Raw_Data (4));
      Last_Acc_Z := Fuse_Low_And_High_Register_Parts (Raw_Data (5), Raw_Data (6));
   end MPU9250_Read_Acc;

   procedure MPU9250_Get_Motion_6 (Acc_X  : out Integer_16;
                                   Acc_Y  : out Integer_16;
                                   Acc_Z  : out Integer_16;
                                   Gyro_X : out Integer_16;
                                   Gyro_Y : out Integer_16;
                                   Gyro_Z : out Integer_16) is
   begin
      Acc_X  := Last_Acc_X;
      Acc_Y  := Last_Acc_Y;
      Acc_Z  := Last_Acc_Z;
      Gyro_X := Last_Gyro_X;
      Gyro_Y := Last_Gyro_Y;
      Gyro_Z := Last_Gyro_Z;
   end MPU9250_Get_Motion_6;

   procedure MPU9250_Get_Acc (Acc_X : out Integer_16;
                              Acc_Y : out Integer_16;
                              Acc_Z : out Integer_16) is
   begin
      Acc_X := Last_Acc_X;
      Acc_Y := Last_Acc_Y;
      Acc_Z := Last_Acc_Z;
   end MPU9250_Get_Acc;

   procedure MPU9250_Get_Gyro (Gyro_X : out Integer_16;
                               Gyro_Y : out Integer_16;
                               Gyro_Z : out Integer_16) is
   begin
      Gyro_X := Last_Gyro_X;
      Gyro_Y := Last_Gyro_Y;
      Gyro_Z := Last_Gyro_Z;
   end MPU9250_Get_Gyro;

   procedure MPU9250_Read_Register
     (Reg_Addr : UInt8;
      Data     : in out I2C_Data)
   is
      Status : I2C_Status;
   begin
      Mem_Read
        (Handle        => IMU_I2C,
         Addr          => UInt10 (MPU9250_ADDRESS_AD0_HIGH) * 2,
         Mem_Addr      => UInt16 (Reg_Addr),
         Mem_Addr_Size => Memory_Size_8b,
         Data          => Data,
         Status        => Status);
   end MPU9250_Read_Register;

   procedure MPU9250_Read_Byte_At_Register
     (Reg_Addr : UInt8;
      Data     : out UInt8)
   is
      Status : I2C_Status;
      I_Data : I2C_Data (1 .. 1);
   begin
      Mem_Read
        (Handle        => IMU_I2C,
         Addr          => UInt10 (MPU9250_ADDRESS_AD0_HIGH) * 2,
         Mem_Addr      => UInt16 (Reg_Addr),
         Mem_Addr_Size => Memory_Size_8b,
         Data          => I_Data,
         Status        => Status);
      Data := I_Data (1);
   end MPU9250_Read_Byte_At_Register;

   procedure MPU9250_Write_Byte_At_Register
     (Reg_Addr : UInt8;
      Data     : UInt8)
   is
      Status : I2C_Status;
   begin
      Mem_Write
        (Handle        => IMU_I2C,
         Addr          => UInt10 (MPU9250_ADDRESS_AD0_HIGH) * 2,
         Mem_Addr      => UInt16 (Reg_Addr),
         Mem_Addr_Size => Memory_Size_8b,
         Data          => (1 => Data),
         Status        => Status);
   end MPU9250_Write_Byte_At_Register;

   procedure MPU9250_Write_Bit_At_Register
     (Reg_Addr  : UInt8;
      Bit_Pos   : T_Bit_Pos_8;
      Bit_Value : Boolean)
   is
      Register_Value : UInt8;
   begin
      MPU9250_Read_Byte_At_Register (Reg_Addr, Register_Value);

      Register_Value := (if Bit_Value then
                            Register_Value or (Shift_Left (1, Bit_Pos))
                         else
                            Register_Value and not (Shift_Left (1, Bit_Pos)));

      MPU9250_Write_Byte_At_Register (Reg_Addr, Register_Value);
   end MPU9250_Write_Bit_At_Register;

   procedure MPU9250_Write_Bits_At_Register
     (Reg_Addr      : UInt8;
      Start_Bit_Pos : T_Bit_Pos_8;
      Data          : UInt8;
      Length        : T_Bit_Pos_8)
   is
      Register_Value : UInt8;
      Mask           : UInt8;
      Data_Aux       : UInt8 := Data;
   begin
      MPU9250_Read_Byte_At_Register (Reg_Addr, Register_Value);

      Mask := Shift_Left ((Shift_Left (1, Length) - 1), Start_Bit_Pos - Length + 1);
      Data_Aux := Shift_Left (Data_Aux, Start_Bit_Pos - Length + 1);
      Data_Aux := Data_Aux and Mask;
      Register_Value := Register_Value and not Mask;
      Register_Value := Register_Value or Data_Aux;

      MPU9250_Write_Byte_At_Register (Reg_Addr, Register_Value);
   end MPU9250_Write_Bits_At_Register;

   function Fuse_Low_And_High_Register_Parts
     (High : UInt8;
      Low  : UInt8) return Integer_16
   is
      function Uint16_To_Int16 is new Ada.Unchecked_Conversion (Unsigned_16, Integer_16);

      Register : Unsigned_16;
   begin
      Register := Shift_Left (Unsigned_16 (High), 8);
      Register := Register or Unsigned_16 (Low);

      return Uint16_To_Int16 (Register);
   end Fuse_Low_And_High_Register_Parts;

end MPU9250;
