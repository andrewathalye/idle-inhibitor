with Wayland.Protocols.Client; use Wayland.Protocols.Client;
with Wayland.Protocols.Idle_Inhibit_Unstable_V1;
use Wayland.Protocols.Idle_Inhibit_Unstable_V1;
with Wayland.Protocols; use Wayland.Protocols;
with Wayland;           use Wayland;

package Wayland_Support is

   procedure Global_Object_Added
     (Registry : in out Client.Registry'Class;
      Id       :        Unsigned_32;
      Name     :        String;
      Version  :        Unsigned_32);
   --  Register local IDs for the global zwp_idle_inhibit_manager_v1 and wl_compositor objects
   --  if they are found

   package Our_Registry_Events is new Registry_Events
     (Global_Object_Added => Global_Object_Added);

   --  Local Objects (inherited from global objects)
   Idle_Inhibit_Manager : Idle_Inhibit_Manager_V1;
   The_Compositor       : Compositor;

end Wayland_Support;
