with Gtk.Widget;
with Gtk.Handlers;
with Gtk.Window;
with Gtk.Box;
with Gtk.Button;

package CallBack_V1 is

   type My_Data3 is record
      Button : Gtk.Widget.Gtk_Widget;
      Object : Gtk.Widget.Gtk_Widget;
      Id     : Gtk.Handlers.Handler_Id;
   end record;
   type My_Data3_Access is access My_Data3;
   
   package User_Callback3 is new Gtk.Handlers.User_Callback
     ( Gtk.Widget.Gtk_Widget_Record, My_Data3_Access );
     
   procedure Main;
   
   procedure Init_Elements( Win : in out Gtk.Window.Gtk_Window;
                            Vbox : in out Gtk.Box.Gtk_Vbox; 
                            Hbox : in out Gtk.Box.Gtk_Hbox;
                            Button1 : in out Gtk.Widget.Gtk_Widget; 
                            Button2 : in out Gtk.Widget.Gtk_Widget );
   
   procedure My_Destroy3( Button : access Gtk.Widget.Gtk_Widget_Record'Class;
                          Data   : My_Data3_Access );
   
end CallBack_V1;
