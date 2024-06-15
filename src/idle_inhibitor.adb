with Ada.Text_IO;
with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;
with Ada.Command_Line;

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
   if Ada.Command_Line.Argument_Count /= 1 then
      Ada.Text_IO.Put_Line
        ("Usage: " & Ada.Command_Line.Command_Name &
         " [path to control fifo].");
      Ada.Text_IO.Put_Line
        ("Write Y or N to the control fifo to activate and deactivate the inhibitor.");
      Ada.Text_IO.Put_Line
        ("This program will return the text " & ASCII.Quotation & "activated" &
         ASCII.Quotation & " or " & ASCII.Quotation & "deactivated" &
         ASCII.Quotation & ".");

      return;
   end if;

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

   declare
      Control_File : constant String := Ada.Command_Line.Argument (1);
      SF           : File_Type;
      S            : Stream_Access;
      Operation    : Character;
   begin
      loop
         Open (File => SF, Mode => In_File, Name => Control_File);
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
