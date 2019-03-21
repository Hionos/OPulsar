-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This is the Notification_Manager Types Package definition                       --
-------------------------------------------------------------------------------

package Pulsar.Notification_Manager.Types is

   -- Type defining all the possible notification statuses
   type T_Notification_Status is (Initialization, Stand_By, Running, Fault);

end Pulsar.Notification_Manager.Types;