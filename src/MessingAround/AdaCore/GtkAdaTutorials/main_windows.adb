with Gtk.Main;
with Gtk; 		use Gtk;
with Gtk.Enums; 	use Gtk.Enums;
with Gtk.Box;         	use Gtk.Box;
with Gtk.Label;       	use Gtk.Label;
with Gtk.Window;      	use Gtk.Window;
with Gtk.Widget; 	use Gtk.Widget;
with Pango.Font; 	use Pango.Font;
with Gtk.Notebook; 	use Gtk.Notebook;
with Gtk.Handlers; 	use Gtk.Handlers;

package body Main_Windows is

   --instantiate generic package instance for callbacks
   package Windows_Cb is new Handlers.Callback (Gtk_Widget_Record);
   package Return_Windows_Cb is new Handlers.Return_Callback (Gtk_Widget_Record, Boolean);

   procedure Gtk_New (Win: out Main_Window) is
   begin
      Win := new Main_Window_Record;
      Main_Windows.Initialize(Win);
   end Gtk_New;


   function Delete_Event
   -- Allow closing window with close icon in the title bar
        (Object: access Gtk_Widget_Record'Class) return Boolean
   is
      pragma Unreferenced (Object);
   begin
      -- if we return True, we do not allow closing the window through the icon in the window title bar
      return False;
   end Delete_Event;

   procedure Exit_Main (Object: access Gtk_Widget_Record'Class) is
      -- close main window if Delete_Event return False (it means it's allowed to close);
   begin
      Destroy (Object);
      Gtk.Main.Main_Quit;
   end Exit_Main;


   procedure Initialize (Win: access Main_Window_Record'Class) is
      VBox: Gtk.Box.Gtk_Box;
      Label: Gtk.Label.Gtk_Label;
   begin
      Gtk.Window.Initialize(Win, Gtk.Enums.Window_Toplevel);
      Set_Default_Size (Win, 800, 600);

      Windows_Cb.Connect (Win, "destroy", Windows_Cb.To_Marshaller (Exit_Main'Access));
      Return_Windows_Cb.Connect (Win, "delete_event", Return_Windows_Cb.To_Marshaller (Delete_Event'Access));

      Gtk_New_Vbox (Vbox, Homogeneous => False, Spacing => 0);
      Add (Win, VBox);

      Gtk_New (Label, "GtkAda, the portable Ada GUI !");
      Override_Font (Label, From_String ("Helvetica Bold 22"));
      Pack_Start (Vbox, Label, Expand => False, Fill => False, Padding => 10);

      Gtk_New (Win.Notebook);
      Pack_Start (Vbox, Win.Notebook, Expand => True, Fill => True);

      Show_All (Vbox);
   end Initialize;

end Main_Windows;
