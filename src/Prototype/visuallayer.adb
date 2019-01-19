with Gtk.Window;
with Gtk.Box;
with Gtk.Table;
with Gtk.Button;
with Gtk.Alignment;
with Gtk.Main;
with Gtk.Enums;
with Gtk.Widget;
with Glib;
with Ada.Text_IO;

package body VisualLayer is
   
   procedure Main is
      aMainWindow : MainWindow;
   begin
      Initiate_MainWindow( aMainWindow );
      
      aMainWindow.aWindow.Show_All;
      Gtk.Main.Main;
   end Main;

   procedure Initiate_MainWindow( aMainWindow : in out MainWindow ) is
   begin
      Initiate_MainWindow( aWindow => aMainWindow.aWindow,
                           aVbox => aMainWindow.aVbox,
                           aTable => aMainWindow.aTable,
                           aButtonGrid => aMainWindow.aButtonGrid,
                           aAlignmentGrid => aMainWindow.aAlignmentGrid );
   end Initiate_MainWindow;
   
   procedure Initiate_MainWindow( aWindow : in out Gtk.Window.Gtk_Window;
                                  aVbox : in out Gtk.Box.Gtk_Vbox;
                                  aTable : in out Gtk.Table.Gtk_Table;
                                  aButtonGrid : in out ButtonGrid;
                                  aAlignmentGrid : in out AlignmentGrid ) is
   begin
      Gtk.Main.Init;

      Gtk.Window.Gtk_New( Window   => aWindow,
                          The_Type => Gtk.Enums.Window_Toplevel );

      Gtk.Box.Gtk_New_Vbox( aVbox );
      Gtk.Window.Add( aWindow, aVbox );
         
      aTable := Gtk.Table.Gtk_Table_New( Rows        => Glib.Guint( 8 ),
                                         Columns     => Glib.Guint( 8 ),
                                         Homogeneous => True );
      aVbox.Pack_Start(Child   => aTable,
                       Padding => 0 );
         
      for row in AxisY range 1..8 loop
         for col in AxisX range A..H loop
            Ada.Text_IO.Put_Line("[" & row'Img & "," & col'Img & "]");
            Gtk.Button.Gtk_New( aButtonGrid( row, col ), String("[" & row'Img & "," & col'Img & "]") );
            
            aAlignmentGrid( row, col ) := Gtk.Alignment.Gtk_Alignment_New( Xalign => 0.5,
                                                                           Yalign => 0.5,
                                                                           Xscale => 1.0,
                                                                           Yscale => 1.0 );
            
            aAlignmentGrid( row, col ).Add( Widget => aButtonGrid( row, col ) );
            
            aTable.Attach( Child         => aAlignmentGrid( row, col ),
                           Left_Attach   => Glib.Guint( AxisX_to_Integer( col )-1 ),
                           Right_Attach  => Glib.Guint( AxisX_to_Integer( col ) ),
                           Top_Attach    => Glib.Guint( row-1 ),
                           Bottom_Attach => Glib.Guint( row ) );
         end loop;
      end loop;
         
      aWindow.On_Destroy( DestroyObject_And_MainQuit'Access );

      
      
--        --  Using object_connect.
--        --  The callback is automatically destroyed when button2 is destroyed, so
--        --  you can press button1 as many times as you want, no problem
--        Gtk.Box.Gtk_New_Hbox (Hbox);
--        Gtk.Box.Pack_Start (Vbox, Hbox);
--        Gtk.Button.Gtk_New ( Gtk.Button.Gtk_Button( Button1 ), "button1, object connect");
--        Gtk.Box.Pack_Start (Hbox, Button1);
--        Gtk.Button.Gtk_New (Gtk.Button.Gtk_Button( Button2 ), "button2");
--        Gtk.Box.Pack_Start (Hbox, Button2);
   end Initiate_MainWindow;
   
   function AxisX_to_Integer( aX : AxisX ) return Integer is 
   begin
      return ModelLayer.AxisX_to_Integer( ModelLayer.AxisX( aX ) );
   end AxisX_to_Integer;
   
   procedure DestroyObject_And_MainQuit (Object: access Gtk.Widget.Gtk_Widget_Record'Class) is --on event
      -- close main window if Delete_Event return False (it means it's allowed to close);
   begin
      Ada.Text_IO.Put_Line( "X clicked - Destroying object" );
      Gtk.Widget.Destroy (Object);
      Gtk.Main.Main_Quit;
   end DestroyObject_And_MainQuit;
   
end VisualLayer;
