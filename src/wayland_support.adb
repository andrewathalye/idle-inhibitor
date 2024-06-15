with Wayland.Protocols.Client; use Wayland.Protocols;
with Wayland.Protocols.Idle_Inhibit_Unstable_V1;
use Wayland.Protocols.Client;

with Wayland; use Wayland;

package body Wayland_Support is

   -------------------------
   -- Global_Object_Added --
   -------------------------

   procedure Global_Object_Added
     (Registry : in out Client.Registry'Class;
      Id       :        Unsigned_32;
      Name     :        String;
      Version  :        Unsigned_32)
   is
   begin
      if Name = "wl_compositor" then
         The_Compositor.Bind (Registry, Id, Version);
      elsif Name = "zwp_idle_inhibit_manager_v1" then
         Idle_Inhibit_Manager.Bind (Registry, Id, Version);
      end if;
   end Global_Object_Added;
end Wayland_Support;
