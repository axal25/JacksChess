with Gtk.Widget;
with Gtk.Window;
with Gtk.Button;
with Gtk.Label;
with Gtk.Box;
with Gtk.Alignment;
with Gtk.Image;
with Gtk.Label;
with Gtk.Frame;
with Gtk.Table;
with Gtk.Handlers;
with Ada.Finalization;

package FirstApplication is
   
   type T_Cell_State is (Normal, Digged, Flagged);
   type T_Cell_Record is new Ada.Finalization.Controlled with record
      Alignment: Gtk.Alignment.Gtk_Alignment;
      Button: Gtk.Button.Gtk_Button;
      Mined: Boolean := false;
      Nb_Foreign_Mine : Natural := 0;
      State: T_Cell_State := Normal;
      Image: Gtk.Image.Gtk_Image;
      Label: Gtk.Label.Gtk_Label;
   end record;
   type T_Cell is access all T_Cell_Record;
   type T_Cell_Tab is array (natural range<>,natural range<>) of T_Cell;
   type T_Cell_Tab_Access is access all T_Cell_Tab;
   
   procedure Application;
   
   function Create_Window( OutterMain_Window : in out Gtk.Window.Gtk_Window;
                           theOutterCells: in out T_Cell_Tab_Access )
                             return Gtk.Window.Gtk_Window;
   
   function Create_Window_v1( Main_Window: in out Gtk.Window.Gtk_Window; ButtonNo1: in Gtk.Button.Gtk_Button; LabelNo1, LabelTime: in Gtk.Label.Gtk_Label )
                             return Gtk.Window.Gtk_Window;
   function Create_Window_v2( Main_Window: in out Gtk.Window.Gtk_Window;
                              AnHBox: in out Gtk.Box.Gtk_Hbox;
                              ButtonNo1, ButtonNo2: in Gtk.Button.Gtk_Button;
                              LabelNo1, LabelTime: in Gtk.Label.Gtk_Label )
                             return Gtk.Window.Gtk_Window;
   function Create_Window_v3( Main_Window: Gtk.Window.Gtk_Window;
                              Width : Integer := 5; Height : Integer := 5 )
                             return Gtk.Window.Gtk_Window;
   -- /** v 4 **/ =============================================================
   function Create_Window_v4( Main_Window : in out Gtk.Window.Gtk_Window;
                              aFrame : in out Gtk.Frame.Gtk_Frame;
                              aVbox : in out Gtk.Box.Gtk_Vbox;
                              aTable : in out Gtk.Table.Gtk_Table;
                              theCells : in out T_Cell_Tab_Access;
                              aHeight : in Integer := 1;
                              aWidth : in Integer := 1 )
                             return Gtk.Window.Gtk_Window;
   function Initialize_Elements_v4( aFrame : in out Gtk.Frame.Gtk_Frame;
                                    aVbox: in out Gtk.Box.Gtk_Vbox;
                                    aTable: in out Gtk.Table.Gtk_Table;
                                    theCells : in out T_Cell_Tab_Access;
                                    aHeight : in Integer := 1;
                                    aWidth : in Integer := 1 )
                                   return T_Cell_Tab_Access;
   function Initialize_Cells_v4( theCells : in out T_Cell_Tab_Access; aTable: in out Gtk.Table.Gtk_Table ) return T_Cell_Tab_Access;
   function Place_elements_v4( Main_Window: in out Gtk.Window.Gtk_Window;
                               aFrame : in out Gtk.Frame.Gtk_Frame;
                               aVbox: in out Gtk.Box.Gtk_Vbox;
                               aTable: in out Gtk.Table.Gtk_Table;
                               theCells : in out T_Cell_Tab_Access )
                              return Gtk.Window.Gtk_Window;
   WindowInitError : exception; --in *.ads
   procedure Check_Initialization(  Main_Window: in out Gtk.Window.Gtk_Window;
                                    aFrame : in out Gtk.Frame.Gtk_Frame;
                                    aVbox: in out Gtk.Box.Gtk_Vbox;
                                    aTable: in out Gtk.Table.Gtk_Table;
                                    theCells : in out T_Cell_Tab_Access );
   -- /** v 4 **/ =============================================================
   
   function Create_Visually_Cell( theCells : in out T_Cell_Tab_Access;
                                  RowNo : in Integer := 1;
                                  ColNo : in Integer := 1)
                                 return T_Cell_Tab_Access;
   function Delete_Visually_Cell( theCells : in out T_Cell_Tab_Access;
                                  RowNo : in Integer := 1;
                                  ColNo : in Integer := 1)
                                 return T_Cell_Tab_Access;
   function Update_Visually_Cell( theCells : in out T_Cell_Tab_Access;
                                  RowNo : in Integer := 1;
                                  ColNo : in Integer := 1)
                                 return T_Cell_Tab_Access;
   procedure Flip_Cell_Mined( theCellRecord : in out T_Cell_Record );
   
   -- /** Template
   package User_Callback is new Gtk.Handlers.User_Callback( Gtk.Widget.Gtk_Widget_Record, String );
   procedure My_Callback ( Widget : access Gtk.Widget.Gtk_Widget_Record'Class;
                           User_Data : String );
   procedure Connect_Button_To_Function( theCells : in out T_Cell_Tab_Access;
                                         RowNo : in Integer := 1;
                                         ColNo : in Integer := 1 );
   
   -- Widget_Type => Gtk.Button.Gtk_Button_Record
   type Type_Of_Widget_For_UsrCb is access Gtk.Widget.Gtk_Widget_Record'Class;
   -- User_Type   => T_Cell_Record
   type Type_Of_UserData_For_UsrCb is new String;
   procedure ClickTo_FlipCellMine_AndRefreshButton( anAccessOfButtonClass : Type_Of_Widget_For_UsrCb;
                                                    UserData : in out Type_Of_UserData_For_UsrCb );
   
   package UsrCb_GtkButton_TCellRecord is new Gtk.Handlers.User_Callback( Widget_Type => Gtk.Widget.Gtk_Widget_Record,
                                                                          User_Type   => Type_Of_UserData_For_UsrCb );
   procedure Set_Function_On_Cell_Click( theCells : in out T_Cell_Tab_Access;
                                         RowNo : in Integer := 1;
                                         ColNo : in Integer := 1 );
     
   procedure DestroyObject_And_MainQuit(Object: access Gtk.Widget.Gtk_Widget_Record'Class); --on event
   procedure HiThere  (Object : access Gtk.Button.Gtk_Button_Record'Class); --on event
   
   function Create_Button( Button_Text : String ) return Gtk.Button.Gtk_Button;
   function Create_Label( Label_Text : String ) return Gtk.Label.Gtk_Label;
   function Create_HBox return Gtk.Box.Gtk_Hbox;
   
   task type Delayed_DestroyWindow_And_MainQuit is
      entry Set_Object( aWindow : in Gtk.Window.Gtk_Window );
      entry Close_After( delay_value : in Float );
   end Delayed_DestroyWindow_And_MainQuit;
   
   task type CountDownTimeOnLabel is
      entry Set_Variables( aLabel : in Gtk.Label.Gtk_Label; aDuration : in Float );
      entry Start;
   end CountDownTimeOnLabel;

end FirstApplication;
