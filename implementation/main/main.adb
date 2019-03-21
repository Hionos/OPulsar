-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This is the main entry point of the Pulsar Flight System                  --
-------------------------------------------------------------------------------

pragma Profile (Ravenscar);
--  pragma Partition_Elaboration_Policy (Sequential);

with Ada.Real_Time;

--  The Fast_Loop package provides the tasks that will perform the work of
--  Pulsar software.
--  Since this Main package does deliberately not reference anything from
--  the Fast_Loop package, we suppress the associated warning GNAT will
--  otherwise generate.
with Pulsar.Fast_Loop; pragma Unreferenced (Pulsar.Fast_Loop);

--  The main procedure does not do anything as all the work is performed by the
--  tasks in the Fast_Loop package.
--  Thus, we delay the environment task indefinitely.

----------------------------------------------------------------------------
-- Main                                                                   --
----------------------------------------------------------------------------
procedure Main is
begin
   --  For the moment, we delay the environment task indefinitely.
   delay until Ada.Real_Time.Time_Last;
end Main;
