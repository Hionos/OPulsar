-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This is the State_Machine Types Package definition                        --
-------------------------------------------------------------------------------

package Pulsar.State_Machine.Types is

  -- Type defining all the possible states supported by this state machine
  type T_State_Machine_State is (Init, Stand_By, Manual, Fault);

end Pulsar.State_Machine.Types;
