with Gtk.Window;
with Gtk.Box;
with Gtk.Table;
with Gtk.Button;
with Gtk.Alignment;
with Gtk.Widget;
with ModelLayer;

package VisualLayer is
   
   type AxisY is new ModelLayer.AxisY;
   type AxisX is new ModelLayer.AxisX;

   type ButtonGrid is array (AxisY range 1..8, AxisX range A..H) of Gtk.Button.Gtk_Button;
   type AlignmentGrid is array (AxisY range 1..8, AxisX range A..H) of Gtk.Alignment.Gtk_Alignment;
   type MainWindow is record
      aWindow : Gtk.Window.Gtk_Window;
      aVbox : Gtk.Box.Gtk_Vbox;
      aTable : Gtk.Table.Gtk_Table;
      aButtonGrid : ButtonGrid;
      aAlignmentGrid : AlignmentGrid;
   end record;
   
   procedure Main;
   procedure Initiate_MainWindow( aMainWindow : in out MainWindow );
   procedure Initiate_MainWindow( aWindow : in out Gtk.Window.Gtk_Window;
                                  aVbox : in out Gtk.Box.Gtk_Vbox;
                                  aTable : in out Gtk.Table.Gtk_Table;
                                  aButtonGrid: in out ButtonGrid;
                                  aAlignmentGrid: in out AlignmentGrid );
   function AxisX_to_Integer( aX : AxisX ) return Integer;
   procedure DestroyObject_And_MainQuit (Object: access Gtk.Widget.Gtk_Widget_Record'Class);

end VisualLayer;
