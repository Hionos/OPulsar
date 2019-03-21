with Ada.Real_Time; use Ada.Real_Time;

with Interfaces; use Interfaces;

with MPU9250; use MPU9250;

with Hal.Imu; use Hal.Imu;

--with Filter; use Filter;

package Imu_Device is

   --  IMU configuration
   IMU_ACCEL_FS_CONFIG : constant MPU9250_FS_Accel_Range := MPU9250_Accel_FS_16;
   IMU_GYRO_FS_CONFIG  : constant MPU9250_FS_Gyro_Range := MPU9250_Gyro_FS_2000;

   IMU_G_PER_LSB_CFG   : constant := MPU9250_G_PER_LSB_16;
   IMU_DEG_PER_LSB_CFG : constant := MPU9250_DEG_PER_LSB_2000;

   -- Initialize the peripherals registers
   procedure IMU_Init_Registers;

   -- Initialize the IMU device
   procedure IMU_Init_Device;

   -- Calibrate the IMU
   procedure IMU_Calibrate;

   -- Return the status of the device initialization
   function IMU_Device_Initialized return Boolean;

   -- Return the IMU status
   function IMU_Get_Status return Hal.Imu.T_Hardware_Status;

   -- Get last gyro measurements from the IMU in rad/s.
   function IMU_Get_Gyro return Hal.Imu.T_Gyro_Increments;

   -- Get Last accelerometer measurements from the IMU in m/s².
   function IMU_Get_Acc return Hal.Imu.T_Acceleration_Increments;

   -- Get last gyro and accelerometer measurements from the IMU.
   --procedure IMU_Get_Motion_6
   --  (Gyro : out Hal.Imu.T_Gyro_Increments;
   --   Acc  : out Hal.Imu.T_Acceleration_Increments);

   -- Start the gyro and accelerometer measurements from the IMU.
   procedure Start_IMU_Acquisition;

   -- Read gyro and accelerometer measurements from the IMU.
   --procedure IMU_6_Read
   --  (Gyro : out Hal.Imu.T_Gyro_Increments;
   --   Acc  : out Hal.Imu.T_Acceleration_Increments);

   -- Read gyro measurements from the IMU.
   --procedure IMU_Read_Gyro (Gyro : out Hal.Imu.T_Gyro_Increments);

   -- Read accelero measurements from the IMU.
   --procedure IMU_Read_Acc (Acc : out Hal.Imu.T_Acceleration_Increments);

private

   --IMU_UPDATE_FREQ  : constant := 100.0;

   IMU_NBR_OF_BIAS_SAMPLES  : constant := 1000;

   GYRO_VARIANCE_BASE : constant := 2_000.0;
   ACC_VARIANCE_BASE  : constant := 2_000.0;

   --  Set ACC_WANTED_LPF1_CUTOFF_HZ to the wanted cut-off freq in Hz.
   --  The highest cut-off freq that will have any affect is fs /(2*pi).
   --  E.g. fs = 350 Hz -> highest cut-off = 350/(2*pi) = 55.7 Hz -> 55 Hz
   --IMU_ACC_WANTED_LPF_CUTOFF_HZ : constant := 4.0;
   --  Attenuation should be between 1 to 256.
   --  F0 = fs / 2*pi*attenuation ->
   --  Attenuation = fs / 2*pi*f0
   --IMU_ACC_IIR_LPF_ATTENUATION  : constant Float := Float (IMU_UPDATE_FREQ) / (2.0 * Pi * IMU_ACC_WANTED_LPF_CUTOFF_HZ);
   --IMU_ACC_IIR_LPF_ATT_FACTOR   : constant Uint8 := Uint8 (Float (2 ** IIR_SHIFT) / IMU_ACC_IIR_LPF_ATTENUATION + 0.5);

   type Axis3_T_Int16 is record
      X : Integer_16 := 0;
      Y : Integer_16 := 0;
      Z : Integer_16 := 0;
   end record;

   type Axis3_T_Int32 is record
      X : Integer_32 := 0;
      Y : Integer_32 := 0;
      Z : Integer_32 := 0;
   end record;

   type Axis3_Float is record
      X : Float := 0.0;
      Y : Float := 0.0;
      Z : Float := 0.0;
   end record;

   function "+" (A1 : Axis3_Float; A2 : Axis3_Float) return Axis3_Float
   is ((X => A1.X + A2.X,
        Y => A1.Y + A2.Y,
        Z => A1.Z + A2.Z));

   function "+" (AF : Axis3_Float; AI : Axis3_T_Int16) return Axis3_Float
   is ((X => AF.X + Float (AI.X),
        Y => AF.Y + Float (AI.Y),
        Z => AF.Z + Float (AI.Z)));

   function "**" (AF : Axis3_Float; E : Integer) return Axis3_Float
   is ((X => AF.X ** E,
        Y => AF.Y ** E,
        Z => AF.Z ** E));

   function "-" (AF : Axis3_Float; AI : Axis3_T_Int16) return Axis3_Float
   is ((X => AF.X - Float (AI.X),
        Y => AF.Y - Float (AI.Y),
        Z => AF.Z - Float (AI.Z)));

   function "/" (AF : Axis3_Float; Val : Integer) return Axis3_Float
   is ((X => AF.X / Float (Val),
        Y => AF.Y / Float (Val),
        Z => AF.Z / Float (Val)));

   type Bias_Buffer_Array is array (1 .. IMU_NBR_OF_BIAS_SAMPLES) of Axis3_T_Int16;

   type Bias_Object is record
      Bias                : Axis3_Float;
      Buffer              : Bias_Buffer_Array;
      Buffer_Index        : Positive := Bias_Buffer_Array'First;
      Is_Bias_Value_Found : Boolean  := False;
      Is_Buffer_Filled    : Boolean  := False;
      Variance_Base       : Float;
   end record;

   Gyro_Bias : Bias_Object;
   Acc_Bias  : Bias_Object;

   Acc_Calibration_Scale : Float := 1.0;

   -- Use to stor the IIR LPF filter feedback
   --Acc_Stored_Values : Axis3_T_Int32;

   Status : Hal.Imu.T_Hardware_Status := Hal.Imu.Undefined;

   Is_Device_Initialized : Boolean := False;
   Is_Device_Reset       : Boolean := False;

   MPU9250_Init_Start_Time  : Time := Clock;
   MPU9250_Reset_Start_Time : Time := CLock;

   procedure Configure_GPIO;
   procedure Configure_I2C;

   -- Calibrates the gyrometer
   procedure IMU_Calibrate_Gyro;

   -- Calibrates the accelerometer
   procedure IMU_Calibrate_Acc;

   -- Add a new value to the variance buffer and if it is full
   -- replace the oldest one. Thus a circular buffer.
   procedure IMU_Add_Bias_Value (Bias_Obj : in out Bias_Object; Value : Axis3_T_Int16);

   -- Check if the variances is below the predefined thresholds.
   -- The bias value should have been added before calling this.
   procedure IMU_Find_Bias_Value (Bias_Obj : in out Bias_Object);

   -- Calculate the variance and mean for the bias buffer.
   procedure IMU_Calculate_Variance_And_Mean
     (Bias_Obj : Bias_Object;
      Variance : out Axis3_Float;
      Mean     : out Axis3_Float);

   -- Reset Gyro and Acc bias
   procedure IMU_Reset_Bias;

   -- Apply IIR LP Filter on each axis.
   --procedure IMU_Acc_IRR_LP_Filter
   --  (Input         : Axis3_T_Int16;
   --   Output        : out Axis3_T_Int32;
   --   Stored_Values : in out Axis3_T_Int32;
   --   Attenuation   : Integer_32);

end Imu_Device;
