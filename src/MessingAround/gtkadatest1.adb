with Gtk.Box;         use Gtk.Box;
with Gtk.Label;       use Gtk.Label;
with Gtk.Widget;      use Gtk.Widget;
with Gtk.Main;
with Gtk.Window;      use Gtk.Window;
with Glib;
with Ada.Text_IO;     use Ada.Text_IO;
with Ada.Calendar;
--Test4
with Gtk;
with Gtk.Enums;       use Gtk.Enums;
with Gtk.Handlers;    use Gtk.Handlers;

package body GtkAdaTest1 is

   procedure Test1 is
      Win   	: Gtk_Window;
      Label 	: Gtk_Label;
      Box   	: Gtk_Vbox;
   begin
      --  Initialize GtkAda.
      Gtk.Main.Init;
 
      --  Create a window with a size of 400x400
      Gtk_New (Win);
      Win.Set_Default_Size (400, 400);
 
      --  Create a box to organize vertically the contents of the window
      Gtk_New_Vbox (Box);
      Win.Add (Box);
 
      --  Add a label
      Gtk_New (Label, "Hello from Ada and Gtk !");
      Box.Add (Label);
 
      --  Show the window
      Win.Show_All;
      --  Start the Gtk+ main loop
      delay( 2.5 );
      Gtk.Main.Main;
   end Test1;
   
   procedure Test2 is
      aWindow : Gtk.Window.Gtk_Window;
      --        aLabel : Gtk.Label.Gtk_Label;
      --        aBox : Gtk.Box.Gtk_Vbox;
      windowHeight : Glib.Gint := 600;
      windowWidth : Glib.Gint := 800;
      aDelay : Duration := Duration(2.5);
      aTime1, aTime2 : Ada.Calendar.Time;
      aDuration : Duration;
   begin
      aTime1 := Ada.Calendar.Clock;
      
      Gtk.Main.Init;
      Gtk.Window.Gtk_New( aWindow );
      aWindow.Set_Default_Size( windowWidth, windowHeight );
      Put_Line("Before ShowAll");
      delay( aDelay );
      
      aWindow.Show_All;
      Put_Line("before 1st delay...");
      delay( aDelay );
      Put_Line("after 1st delay...");
      
      aTime2 := Ada.Calendar.Clock;
      aDuration := Ada.Calendar."-"(aTime2, aTime1);
      Put_Line(aDuration'Img & " has passed since start of Test2");
      
      
      aWindow.Resize( 100, 100 );
      delay( aDelay );
      Put_Line("after 2nd delay...");
      
      aTime2 := Ada.Calendar.Clock;
      aDuration := Ada.Calendar."-"(aTime2, aTime1);
      Put_Line(aDuration'Img & " has passed since start of Test2");
      
      
      aWindow.Show_All;
      delay( aDelay );
      Put_Line("after 3rd delay...");
      
      aTime2 := Ada.Calendar.Clock;
      aDuration := Ada.Calendar."-"(aTime2, aTime1);
      Put_Line(aDuration'Img & " has passed since start of Test2");
      
      
      aWindow.Set_Default_Size( 100, 100 );
      delay( aDelay );
      Put_Line("after 4th delay...");
      
      aTime2 := Ada.Calendar.Clock;
      aDuration := Ada.Calendar."-"(aTime2, aTime1);
      Put_Line(aDuration'Img & " has passed since start of Test2");
      
      
      aWindow.Show_All;
      delay( aDelay );
      Put_Line("after 5th delay...");
      
      aTime2 := Ada.Calendar.Clock;
      aDuration := Ada.Calendar."-"(aTime2, aTime1);
      Put_Line(aDuration'Img & " has passed since start of Test2");
      
      Gtk.Window.Set_Auto_Startup_Notification( True );
      aWindow.Notify("default-height");
      aWindow.Notify("default-width");
      aWindow.Show_All;
      delay( aDelay );
      Put_Line("after 6th delay...");
      
      aWindow.Close;
      delay( aDelay );
      Put_Line("after 7th delay...");
      
      aWindow.Maximize; -- works
      delay( aDelay );
      Put_Line("after 8th delay...");
      
      Gtk.Window.Gtk_New( aWindow );
      aWindow.Set_Default_Size( 100, 100 );
      aWindow.Set_Title("Main window #2");
      aWindow.Show_All;
      
      delay( aDelay );
      Put_Line("after 9th delay...");
      
      aTime2 := Ada.Calendar.Clock;
      aDuration := Ada.Calendar."-"(aTime2, aTime1);
      Put_Line(aDuration'Img & " has passed since start of Test2");
   end Test2;
   
   task body Test3Task is
      aWindow : Gtk.Window.Gtk_Window;
      aLabel : Gtk.Label.Gtk_Label;
      aBox : Gtk.Box.Gtk_Vbox;
      windowHeight : Glib.Gint := 600;
      windowWidth : Glib.Gint := 800;
      aDelay : Duration := Duration(2.5);
      
      aTest3TaskQuit : Test3TaskQuit;
   begin
      accept Start;
      Put_Line("Test3Task - Start");
      
      if( Gtk.Main.Init_Check ) then
         null; -- do_nothing
      else
         Gtk.Main.Init;
      end if;
      
      if( Gtk.Main.Events_Pending ) then
         Put_Line("Gtk.Main.Events_Pending == True");
      else
         Put_Line("Gtk.Main.Events_Pending == False");
      end if;
            
      Gtk.Window.Gtk_New( aWindow );
      aWindow.Set_Default_Size( windowWidth, windowHeight );
      
      Gtk.Box.Gtk_New_Vbox( aBox );
      aWindow.add( aBox );
      
      Gtk.Label.Gtk_New( aLabel, "1st Label");
      aBox.add( aLabel );
      
      aWindow.Remove( aBox );
      Gtk.Label.Gtk_New( aLabel, "2nd Label");
      aWindow.add( aLabel );
      
      Put_Line("before 1st delay...");
      
      aWindow.Show_All;
      delay( aDelay );
      Put_Line("after 1st delay...");
      
      aWindow.Maximize;
      delay( aDelay );
      Put_Line("after 2nd delay...");
      
      if( aWindow.Is_Maximized ) then
         aWindow.Unmaximize;
         delay( aDelay );
         Put_Line("after optional delay...");
         Put_Line("aWindow.Is_Maximized == True -> aWindow.Unmaximize");
      else 
         Put_Line("aWindow.Is_Maximized == False -> Do_nothing [Should be True but is NOT]");
      end if;
      
      aWindow.Unmaximize;
      delay( aDelay );
      
      aWindow.Resize( 100, 100 );
      delay( aDelay );
      
      if( aWindow.Resize_Grip_Is_Visible ) then
         Put_Line("aWindow.Resize_Grip_Is_Visible == True");
      else
         Put_Line("aWindow.Resize_Grip_Is_Visible == False");
      end if;
      
      aTest3TaskQuit.Start;
      Gtk.Main.Main;
   end Test3Task;
   
   task body Test3TaskQuit is
   begin
      accept Start;
      Put_Line("Test3Task - End in 2.5 sec...");
      delay( 2.5 );
      Gtk.Main.Main_Quit;
      Put_Line("Test3Task - End");
   end Test3TaskQuit;
         
   procedure Test3 is      
      aTest3Task : Test3Task;
      
      aTime1, aTime2 : Ada.Calendar.Time;
      aDuration : Duration;
   begin
      Put_Line("Test3 - Start");
      
      aTime1 := Ada.Calendar.Clock;
      aTest3Task.Start;
      
      aTime2 := Ada.Calendar.Clock;
      aDuration := Ada.Calendar."-"(aTime2, aTime1);
      Put_Line(aDuration'Img & " has passed since start of Test2");
      
      Put_Line("Test3 - End");
   end Test3;
   
   package HandlerGTK_Window_Record is new Callback (GTK_Window_Record);
   
   procedure On_Destraction (Window : access GTK_Window_Record'Class)
   is
      pragma Warnings (Off, Window);
   begin
      GTK.Main.Main_Quit;
      Put_Line("[DESTROY RECEIVED]");
   end On_Destraction;
   
   procedure Test4_Window is
      Window : Gtk_Window;
   begin
      GTK.Main.Init;
      GTK_New (Window, Window_TopLevel);
      Set_Title (Window, "Window Example");
      Set_Border_Width (Window, 10);
      ReSize (Window, 500, 400);
      HandlerGTK_Window_Record.Connect (Window, "destroy", HandlerGTK_Window_Record.To_Marshaller (On_Destraction'Access));
      Show_All (Window);
      GTK.Main.Main;
   end Test4_Window;
   
   -- GtkMainInitError : exception; --in *.ads
   procedure Test4 is
   begin
      Gtk.Main.Init;
      
      if( Gtk.Main.Init_Check ) then
         null;
      else 
         Gtk.Main.Init;
      end if;
      
      if( Gtk.Main.Init_Check ) then
         Test4_Proper;
      else
         raise GtkMainInitError with "Test4 - Gtk.Main.Init_Check";
      end if;
   end Test4;
   
   package CallBack_GtkWindowRecord is new Callback (GTK_Window_Record);
   
   procedure Test4_Proper is
      aWindow : Gtk.Window.Gtk_Window;
      aLabel : Gtk.Label.Gtk_Label;
      isMainLoopNOTRunning : Boolean := True;
      outWidth, outHeight : Glib.Gint;
      
      aRunGtkMainMain : StartGtkMainMain;
   begin
      Gtk.Window.Gtk_New( aWindow, Gtk.Enums.Window_Toplevel );
      aWindow.Set_Title( "Main Window (Window_Toplevel)" );
      aWindow.Set_Border_Width( 50 );
      aWindow.Set_Default_Size( 270, 270 );
      
      -- Gtk.Window.Set_Policy( aWindow, Allow_Shrink => True, Allow_Grow => True, Auto_Shrink => True );
      aWindow.Set_Size_Request( 10, 10 );
      aWindow.Set_Resizable( True );
      
      Gtk.Window.Resize( aWindow, 225, 225 ); --label? min. 225
      
      CallBack_GtkWindowRecord.Connect(   aWindow, "destroy", CallBack_GtkWindowRecord.To_Marshaller( DestructionHandler'Access )   );
      aWindow.Show_All;
      -- isMainLoopNOTRunning := Gtk.Main.Main_Iteration;
      isMainLoopNOTRunning := Gtk.Main.Main_Iteration_Do( False );
      Put_Line("#1 isMainLoopNOTRunning = " & isMainLoopNOTRunning'Img );   
      
      aWindow.Get_Size(outWidth, outHeight);
      Gtk.Label.Gtk_New( aLabel );
      Gtk.Label.Set_Max_Width_Chars( aLabel, 5 );
      Gtk.Label.Set_Line_Wrap( aLabel, True );
      Gtk.Label.Set_Size_Request(Widget => aLabel,
                                  Width  => 100,
                                  Height => 100);
      --Gtk.Label.Set_Halign( Gtk.Align.CENTER ); --?
      Gtk.Label.Set_Text( aLabel, "Window size =" & outWidth'Img & "," & outHeight'Img );
      
      aWindow.Add( aLabel );
      aWindow.Show_All;
      
      aRunGtkMainMain.SaveWindow( aWindow );
      aRunGtkMainMain.Start;
      
      delay(0.25);
      isMainLoopNOTRunning := Gtk.Main.Main_Iteration_Do( False );
      Put_Line("#2 isMainLoopNOTRunning = " & isMainLoopNOTRunning'Img );
      
      --        delay(0.25);
      --        aWindow.Resize( 150, 150 );
      --        Gtk.Window.Resize( aWindow, 150, 150 );
      Put_Line("Did resize");
      delay(0.25);
      isMainLoopNOTRunning := Gtk.Main.Main_Iteration_Do( False );
      Put_Line("#3 isMainLoopNOTRunning = " & isMainLoopNOTRunning'Img );
      
      delay(0.5);
      aWindow.Get_Size(outWidth, outHeight);
      aWindow.Remove( aLabel );
      outWidth := 1;
      outHeight := 1;
      Gtk.Label.Gtk_New( aLabel, "Window size =" & outWidth'Img & "," & outHeight'Img );
      Gtk.Label.Set_Size_Request(Widget => aLabel,
                                  Width  => 100,
                                 Height => 100);
      Gtk.Label.Set_Max_Width_Chars( aLabel, 50 );
      Gtk.Label.Set_Line_Wrap( aLabel, True );
      --Gtk.Label.Set_Halign( Gtk.Align.CENTER ); --?
      aWindow.Add( aLabel );
      aWindow.Show_All;
      Put_Line("new aLabel");
      delay(0.25);
      isMainLoopNOTRunning := Gtk.Main.Main_Iteration_Do( False );
      Put_Line("#4 isMainLoopNOTRunning = " & isMainLoopNOTRunning'Img );
      
      delay(0.5);
      -- Put_Line("Gtk.Main.Main_Quit called #1"); 
      -- Gtk.Main.Main_Quit; -- Nie może byc tu
      -- Put_Line("Gtk.Main.Main_Quit called #2"); 
      -- aRunGtkMainMain.Start;
   end Test4_Proper;
   
   task body StartGtkMainMain is
      aStopGtkMainMain : StopGtkMainMain;
      aResizeGtk : ResizeGtk;
      aWindow : Gtk.Window.Gtk_Window;
   begin
      accept SaveWindow( aInWindow : in Gtk.Window.Gtk_Window ) do
         aWindow := aInWindow;
         Put_Line( "StartGtkMainMain.SaveWindow - saved");
         aResizeGtk.SaveWindow( aInWindow );
      end SaveWindow;
      
      accept Start;
      aResizeGtk.Resize;
      Put_Line("Should be calling Gtk.Main.Main_Quit in 5 sec"); 
      aStopGtkMainMain.Start;
      
      Put_Line("Start - Gtk.Main.Main_Level #1 = " & Gtk.Main.Main_Level'Img );
      Put_Line("Gtk.Main.Main called #1");
      Gtk.Main.Main;
      Put_Line("Gtk.Main.Main called #2");
      Put_Line("Start - Gtk.Main.Main_Level #2 = " & Gtk.Main.Main_Level'Img );
   end StartGtkMainMain;
   
   task body StopGtkMainMain is      
   begin
      accept Start;
      Put_Line("Will be calling Gtk.Main.Main_Quit in 5 sec"); 
      delay(5.0);
      Put_Line("Stop - Gtk.Main.Main_Level #1 = " & Gtk.Main.Main_Level'Img );
      Put_Line("Gtk.Main.Main_Quit called #1");
      Gtk.Main.Main_Quit;
      Put_Line("Gtk.Main.Main_Quit called #2");  
      Put_Line("Stop - Gtk.Main.Main_Level #2 = " & Gtk.Main.Main_Level'Img );
   end StopGtkMainMain;
   
   task body ResizeGtk is
      aWindow : Gtk.Window.Gtk_Window;
      newWidth : Glib.Gint := 150;
      newHeight : Glib.Gint := 150;
   begin      
      accept SaveWindow( aInWindow : in Gtk.Window.Gtk_Window ) do
         aWindow := aInWindow;
         Put_Line( "StopGtkMainMain.SaveWindow - saved");
      end SaveWindow;
      
      accept Resize;
      Put_Line("StopGtkMainMain.Resize - resize started...");      
      if( aWindow = null ) then
         Gtk.Window.Gtk_New( aWindow );
      end if;
      delay(1.5);
      --        aWindow.Resize( 150, 150 );
      --        Gtk.Window.Resize( aWindow, newWidth, newHeight );
      --        Gtk.Window.Resize( aWindow, 300, 300 );
      Put_Line("StopGtkMainMain.Resize - Did resize");
   end ResizeGtk;
   
   procedure DestructionHandler(aWindow : access Gtk.Window.Gtk_Window_Record'Class) is
      pragma Warnings (Off, aWindow);
   begin
      GTK.Main.Main_Quit;
      Put_Line("Gtk.Main.Main_Quit called");  
   end DestructionHandler;
         
end GtkAdaTest1;
