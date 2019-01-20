with Gtk.Window;
with Gtk.Box;
with Gtk.Table;
with Gtk.Button;
with Gtk.Alignment;
with Gtk.Widget;
with Gtk.Label;
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
   function Integer_to_AxisX( aRowNo : Integer ) return AxisX;
   procedure DestroyObject_And_MainQuit( Object: access Gtk.Widget.Gtk_Widget_Record'Class );
   
   function AxisY_For_Print( aY : in AxisY ) return AxisY;
   
   function Paint_Button( aButtonGrid : in out ButtonGrid;
                          aRowNo : in Integer;
                          aColNo : in Integer ) 
                         return Gtk.Button.Gtk_Button;
   function Paint_Button( aButtonGrid : in out ButtonGrid;
                          row : in AxisY;
                          col : in AxisX ) 
                         return Gtk.Button.Gtk_Button; 
   
   type LabelWithAlignment is record
      aLabel : Gtk.Label.Gtk_Label;
      aAlignment : Gtk.Alignment.Gtk_Alignment;
   end record;
   function GetEmptyLabel( aY : AxisY;
                           aX : AxisX; 
                           aTable : Gtk.Table.Gtk_Table ) 
                          return LabelWithAlignment;
   function GetLabel( aY : AxisY;
                      aX : AxisX; 
                      aTable : Gtk.Table.Gtk_Table ) 
                     return LabelWithAlignment;
   
   -- /** Trying **/ --
   type MainWindow_Access is access all MainWindow;
   type AllData is record
      aMainWindow_Access : MainWindow_Access;
      aChessBoard : ModelLayer.ChessBoard;
--        Id     : Gtk.Handlers.Handler_Id;
   end record;
   type AllData_Access is access AllData;
   -- /** Trying **/ --

end VisualLayer;