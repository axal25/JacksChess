with Gtk.Window;

package GtkAdaTest1 is

   procedure Test1;
   procedure Test2;
   procedure Test3;

   task type Test3Task is
     entry Start;
   end Test3Task;

   task type Test3TaskQuit is
      entry Start;
   end Test3TaskQuit;

   procedure Test4_Window;

   GtkMainInitError : exception;
   procedure Test4;
   procedure Test4_Proper;
   procedure DestructionHandler(aWindow : access Gtk.Window.Gtk_Window_Record'Class);

   task type StartGtkMainMain is
      entry SaveWindow( aInWindow : in Gtk.Window.Gtk_Window );
      entry Start;
   end StartGtkMainMain;

   task type StopGtkMainMain is
      entry Start;
   end StopGtkMainMain;

   task type ResizeGtk is
      entry SaveWindow( aInWindow : in Gtk.Window.Gtk_Window );
      entry Resize;
   end ResizeGtk;

end GtkAdaTest1;
