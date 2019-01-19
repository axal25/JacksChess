with Ada.Text_IO; use Ada.Text_IO;
with Gtk.Button; use Gtk.Button;

package body Button_Clicked is

   procedure  HiThere  (Object : access Gtk_Button_Record'Class)  is
   begin
      Put_Line ("Hi, there!");
   end HiThere;

end Button_Clicked;
