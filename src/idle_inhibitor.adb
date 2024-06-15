with Ada.Text_IO;
with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;
with Ada.Environment_Variables;

with Wayland.Protocols.Client; use Wayland.Protocols.Client;
with Wayland.Protocols.Idle_Inhibit_Unstable_V1;
use Wayland.Protocols.Idle_Inhibit_Unstable_V1;
with Wayland.Protocols; use Wayland.Protocols;
with Wayland;           use Wayland;

with Wayland_Support;

procedure Idle_Inhibitor is
   The_Display   : Display;
   The_Registry  : Registry;
   The_Surface   : Surface;
   The_Inhibitor : Idle_Inhibitor_V1;
begin
   The_Display.Connect;

   The_Display.Get_Registry (The_Registry);
   Wayland_Support.Our_Registry_Events.Subscribe (The_Registry);

   The_Display.Roundtrip;

   if not Wayland_Support.The_Compositor.Has_Proxy then
      raise Program_Error with "No compositor attached???";
   end if;

   if not Wayland_Support.Idle_Inhibit_Manager.Has_Proxy then
      raise Program_Error
        with "No idle manager present on the current display.";
   end if;

   Wayland_Support.The_Compositor.Create_Surface (The_Surface);

   The_Display.Roundtrip;

   if not Ada.Environment_Variables.Exists ("HOME") then
      raise Program_Error with "$HOME not defined";
   end if;

   declare
      Home      : constant String := Ada.Environment_Variables.Value ("HOME");
      SF        : File_Type;
      S         : Stream_Access;
      Operation : Character;
   begin
      loop
         Open
           (File => SF,
            Mode => In_File,
            Name => Home & "/bin/eww/inhibitor_control");
         S := Stream (SF);

         Character'Read (S, Operation);
         Close (SF);

         case Operation is
            when 'Y' => --  Inhibit
               Ada.Text_IO.Put_Line ("activated");
               The_Inhibitor.Destroy; --  just in case
               Wayland_Support.Idle_Inhibit_Manager.Create_Inhibitor
                 (The_Surface, The_Inhibitor);
            when 'N' => --  Stop
               Ada.Text_IO.Put_Line ("deactivated");
               The_Inhibitor.Destroy; --  no error if unnecessary
            when others =>
               raise Program_Error
                 with "Command could not be parsed: " & Operation'Image;
         end case;
         The_Display.Roundtrip;
      end loop;
   end;
end Idle_Inhibitor;
