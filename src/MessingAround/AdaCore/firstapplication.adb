-- You need to perform some initializations to start a GtkAda application::

--  predefined units of the library
with Gtk.Main;
with Gtk.Enums;
with Gtk.Window;
with Gtk.Widget;
with Gtk.Button;
with Gtk.Label;
with Ada.Calendar;
with Gtk.Handlers;
with Gtk.Frame;
with Gtk.Table;
with Glib;
with Gtk.Alignment;
with Ada.Text_IO; use Ada.Text_IO;

-- My units
-- with Callbacks;

package body FirstApplication is

   procedure  HiThere  (Object : access Gtk.Button.Gtk_Button_Record'Class) is --on event
   begin
      Put_Line ("Button clicked - Hi, there!");
   end HiThere;

   procedure DestroyObject_And_MainQuit (Object: access Gtk.Widget.Gtk_Widget_Record'Class) is --on event
      -- close main window if Delete_Event return False (it means it's allowed to close);
   begin
      Put_Line( "X clicked - Destroying object" );
      Gtk.Widget.Destroy (Object);
      Gtk.Main.Main_Quit;
   end DestroyObject_And_MainQuit;

   function Create_Button( Button_Text : String ) return Gtk.Button.Gtk_Button is
      NewButton : Gtk.Button.Gtk_Button;
   begin
      Gtk.Button.Gtk_New( NewButton , Button_Text );
      return NewButton;
   end Create_Button;

   function Create_Label( Label_Text : String ) return Gtk.Label.Gtk_Label is
      NewLabel : Gtk.Label.Gtk_Label;
   begin
      Gtk.Label.Gtk_New(Label => NewLabel,
                        Str   => Label_Text);
      return NewLabel;
   end Create_Label;

   function Create_HBox return Gtk.Box.Gtk_Hbox is
      NewHBox : Gtk.Box.Gtk_Box;
   begin
      Gtk.Box.Gtk_New_Hbox( NewHBox );
      return NewHBox;
   end Create_HBox;

   package Callback_GtkWindowRecord is new Gtk.Handlers.Callback( Gtk.Window.Gtk_Window_Record );

   task body CountDownTimeOnLabel is
      T1, T2: Ada.Calendar.Time;
      TimeLimit, CurrentTime, TimeLeft : Duration;
      innerLabel : Gtk.Label.Gtk_Label;
   begin
      accept Set_Variables( aLabel : Gtk.Label.Gtk_Label; aDuration : in Float ) do
         innerLabel := aLabel;
         TimeLimit := Duration( aDuration );
         CurrentTime := Duration(0);
      end Set_Variables;

      accept Start;
      delay(0.01);

      T1 := Ada.Calendar.Clock;
      while( CurrentTime < TimeLimit ) loop
         T2 := Ada.Calendar.Clock;
         CurrentTime := Ada.Calendar."-"(Left  => T2,
                                         Right => T1);
         TimeLeft := TimeLimit - CurrentTime;
         if( CurrentTime <= TimeLimit ) then
            Put_Line(TimeLeft'Img & " sec left...");
         end if;

         delay(0.01);
      end loop;
   end CountDownTimeOnLabel;

   procedure Application is
      task_DO_QM : Delayed_DestroyWindow_And_MainQuit;
      Main_Window : Gtk.Window.Gtk_Window;
   begin
      --  Set the locale specific datas (e.g time and date format)
      --  Gtk.Main.SetLocale;

      --  Initializes GtkAda
      Gtk.Main.Init;

      --  Create the main window
      Main_Window := Create_Window;
      Put_Line("#2 Are you waiting for me?");

      task_DO_QM.Set_Object( Main_Window );
      task_DO_QM.Close_After( delay_value => 5.0 );

      --  Signal handling loop
      Gtk.Main.Main;
   end Application;

   task body Delayed_DestroyWindow_And_MainQuit is
      inner_delay_value : Duration := Duration( 0.0 );
      inner_Window: Gtk.Window.Gtk_Window;
   begin
      accept Set_Object( aWindow: Gtk.Window.Gtk_Window ) do
         inner_Window := aWindow;
      end Set_Object;

      accept Close_After (delay_value : in Float) do
         inner_delay_value := Duration( delay_value );
      end Close_After;

      delay( inner_delay_value );
      Put_Line( inner_delay_value'Img & " sec has passed - Closing window " );
      inner_Window.Destroy;
   end Delayed_DestroyWindow_And_MainQuit;

   function Create_Window return Gtk.Window.Gtk_Window is
      Main_Window : Gtk.Window.Gtk_Window;
      ButtonNo1 : Gtk.Button.Gtk_Button;
      LabelNo1 : Gtk.Label.Gtk_Label;

      LabelTime : Gtk.Label.Gtk_Label;
      -- task_CDTOL : CountDownTimeOnLabel;

      ButtonNo2 : Gtk.Button.Gtk_Button;
      AnHBox : Gtk.Box.Gtk_Hbox;

      Frame1 : Gtk.Frame.Gtk_Frame;

      -- /** just for v4 **/ =================================================
      aFrame : Gtk.Frame.Gtk_Frame;
      aVbox : Gtk.Box.Gtk_Vbox;
      aTable : Gtk.Table.Gtk_Table;
      theCells : T_Cell_Tab_Access;
      aHeight : Integer := 10;
      aWidth : Integer := 10;
   begin
      -- just coz of annoying errors \/
      AnHBox := Gtk.Box.Gtk_Hbox_New(Homogeneous => True,
                                     Spacing     => Glib.Gint(1) ); --
      Frame1 := Gtk.Frame.Gtk_Frame_New(Label => "notALabel justAString"); --
      -- just coz of annoying errors /\
      Put_Line("Create_Window");
      Gtk.Window.Gtk_New( Window   => Main_Window,
                          The_Type => Gtk.Enums.Window_Toplevel );

      --  From Gtk.Widget:
      Gtk.Window.Set_Title ( Window => Main_Window,
                             Title  => "Main_Window" );
      Gtk.Window.Set_Default_Size( Window => Main_Window,
                                   Width  => 800,
                                   Height => 600);
      Main_Window.Set_Border_Width( 10 );

      ButtonNo1 := Create_Button( "ButtonNo1" );
      ButtonNo1.On_Clicked( HiThere'Access );

      LabelNo1 := Create_Label( "LabelNo1" );
      LabelTime := Create_Label( "LabelTime" );

      --        Main_Window := Create_Window_v1( Main_Window => Main_Window,
      --                                         ButtonNo1   => ButtonNo1,
      --                                         LabelNo1    => LabelNo1,
      --                                         LabelTime   => LabelTime);

      --  task_CDTOL.Set_Variables(aLabel => LabelTime, aDuration => 4.5);
      --  task_CDTOL.Start;

      ButtonNo2 := Create_Button( Button_Text => "ButtonNo2" );

      --        Main_Window := Create_Window_v2(Main_Window => Main_Window,
      --                                        AnHBox => AnHBox,
      --                                        ButtonNo1   => ButtonNo1,
      --                                        ButtonNo2   => ButtonNo2,
      --                                        LabelNo1    => LabelNo1,
      --                                        LabelTime   => LabelTime);

      --              Main_Window := Create_Window_v3( Main_Window => Main_Window,
      --                                               Width => 10,
      --                                               Height => 10 );

      Main_Window := Create_Window_v4( Main_Window => Main_Window,
                                       aFrame      => aFrame,
                                       aVbox       => aVbox,
                                       aTable      => aTable,
                                       theCells    => theCells,
                                       aHeight     => aHeight,
                                       aWidth      => aWidth );

      --  Construct the window and connect various callbacks
      Main_Window.On_Destroy( DestroyObject_And_MainQuit'Access );

      Gtk.Window.Show_All (Main_Window);
      Put_Line("#1 Are you waiting for me?");
      Put_Line("Create_Window - end");
      return Main_Window;
   end Create_Window;

   function Create_Window_v1( Main_Window: in out Gtk.Window.Gtk_Window; ButtonNo1: in Gtk.Button.Gtk_Button; LabelNo1, LabelTime: in Gtk.Label.Gtk_Label )
                             return Gtk.Window.Gtk_Window is
   begin
      Main_Window.add( ButtonNo1 );
      Main_Window.Remove( Widget => ButtonNo1 );
      Main_Window.Add( Widget => LabelNo1 );
      Main_Window.Remove( Widget => LabelNo1 );
      Main_Window.Add( Widget => LabelTime );
      Main_Window.Remove( Widget => LabelTime );
      return Main_Window;
   end Create_Window_v1;

   function Create_Window_v2( Main_Window: in out Gtk.Window.Gtk_Window;
                              AnHBox: in out Gtk.Box.Gtk_Hbox;
                              ButtonNo1, ButtonNo2: in Gtk.Button.Gtk_Button;
                              LabelNo1, LabelTime: in Gtk.Label.Gtk_Label )
                             return Gtk.Window.Gtk_Window is
   begin
      AnHBox := Create_HBox;  --  Gtk.Box.Gtk_New_Hbox( AnHBox );
      Gtk.Box.Add( AnHBox, ButtonNo1 );
      Gtk.Box.Add( AnHBox, LabelNo1 );
      Gtk.Box.Add( AnHBox, LabelTime );
      Gtk.Box.Add( AnHBox, ButtonNo2 );

      Main_Window.Add( AnHBox );

      return Main_Window;
   end Create_Window_v2;

   --     type T_Cell_State is (Normal, Digged, Flagged);
   --     type T_Cell_Record is new Controlled with record
   --        Alignment: Gtk.Alignment.Gtk_Alignment;
   --        Button: Gtk.Button.tk_Button;
   --        Mined: Boolean := false;
   --        Nb_Foreign_Mine : Natural := 0;
   --        State: T_Cell_State := Normal;
   --        Image: Gtk.Image.Gtk_Image;
   --        Label: Gtk.Label.Gtk_Label;
   --     end record;
   --     type T_Cell is access all T_Cell_Record;
   --     type T_Cell_Tab is array (natural range<>,natural range<>) of T_Cell;
   --     type T_Cell_Tab_Access is access all T_Cell_Tab;
   function Create_Window_v3( Main_Window: Gtk.Window.Gtk_Window;
                              Width : Integer := 5; Height : Integer := 5 )
                             return Gtk.Window.Gtk_Window is
      Frame1 : Gtk.Frame.Gtk_Frame;
      Vbox: Gtk.Box.Gtk_Vbox;
      Table: Gtk.Table.Gtk_Table;
      Cells : access T_Cell_Tab;
   begin
      -- /** INITILIZE ELEMENTS **/ ==========================================
      Put_Line("Create_Window_v3");
      Frame1 := Gtk.Frame.Gtk_Frame_New(Label => "Frame1");
      Gtk.Frame.Gtk_New( Frame1, Label => "Frame1" );
      Put_Line( "GtkNew( Frame1 )" );

      Gtk.Box.Gtk_New_Vbox(Box         => Vbox,
                           Homogeneous => True,
                           Spacing     => Glib.Gint(1) );
      --        Gtk.Box.Gtk_New_Vbox( Box         => Vbox,
      --                              Homogeneous => False,
      --                              Spacing     => Glib.Gint(0) );
      Put_Line( "GtkNew( VBox )" );

      Table := Gtk.Table.Gtk_Table_New(Rows        => Glib.Guint( Width ),
                                       Columns     => Glib.Guint( Height ),
                                       Homogeneous => True);
      -- /** INITILIZE ELEMENTS **/ ==========================================

      -- /** PACK ELEMENTS **/ ==========================================
      Vbox.Pack_Start( Child => Frame1,
                       Padding=> 0 );
      Put_Line( "Vbox.Pack_Start( Frame1 )" );

      Vbox.Pack_Start( Table );
      Put_Line( "Vbox.Pack_Start( Table )" );

      Cells := new T_Cell_Tab( 1..Height,
                               1..Width );
      Put_Line( "Cells := new T_Cell_Tab( " & Height'Img & ", "  & Width'Img & ")" );
      -- /** PACK ELEMENTS **/ ==========================================

      -- /** INITILIZE CELLS **/ ==========================================
      for row in Cells'Range(1) loop
         Put_Line("For loop (1)");
         for col in Cells'Range(2) loop
            Put_Line("For loop (2)");
            Cells(row, col) := new T_Cell_Record;
            Put_Line("Cells(row, col) := new T_Cell_Record... ");


            -- Put_Line("> 0. Cells(row, col).Alignment.Is_Created = " & Cells(row, col).Alignment.Is_Created'Img );
            Cells(row, col).Alignment := Gtk.Alignment.Gtk_Alignment_New( Xalign => 0.5,
                                                                          Yalign => 0.5,
                                                                          Xscale => 1.0,
                                                                          Yscale => 1.0 );
            Put_Line("> 1. Cells(row, col).Alignment.Is_Created = " & Cells(row, col).Alignment.Is_Created'Img );
            Gtk.Alignment.Initialize( Alignment => Cells(row, col).Alignment,
                                      Xalign    => 0.5,
                                      Yalign    => 0.5,
                                      Xscale    => 1.0,
                                      Yscale    => 1.0 );
            Put_Line("> 2. Cells(row, col).Alignment.Is_Created = " & Cells(row, col).Alignment.Is_Created'Img );

            Table.Attach( Child         => Cells(row,col).Alignment,
                          Left_Attach   => Glib.Guint(col-1),
                          Right_Attach  => Glib.Guint(col),
                          Top_Attach    => Glib.Guint(row-1),
                          Bottom_Attach => Glib.Guint(row) );
            Put_Line("Table.Attach...");
            --                           Xoptions      => ,
            --                           Yoptions      => ,
            --                           Xpadding      => ,
            --                           Ypadding      => );

            --              -- From P_Main_Window.adb
            --              Main_Window.Table.Attach(
            --                                       Main_Window.Cells(row,col).Alignment,
            --                                       Guint(col-1),
            --                                       Guint(col),
            --                                       Guint(row-1),
            --                                       Guint(row));

         end loop;
      end loop;
      Put_Line( "For loops" );
      -- /** INITILIZE CELLS **/ ==========================================

      Main_Window.Add( Vbox );
      Put_Line("Create_Window_v3 - end");

      return Main_Window;
   end Create_Window_v3;

   function Create_Window_v4( Main_Window : in out Gtk.Window.Gtk_Window;
                              aFrame : in out Gtk.Frame.Gtk_Frame;
                              aVbox : in out Gtk.Box.Gtk_Vbox;
                              aTable : in out Gtk.Table.Gtk_Table;
                              theCells : in out T_Cell_Tab_Access;
                              aHeight : in Integer := 1;
                              aWidth : in Integer := 1 )
                             return Gtk.Window.Gtk_Window is
   begin
      Put_Line("Create_Window_v4 \/");

      theCells := Initialize_Elements_v4( aFrame => aFrame,
                                          aVbox => aVbox,
                                          aTable => aTable,
                                          theCells => theCells,
                                          aHeight => aHeight,
                                          aWidth => aWidth);

      theCells := Initialize_Cells_v4( theCells => theCells, aTable => aTable );

      Main_Window := Place_elements_v4( Main_Window => Main_Window,
                                        aFrame      => aFrame,
                                        aVbox       => aVbox,
                                        aTable      => aTable,
                                        theCells    => theCells );

      Check_Initialization( Main_Window => Main_Window,
                            aFrame      => aFrame,
                            aVbox       => aVbox,
                            aTable      => aTable,
                            theCells    => theCells );



      Put_Line("Create_Window_v4 /\");

      return Main_Window;
   end Create_Window_v4;

   function Initialize_Elements_v4( aFrame : in out Gtk.Frame.Gtk_Frame;
                                    aVbox: in out Gtk.Box.Gtk_Vbox;
                                    aTable: in out Gtk.Table.Gtk_Table;
                                    theCells : in out T_Cell_Tab_Access;
                                    aHeight : in Integer := 1;
                                    aWidth : in Integer := 1 )
                                   return T_Cell_Tab_Access is
      -- TheCells : T_Cell_Tab_Access := theActuallCells'Access;
      -- TheCells : T_Cell_Tab_Access;
      -- := new T_Cell_Tab( 1..aHeight, 1..aWidth );
   begin
      aFrame := Gtk.Frame.Gtk_Frame_New( Label => "aFrame");
      Put_Line( "GtkNew( aFrame )" );

      Gtk.Box.Gtk_New_Vbox(Box         => aVbox,
                           Homogeneous => True,
                           Spacing     => Glib.Gint(1) );
      Put_Line( "GtkNew( Box => aVbox, Homogeneous => True, Spacing => Glib.Gint(1) )" );
      --        Gtk.Box.Gtk_New_Vbox( Box         => aVbox,
      --                              Homogeneous => False,
      --                              Spacing     => Glib.Gint(0) );
      --  Put_Line( "GtkNew( Box => aVbox, Homogeneous => False, Spacing => Glib.Gint(0) )" );

      aTable := Gtk.Table.Gtk_Table_New( Rows        => Glib.Guint( aWidth ),
                                         Columns     => Glib.Guint( aHeight ),
                                         Homogeneous => True );
      Put_Line("Gtk.Table.Gtk_Table_New( Rows => Glib.Guint( aWidth ), Columns     => Glib.Guint( aHeight ), Homogeneous => True );");

      TheCells := new T_Cell_Tab( 1..aHeight, 1..aWidth );
      -- theActuallCells := TheCells.all;
      Put_Line( "Cells := new T_Cell_Tab(" & aHeight'Img & ", "  & aWidth'Img & " )" );

      return theCells;
   end Initialize_Elements_v4;

   --     package UsrCb_GtkButton_TCellRecord is new Gtk.Handlers.User_Callback( Widget_Type => Gtk.Button.Gtk_Button_Record,
   --                                                                User_Type   => T_Cell_Record);
   function Initialize_Cells_v4( theCells : in out T_Cell_Tab_Access; aTable: in out Gtk.Table.Gtk_Table ) return T_Cell_Tab_Access is
   begin
      for row in theCells'Range(1) loop
         Put_Line("For loop (1)");
         for col in theCells'Range(2) loop
            Put_Line("For loop (2)");

            theCells(row, col) := new T_Cell_Record;
            Put_Line("Cells(row, col) := new T_Cell_Record... ");

            theCells(row, col).Alignment := Gtk.Alignment.Gtk_Alignment_New( Xalign => 0.5,
                                                                             Yalign => 0.5,
                                                                             Xscale => 1.0,
                                                                             Yscale => 1.0 );
            Put_Line("> 1. Cells(row, col).Alignment.Is_Created = " & theCells(row, col).Alignment.Is_Created'Img );

            Gtk.Alignment.Initialize( Alignment => theCells(row, col).Alignment,
                                      Xalign    => 0.5,
                                      Yalign    => 0.5,
                                      Xscale    => 1.0,
                                      Yscale    => 1.0 );
            Put_Line("> 2. Cells(row, col).Alignment.Is_Created = " & theCells(row, col).Alignment.Is_Created'Img );

            if( row = 1 and col = 2 ) then
               theCells(row, col).all.Mined := True;
            end if;

            theCells := Create_Visually_Cell( theCells => theCells, -- creates button
                                              RowNo    => row,
                                              ColNo    => col );

            -- BUTTON TO FUNCTION CONNECTION
            --        --                 Set_Function_On_Cell_Click( theCells => theCells,
            --        --                                             RowNo    => 1,
            --        --                                             ColNo    => 2 );
--              Put_Line(" Connect_Button_To_Function \/ ");
--              Connect_Button_To_Function( theCells => theCells,
--                                          RowNo    => 1,
--                                          ColNo    => 2 );
            Put_Line(" Connect_Button_To_Function /\ ");

            aTable.Attach( Child         => theCells(row,col).Alignment,
                           Left_Attach   => Glib.Guint(col-1),
                           Right_Attach  => Glib.Guint(col),
                           Top_Attach    => Glib.Guint(row-1),
                           Bottom_Attach => Glib.Guint(row) );
            Put_Line("Table.Attach...");
         end loop;
      end loop;
      Put_Line( "For loops" );

      return theCells;
   end Initialize_Cells_v4;

   function Place_elements_v4( Main_Window: in out Gtk.Window.Gtk_Window;
                               aFrame : in out Gtk.Frame.Gtk_Frame;
                               aVbox: in out Gtk.Box.Gtk_Vbox;
                               aTable: in out Gtk.Table.Gtk_Table;
                               theCells : in out T_Cell_Tab_Access )
                              return Gtk.Window.Gtk_Window is
   begin
      aVbox.Pack_Start( Child => aFrame,
                        Padding => 0 );
      Put_Line( "Vbox.Pack_Start( aFrame )" );

      aVbox.Pack_Start(Child   => aTable,
                       Padding => 0 );

      --        aVbox.Pack_Start(Child   => aTable,
      --                         Expand  => ,
      --                         Fill    => ,
      --                         Padding => 0 );
      Put_Line( "Vbox.Pack_Start( aTable )" );

      Main_Window.Add( aVbox );
      Put_Line( "Main_Window.Add( aVbox )" );

      return Main_Window;
   end Place_elements_v4;

   -- WindowInitError : exception; --in *.ads
   procedure Check_Initialization(  Main_Window: in out Gtk.Window.Gtk_Window;
                                    aFrame : in out Gtk.Frame.Gtk_Frame;
                                    aVbox: in out Gtk.Box.Gtk_Vbox;
                                    aTable: in out Gtk.Table.Gtk_Table;
                                    theCells : in out T_Cell_Tab_Access )
   is
      isCreated_theCells : Boolean := ( theCells /= null );
   begin
      if( aFrame.Is_Created and aVbox.Is_Created and aTable.Is_Created and isCreated_theCells and Main_Window.Is_Created ) then
         Put_Line("aFrame.Is_Created = " & aFrame.Is_Created'Img );
         Put_Line("aVbox.Is_Created = " & aVbox.Is_Created'Img );
         Put_Line("aTable.Is_Created = " & aTable.Is_Created'Img );
         Put_Line("isCreated_theCells = " & isCreated_theCells'Img );
         Put_Line("Main_Window.Is_Created = " & Main_Window.Is_Created'Img );
      else
         raise WindowInitError with "v4 - firstapplication.adb/ads";
      end if;
   end Check_Initialization;

   function Create_Visually_Cell( theCells : in out T_Cell_Tab_Access;
                                  RowNo : in Integer := 1;
                                  ColNo : in Integer := 1)
                                 return T_Cell_Tab_Access is
      --
      TCellRecord : T_Cell_Record := theCells( RowNo, ColNo ).all;
      TestFlag : Boolean := TCellRecord.Mined;
      --
   begin
      Put_Line("[" & RowNo'Img & "," & ColNo'Img & "]" & "TestFlag = " & TestFlag'Img & " TCellRecord.Mined = " & TCellRecord.Mined'Img );
      if( TestFlag ) then
         declare
            aTmpTCellRecord : T_Cell_Record := theCells( RowNo, ColNo ).all;
            aTmpButtonString : String := ( RowNo'Img & ", " & ColNo'Img & " = True" );
         begin
            Gtk.Button.Gtk_New( aTmpTCellRecord.Button, aTmpButtonString );
            aTmpTCellRecord.Alignment.Add( Widget => aTmpTCellRecord.Button );
         end;
      else
         declare
            aTmpTCellRecord : T_Cell_Record := theCells( RowNo, ColNo ).all;
            aTmpButtonString : String := ( RowNo'Img & ", " & ColNo'Img & " = False");
         begin
            Gtk.Button.Gtk_New( aTmpTCellRecord.Button, aTmpButtonString );
            aTmpTCellRecord.Alignment.Add( Widget => aTmpTCellRecord.Button );
         end;
         --T_Cell_Record
         --
         --              Gtk_New(Cell.Button);
         --              Cell.Alignment.Add(Cell.Button);
         --              --Gtk_New(Cell.Image); --initialize a null image
         --              --Cell.Button.Set_Image(Gtk_Image_New);
      end if;

      return theCells;
   end Create_Visually_Cell;

   function Delete_Visually_Cell( theCells : in out T_Cell_Tab_Access;
                                  RowNo : in Integer := 1;
                                  ColNo : in Integer := 1)
                                 return T_Cell_Tab_Access is
   begin
      declare
         aTmpTCellRecord : T_Cell_Record := theCells( RowNo, ColNo ).all;
         aTmpButtonString : String := ( RowNo'Img & ", " & ColNo'Img );
      begin
         if( aTmpTCellRecord.Button.Is_Created ) then
            aTmpTCellRecord.Alignment.Remove( Widget => aTmpTCellRecord.Button );
            aTmpTCellRecord.Button.Destroy;
         end if;
      end;

      return theCells;
   end Delete_Visually_Cell;

   function Update_Visually_Cell( theCells : in out T_Cell_Tab_Access;
                                  RowNo : in Integer := 1;
                                  ColNo : in Integer := 1)
                                 return T_Cell_Tab_Access is
   begin
      theCells := Delete_Visually_Cell( theCells => theCells,
                                        RowNo => RowNo,
                                        ColNo => ColNo );
      theCells := Create_Visually_Cell( theCells => theCells,
                                        RowNo => RowNo,
                                        ColNo => ColNo );
      return theCells;
   end Update_Visually_Cell;

   procedure Flip_Cell_Mined( theCellRecord : in out T_Cell_Record ) is
   begin
      theCellRecord.Mined := ( False = (theCellRecord.Mined) );
   end Flip_Cell_Mined;

   -- /** Template **/ ===================================
   -- package User_Callback is new Gtk.Handlers.User_Callback( Gtk.Widget.Gtk_Widget_Record, String );

   procedure My_Callback ( Widget : access Gtk.Widget.Gtk_Widget_Record'Class;
                           User_Data : String ) is
   begin
      Put_Line("My_Callback: User_Data = " & User_Data );
   end My_Callback;

   procedure Connect_Button_To_Function( theCells : in out T_Cell_Tab_Access;
                                         RowNo : in Integer := 1;
                                         ColNo : in Integer := 1 ) is
      aButton : Gtk.Button.Gtk_Button := theCells( RowNo, ColNo ).all.Button;
   begin
      User_Callback.Connect ( aButton, "Clicked", User_Callback.To_Marshaller (My_Callback'Access),
                User_Data => "any string" );
   end Connect_Button_To_Function;

   -- /** Testing **/ ===================================
   --     -- Widget_Type => Gtk.Button.Gtk_Button_Record
   --     type Type_Of_Widget_For_UsrCb is access Gtk.Widget.Gtk_Widget_Record'Class;
   --     -- User_Type   => T_Cell_Record
   --     type Type_Of_UserData_For_UsrCb is new String;
   procedure ClickTo_FlipCellMine_AndRefreshButton( anAccessOfButtonClass : Type_Of_Widget_For_UsrCb;
                                                    UserData : in out Type_Of_UserData_For_UsrCb ) is
   begin
      Put( "UserData = " & String( UserData ) );
--        Flip_Cell_Mined( theCellRecord );
--        Put_Line( " Flip_Cell_Mined " ); -- < poprawka
--        Put_Line( "theCellRecord.Mined = " & theCellRecord.Mined'Img );
   end ClickTo_FlipCellMine_AndRefreshButton;

   --     package UsrCb_GtkButton_TCellRecord is new Gtk.Handlers.User_Callback( Widget_Type => Type_Of_Widget_For_UsrCb,
   --                                                                            User_Type   => Type_Of_UserData_For_UsrCb );
   procedure Set_Function_On_Cell_Click( theCells : in out T_Cell_Tab_Access;
                                         RowNo : in Integer := 1;
                                         ColNo : in Integer := 1 ) is
      aButton : Gtk.Button.Gtk_Button := theCells(RowNo, ColNo).all.Button;
   begin
      --        UsrCb_GtkButton_TCellRecord.Connect(  aButton, "Clicked",
      --                                             UsrCb_GtkButton_TCellRecord.To_Marshaller ( ClickTo_FlipCellMine_AndRefreshButton'Access ),
      --                                              User_Data => "any string" );
      null;

      --              UsrCb_GtkButton_TCellRecord.Connect( theCells(row,col).all.Button,
      --                                                   "Clicked",
      --                                                   ClickTo_FlipCellMine_AndRefreshButton'Access,
      --                                                   theCells(row,col).all );

      --              P_Message_Ok_URHandlers.Connect( Btn,
      --                                               "clicked",
      --                                               Message_Ok_Callback'access,
      --                                               Message_Win );

      --              UsrCb_GtkButton_TCellRecord.Connect(Widget    => theCells(row,col).all.Button,
      --                                                  Name      => "Clicked",
      --                                                  Cb        => ClickTo_FlipCellMine_AndRefreshButton'Access,
      --                                                  User_Data => theCells(row,col).all );

      --                .Connect( Button, "Clicked", To_Marshaller (My_Callback'Access),
      --                                          User_Data => "any string");


      --              theCells(row, col).all.Button.On_Clicked( Call  => Flip_Cell_Mined'Access,
      --                                                        Slot => theCells(row, col).all );

      --              theCells(row, col).all.Button.On_Clicked( Call  => ( theCells := Flip_Cell_Mined( theCells => theCells,
      --                                                                                                RowNo    => row,
      --                                                                                                ColNo    => col) )'Access,

      --              theCells(row, col).all.Button.On_Clicked( Call  => ( theCells := Flip_Cell_Mined( theCells => theCells,
      --                                                                                                RowNo    => row,
      --                                                                                                ColNo    => col) )'Access,
      --                                                        After => Gtk.Button.Released );
   end Set_Function_On_Cell_Click;

end FirstApplication;
