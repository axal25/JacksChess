with Gtk.Main;
with Gtk.Window;
with Gtk.Label;
with Glib;
with Gtk.Enums;
with GameTurn; use GameTurn;
with Ada.Text_IO; use Ada.Text_IO;

package body AfterGameWindow is

   procedure Main( aWinner : in GameTurn.Turn ) is
      aWindow : Gtk.Window.Gtk_Window;
      aLabel : Gtk.Label.Gtk_Label;
      aString : String := "The winner is... " & aWinner'Img;
      windowWidth : Glib.Gint := 200;
      windowHeight : Glib.Gint := 100;
   begin
      Gtk.Window.Gtk_New( Window   => aWindow,
                          The_Type => Gtk.Enums.Window_Toplevel );
      aWindow.Set_Default_Size( windowWidth, windowHeight );
      aWindow.On_Destroy( DestroyObject_And_MainQuit'Access );
      
      aLabel := Gtk.Label.Gtk_Label_New( Str => aString );
      aWindow.Add( aLabel );
      
      aWindow.Show_All;
      Gtk.Main.Main;
   end Main;
   
   procedure DestroyObject_And_MainQuit( Object: access Gtk.Widget.Gtk_Widget_Record'Class ) is
      -- close main window if Delete_Event return False (it means it's allowed to close);
   begin
      Ada.Text_IO.Put_Line( "X clicked - Destroying object" );
      Gtk.Widget.Destroy( Object );
      Gtk.Main.Main_Quit;
   end DestroyObject_And_MainQuit;

end AfterGameWindow;
