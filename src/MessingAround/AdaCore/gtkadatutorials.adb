with Gtk.Main;
with Gtk.Enums; use Gtk.Enums;
with Main_Windows; use Main_Windows;

package body GtkAdaTutorials is

   procedure Main is
      Win: Main_Windows.Main_Window;

   begin
      --  Initialize GtkAda.
      Gtk.Main.Init;

      Main_Windows.Gtk_New (Win);
      Win.Set_Position (Win_Pos_Center);
      Win.Set_Title("Gtk+3 Ada tutorials");
      Main_Windows.Show_All (Win);

      --  Start the Gtk+ main loop
      Gtk.Main.Main;

   end Main;

end GtkAdaTutorials;
