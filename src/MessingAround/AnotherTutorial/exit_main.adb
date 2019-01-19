with Gtk.Widget; use Gtk.Widget;
with Gtk.Main;

package body Exit_Main is

   procedure  DestoryAndQuit  (Object : access Gtk_Widget_Record'Class)  is
   begin
      Destroy (Object);
      Gtk.Main.Main_Quit;
   end DestoryAndQuit;

end Exit_Main;
