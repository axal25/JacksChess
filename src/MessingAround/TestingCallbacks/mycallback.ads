with Gtk.Widget;
with Gtk.Handlers;
with Gtk.Window;
with Gtk.Box;
with Gtk.Button;
with Gtk.Table;
with Gtk.Alignment;

package MyCallback is
   
   type My_Data3 is record
      Button : Gtk.Widget.Gtk_Widget;
      Object : Gtk.Widget.Gtk_Widget;
      Id     : Gtk.Handlers.Handler_Id;
   end record;
   type My_Data3_Access is access My_Data3;
   procedure My_Destroy3( Button : access Gtk.Widget.Gtk_Widget_Record'Class;
                          Data   : My_Data3_Access );
   package User_Callback3 is new Gtk.Handlers.User_Callback
     ( Gtk.Widget.Gtk_Widget_Record, My_Data3_Access );
     
   procedure Main;
   
   procedure Init_Elements( Win : in out Gtk.Window.Gtk_Window;
                            Vbox : in out Gtk.Box.Gtk_Vbox; 
                            Hbox : in out Gtk.Box.Gtk_Hbox;
                            Button1 : in out Gtk.Widget.Gtk_Widget; 
                            Button2 : in out Gtk.Widget.Gtk_Widget );
   

   
   procedure DestroyObject_And_MainQuit( Object: access Gtk.Widget.Gtk_Widget_Record'Class );

end MyCallback;
