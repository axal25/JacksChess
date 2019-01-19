with Ada.Text_IO;  use Ada.Text_IO;
with GTK;
with GTK.Box;      use GTK.Box;
with GTK.Button;   use GTK.Button;
with GTK.Enums;    use GTK.Enums;
with GTK.Handlers; use GTK.Handlers;
with GTK.Main;
with GTK.Window;   use GTK.Window;

package body GtkAdaTest2 is 
   
   procedure OnDestruction (aWindow : access GTK_Window_Record'Class)
   is
      pragma Warnings (Off, aWindow);
   begin
      Gtk.Main.Main_Quit;
      Put_Line("[>DESTROY RECEIVED<]");
   end OnDestruction;
   
   procedure OnClick_LeftButton( aWindow : access GTK_Window_Record'Class ) is
      pragma Warnings (Off, aWindow);
   begin
      Put_Line("[>LEFT BUTTON CLICK<]");
   end OnClick_LeftButton;
   
   procedure OnClick_RightButton( aWindow : access GTK_Window_Record'Class ) is
      pragma Warnings (Off, aWindow);
   begin
      Put_Line("[>RIGHT BUTTON CLICK<]");
   end OnClick_RightButton;
   
   package Callback_GtkWindowRecord is new Gtk.Handlers.Callback( GTK_Window_Record );
   
   procedure Test1 is
      aWindow       : Gtk.Window.Gtk_Window;
      anHBox         : Gtk.Box.Gtk_Box;
      aLeft_Button, aRight_Button : Gtk.Button.Gtk_Button;
   begin
      Gtk.Main.Init;
      Gtk.Window.Gtk_New( aWindow, Gtk.Enums.Window_Toplevel );
      Gtk.Button.Gtk_New( aLeft_Button, "Left" );
      Gtk.Button.Gtk_New( aRight_Button, "Right" );
      Gtk.Box.Gtk_New_Hbox( anHBox );
      Gtk.Window.Set_Title( aWindow, "WinTitle - Button Example" );
      aWindow.Set_Border_Width( 10 );
      Gtk.Window.Resize( aWindow, 400, 200 );
      Gtk.Box.Add( anHBox, aLeft_Button );
      Gtk.Box.Add( anHBox, aRight_Button );
      aWindow.Add( anHBox );
      Put_Line("Setting up...");
      Callback_GtkWindowRecord.Connect(   aWindow, "destroy", Callback_GtkWindowRecord.To_Marshaller( OnDestruction'Access )   );
      Put_Line("Callback_GtkWindowRecord.Connect... OnDestruction...");
      
      Callback_GtkWindowRecord.Object_Connect( 
                              aLeft_Button,
                              "clicked",
                              Callback_GtkWindowRecord.To_Marshaller( OnClick_LeftButton'Access ),
                              aWindow 
                             );
      Put_Line("Callback_GtkWindowRecord.Connect... OnClick_LeftButton...");
      
      Callback_GtkWindowRecord.Object_Connect( 
                              aRight_Button,
                              "clicked",
                              Callback_GtkWindowRecord.To_Marshaller( OnClick_RightButton'Access ),
                              aWindow 
                             );
      Put_Line("Callback_GtkWindowRecord.Connect... OnClick_RightButton...");
      
      Show_All (aWindow);
      Gtk.Main.Main;
      Put_Line("Gtk.Main.Main...");
   end Test1;
   
   package Handler is new Callback (GTK_Window_Record);
   procedure On_Destroy (Window : access GTK_Window_Record'Class)
   is
      pragma Warnings (Off, Window);
   begin
      GTK.Main.Main_Quit;
      Put_Line("[DESTROY RECEIVED]");
   end On_Destroy;

   procedure On_Left_Click (Window : access GTK_Window_Record'Class)
   is
      pragma Warnings (Off, Window);
   begin
      Put_Line("[LEFT BUTTON CLICK]");
   end On_Left_Click;

   procedure On_Right_Click (Window : access GTK_Window_Record'Class)
   is
      pragma Warnings (Off, Window);
   begin
      Put_Line("[RIGHT BUTTON CLICK]");
   end On_Right_Click;
   
   procedure Button is
      Window       : Gtk_Window;
      HBox         : Gtk_Box;
      Left_Button  : Gtk_Button;
      Right_Button : Gtk_Button;
   begin
      GTK.Main.Init;
      GTK_New (Window, Window_TopLevel);
      GTK_New (Left_Button, "Left");
      GTK_New (Right_Button, "Right");
      GTK_New_HBox (HBox);
      Set_Title (Window, "Button Example");
      Set_Border_Width (Window, 10);
      ReSize (Window, 400, 200);
      Add (HBox, Left_Button);
      Add (HBox, Right_Button);
      Add (Window, HBox);
      
      Handler.Connect (Window, "destroy", Handler.To_Marshaller (On_Destroy'Access));
      Handler.Object_Connect
        (Left_Button,
         "clicked",
         Handler.To_Marshaller (On_Left_Click'Access),
         Window);
      
      Handler.Object_Connect
        (Right_Button,
         "clicked",
         Handler.To_Marshaller (On_Right_Click'Access),
         Window);
      
      Show_All (Window);
      
      GTK.Main.Main;
   end Button;
      
end GtkAdaTest2;
