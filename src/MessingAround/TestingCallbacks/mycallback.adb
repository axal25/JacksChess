with Gtk.Window;
with Gtk.Button;
with Gtk.Box;
with Gtk.Handlers;
with Ada.Text_IO;
with Gtk.Main;
with Gtk.Enums;

package body MyCallback is

   --     type My_Data3 is record
   --        Button : Gtk_Widget;
   --        Object : Gtk_Widget;
   --        Id     : Handler_Id;
   --     end record;
   --     type My_Data3_Access is access My_Data3;
   
   --     package User_Callback3 is new Gtk.Handlers.User_Callback
   --       (Gtk_Widget_Record, My_Data3_Access);
   
   procedure Main is
      Win              : Gtk.Window.Gtk_Window;
      Button1, Button2 : Gtk.Button.Gtk_Button;
      Vbox, Hbox       : Gtk.Box.Gtk_Box;
      Id               : Gtk.Handlers.Handler_Id;
      Data3            : My_Data3_Access;
   begin
      Init_Elements( Win     => Win,
                     Vbox    => Vbox,
                     Hbox    => Hbox,
                     Button1 => Gtk.Widget.Gtk_Widget( Button1 ),
                     Button2 => Gtk.Widget.Gtk_Widget( Button2 ) );
      
      Data3 := new My_Data3' ( Object => Gtk.Widget.Gtk_Widget (Button1),
                               Button => Gtk.Widget.Gtk_Widget (Button2),
                               Id     => ( Gtk.Handlers.Null_Handler_Id, null) );
      
      
      Id := User_Callback3.Connect
        (Button1, "clicked",
         User_Callback3.To_Marshaller (My_Destroy3'Access),
         Data3);
      Data3.Id := Id;
      
      Win.On_Destroy( DestroyObject_And_MainQuit'Access );      
      
      Gtk.Window.Show_All (Win);
      Gtk.Main.Main;
   end Main;
   
   procedure Init_Elements( Win : in out Gtk.Window.Gtk_Window;
                            Vbox : in out Gtk.Box.Gtk_Vbox; 
                            Hbox : in out Gtk.Box.Gtk_Hbox;
                            Button1 : in out Gtk.Widget.Gtk_Widget; 
                            Button2 : in out Gtk.Widget.Gtk_Widget ) is
   begin
      Gtk.Main.Init;

      Gtk.Window.Gtk_New( Window   => Win,
                          The_Type => Gtk.Enums.Window_Toplevel );

      Gtk.Box.Gtk_New_Vbox( Vbox );
      Gtk.Window.Add (Win, Vbox);

      --  Using object_connect.
      --  The callback is automatically destroyed when button2 is destroyed, so
      --  you can press button1 as many times as you want, no problem
      Gtk.Box.Gtk_New_Hbox (Hbox);
      Gtk.Box.Pack_Start (Vbox, Hbox);
      Gtk.Button.Gtk_New ( Gtk.Button.Gtk_Button( Button1 ), "button1, object connect");
      Gtk.Box.Pack_Start (Hbox, Button1);
      Gtk.Button.Gtk_New (Gtk.Button.Gtk_Button( Button2 ), "button2");
      Gtk.Box.Pack_Start (Hbox, Button2);
   end Init_Elements;

   
   procedure My_Destroy3( Button : access Gtk.Widget.Gtk_Widget_Record'Class;
                          Data   : My_Data3_Access ) is
   begin
      Ada.Text_IO.Put_Line ("My_Destroy3");
      Gtk.Widget.Destroy( Data.Button );
      Gtk.Handlers.Disconnect (Data.Object, Data.Id);
   end My_Destroy3;
   
   procedure DestroyObject_And_MainQuit( Object: access Gtk.Widget.Gtk_Widget_Record'Class ) is --on event
      -- close main window if Delete_Event return False (it means it's allowed to close);
   begin
      Ada.Text_IO.Put_Line( "X clicked - Destroying object" );
      Gtk.Widget.Destroy( Object );
      Gtk.Main.Main_Quit;
   end DestroyObject_And_MainQuit;
   
end MyCallback;
