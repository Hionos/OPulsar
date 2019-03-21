-------------------------------------------------------------------------------
--                       PULSAR FLIGHT SYSTEM                                --
--                                                                           --
--           Copyright (C) 2016-2017, SOGILIS <http://sogilis.com>           --
--                                                                           --
-------------------------------------------------------------------------------
-- RESPONSIBILITIES:                                                         --
-- This is the Battery_Manager Types Package definition                       --
-------------------------------------------------------------------------------

package Pulsar.Battery_Manager.Types is

   -- Type defining battery manager component possible statuses
   type T_Battery_Manager_Status is (Initialization, Operational, Failure);   

end Pulsar.Battery_Manager.Types;