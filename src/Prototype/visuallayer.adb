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
with Gtk.Bin;
with Gtk.Image;
with Gtk.Container;
with ModelLayer; use ModelLayer;

      
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;

package body VisualLayer is
   --     type MainWindow_Access is access all VisualLayer.MainWindow;
   --     type ChessBoard_Access is access all ModelLayer.ChessBoard;
   --     type AllData is record
   --        aMainWindow_Access : MainWindow_Access;
   --        aChessBoard_Access : ChessBoard_Access;
   --     end record;
   
   function Main return AllData is
      aAllData : AllData;
   begin
      aAllData.aChessBoard := ModelLayer.Main;
      
      Initiate_MainWindow( aAllData.aMainWindow );
      Initiate_ChessBoard( aAllData.aMainWindow, aAllData.aChessBoard );
      
      return aAllData;
   end Main;

   procedure Initiate_MainWindow( aMainWindow : in out MainWindow ) is
   begin
      Initiate_MainWindow( aWindow => aMainWindow.aWindow,
                           aVbox => aMainWindow.aVbox,
                           aTable => aMainWindow.aTable,
                           aButtonGrid => aMainWindow.aButtonGrid,
                           aAlignmentGrid => aMainWindow.aAlignmentGrid );
   end Initiate_MainWindow;
   
   procedure Initiate_ChessBoard( aMainWindow : in out MainWindow; aChessBoard : in out ModelLayer.ChessBoard ) is
   begin
      for row in aChessBoard.aGrid'Range(1) loop
         for col in aChessBoard.aGrid'Range(2) loop
            Update_Button( row, col, aMainWindow, aChessBoard );
         end loop;
      end loop;
   end Initiate_ChessBoard;
   
   procedure Update_Button( aRowNo : in ModelLayer.AxisY; aColNo : in ModelLayer.AxisX; 
                            aMainWindow : in out MainWindow; aChessBoard : in out ModelLayer.ChessBoard ) is
      row : AxisY := AxisY( aRowNo );
      col : AxisX := AxisX( aColNo );
      aChild : Gtk.Widget.Gtk_Widget := Gtk.Bin.Gtk_Bin( aMainWindow.aButtonGrid( row, col ) ).Get_Child;
      aImage : Gtk.Image.Gtk_Image;
      
      aFilePath : Ada.Strings.Unbounded.Unbounded_String := Ada.Strings.Unbounded.To_Unbounded_String("images/");
   begin
      Gtk.Bin.Gtk_Bin( aMainWindow.aButtonGrid( row, col ) ).Remove( aChild );
      
      if( ModelLayer.isWhite( aChessBoard.aGrid( aRowNo, aColNo ).aColor ) ) then
         aFilePath := aFilePath & "w_square";
      else
         aFilePath := aFilePath & "b_square";
      end if;
      if( aChessBoard.aGrid( aRowNo, aColNo ).isTaken = True ) then
         if( ModelLayer.isWhite( aChessBoard.aGrid( aRowNo, aColNo ).aAccessFigure.all.aColor ) ) then
            aFilePath := aFilePath & "_w";
         else
            aFilePath := aFilePath & "_b";
         end if;
      
         case ModelLayer.FigureType'( aChessBoard.aGrid( aRowNo, aColNo ).aAccessFigure.all.aType ) is
            when ModelLayer.FigureType'( ModelLayer.Pawn ) => aFilePath := aFilePath & "_pawn";
            when ModelLayer.FigureType'( ModelLayer.Knight ) => aFilePath := aFilePath & "_knight";
            when ModelLayer.FigureType'( ModelLayer.Bishop ) => aFilePath := aFilePath & "_bishop";
            when ModelLayer.FigureType'( ModelLayer.Rook ) => aFilePath := aFilePath & "_rook";
            when ModelLayer.FigureType'( ModelLayer.Queen ) => aFilePath := aFilePath & "_queen";
            when ModelLayer.FigureType'( ModelLayer.King ) => aFilePath := aFilePath & "_king";
         end case;
         
         if( aChessBoard.aGrid( aRowNo, aColNo ).isActivated = True ) then
            aFilePath := aFilePath & "_activated";
         end if;
      end if;
      
      if( aChessBoard.aGrid( aRowNo, aColNo ).isPossibleMove = True ) then
         aFilePath := aFilePath & "_possible_move";
      end if;
      
      aFilePath := aFilePath & ".png";
      
      Ada.Text_IO.Put_Line( "[" & aRowNo'Img & ", " & aColNo'Img & " ] " & "aFilePath = " & Ada.Strings.Unbounded.To_String( aFilePath ) );
      aImage := Gtk.Image.Gtk_Image_New_From_File( Ada.Strings.Unbounded.To_String( aFilePath ) );
      
      Gtk.Bin.Gtk_Bin( aMainWindow.aButtonGrid( row, col ) ).Add( Widget => aImage );
   end Update_Button;
   
   procedure Renew_Button( aRowNo : in ModelLayer.AxisY; aColNo : in ModelLayer.AxisX; 
                           aMainWindow : in out MainWindow; aChessBoard : in out ModelLayer.ChessBoard ) is
      row : AxisY := AxisY( aRowNo );
      col : AxisX := AxisX( aColNo );
   begin      
      Gtk.Container.Remove( Container => Gtk.Container.Gtk_Container( aMainWindow.aAlignmentGrid( row, col ) ),
                            Widget    => Gtk.Widget.Gtk_Widget( aMainWindow.aButtonGrid( row, col ) ) );
      Gtk.Button.Gtk_New( Button => aMainWindow.aButtonGrid( row, col ),
                          Label  => "Renewed_Button" );
      aMainWindow.aAlignmentGrid( row, col ).Add( Widget => aMainWindow.aButtonGrid( row, col ) );
      
      Update_Button( aRowNo      => aRowNo,
                     aColNo      => aColNo,
                     aMainWindow => aMainWindow,
                     aChessBoard => aChessBoard );
   end Renew_Button;
   
   procedure Initiate_MainWindow( aWindow : in out Gtk.Window.Gtk_Window;
                                  aVbox : in out Gtk.Box.Gtk_Vbox;
                                  aTable : in out Gtk.Table.Gtk_Table;
                                  aButtonGrid : in out ButtonGrid;
                                  aAlignmentGrid : in out AlignmentGrid ) is
      tmp : LabelWithAlignment;
   begin
      Gtk.Main.Init;

      Gtk.Window.Gtk_New( Window   => aWindow,
                          The_Type => Gtk.Enums.Window_Toplevel );

      Gtk.Box.Gtk_New_Vbox( aVbox );
      Gtk.Window.Add( aWindow, aVbox );
         
      aTable := Gtk.Table.Gtk_Table_New( Rows        => Glib.Guint( 10 ),
                                         Columns     => Glib.Guint( 10 ),
                                         Homogeneous => True );
      aVbox.Pack_Start(Child   => aTable,
                       Padding => 0 );
      
      for row in AxisY range 1..8 loop
         for col in AxisX range A..H loop
            
            tmp := GetEmptyLabel( aY     => row,
                                  aX     => col,
                                  aTable => aTable );
            tmp := GetLabel( aY     => row,
                             aX     => col,
                             aTable => aTable );
            tmp := GetLabel2( aY     => row,
                              aX     => col,
                              aTable => aTable );
            
            -- Ada.Text_IO.Put_Line("[" & row'Img & "," & col'Img & "] => [" & AxisY_For_Print( row )'Img & ", " & col'Img & " ]");
            Gtk.Button.Gtk_New( aButtonGrid( row, col ), 
                                String("[" & row'Img & "," & col'Img & "] => [" & AxisY_For_Print( row )'Img & ", " & col'Img & " ]") 
                               );
            
            aButtonGrid( row, col ) := Paint_Button( aButtonGrid, row, col );
            -- aButtonGrid( row, col ) := Paint_Button( aButtonGrid, Integer( row ), AxisX_to_Integer( col ) );
            
            aAlignmentGrid( row, col ) := Gtk.Alignment.Gtk_Alignment_New( Xalign => 0.5,
                                                                           Yalign => 0.5,
                                                                           Xscale => 1.0,
                                                                           Yscale => 1.0 );
            
            aAlignmentGrid( row, col ).Add( Widget => aButtonGrid( row, col ) );
            
            aTable.Attach( Child         => aAlignmentGrid( row, col ),
                           Left_Attach   => Glib.Guint( AxisX_to_Integer( col ) ),
                           Right_Attach  => Glib.Guint( AxisX_to_Integer( col )+1 ),
                           Top_Attach    => Glib.Guint( row ),
                           Bottom_Attach => Glib.Guint( row+1 ) );
         end loop;
      end loop;     
      
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
   
   function Integer_to_AxisX( aRowNo : Integer ) return AxisX is
   begin
      return AxisX( ModelLayer.Integer_to_AxisX( aRowNo ) );
   end Integer_to_AxisX;
   
   function AxisY_For_Print( aY : in AxisY ) return AxisY is
      aY_For_Print : AxisY := 9 - aY;
   begin
      return aY_For_Print;
   end AxisY_For_Print;
   
   function Paint_Button( aButtonGrid : in out ButtonGrid;
                          aRowNo : in Integer;
                          aColNo : in Integer ) 
                         return Gtk.Button.Gtk_Button is
      row : AxisY := AxisY( aRowNo );
      col : AxisX := Integer_to_AxisX( aColNo );
      aButton : Gtk.Button.Gtk_Button := aButtonGrid( row, col );
      aChild : Gtk.Widget.Gtk_Widget := Gtk.Bin.Gtk_Bin( aButton ).Get_Child;
      aImage : Gtk.Image.Gtk_Image;
   begin
      Gtk.Bin.Gtk_Bin( aButton ).Remove( aChild );
      aImage := Gtk.Image.Gtk_Image_New_From_File("images/b_empty.png");
      Gtk.Bin.Gtk_Bin( aButton ).Add( Widget => aImage );
      return aButton;
   end Paint_Button;
   
   function Paint_Button( aButtonGrid : in out ButtonGrid;
                          row : in AxisY;
                          col : in AxisX ) 
                         return Gtk.Button.Gtk_Button is
      aButton : Gtk.Button.Gtk_Button := aButtonGrid( row, col );
      aChild : Gtk.Widget.Gtk_Widget := Gtk.Bin.Gtk_Bin( aButton ).Get_Child;
      aImage : Gtk.Image.Gtk_Image;
   begin
      Gtk.Bin.Gtk_Bin( aButton ).Remove( aChild );
      aImage := Gtk.Image.Gtk_Image_New_From_File("images/w_empty.png");
      Gtk.Bin.Gtk_Bin( aButton ).Add( Widget => aImage );
      return aButton;
   end Paint_Button;
   
   --     type LabelWithAlignment is record
   --        aLabel : Gtk.Label.Gtk_Label;
   --        aAlignment : Gtk.Alignment.Gtk_Alignment;
   --     end record;
   function GetEmptyLabel( aY : AxisY;
                           aX : AxisX; 
                           aTable : Gtk.Table.Gtk_Table ) 
                          return LabelWithAlignment is
      aLabelWithAlignment : LabelWithAlignment;
      row, col : Integer;
      doDraw : Boolean := false;
   begin
      if( aY = 1 and aX = A ) then
         row := 1;
         col := 1;
         doDraw := True;
      end if;
      if( aY = 1 and aX = H ) then
         row := 1;
         col := 10;
         doDraw := True;
      end if;
      if( aY = 8 and aX = A ) then
         row := 10;
         col := 1;
         doDraw := True;
      end if;
      if( aY = 8 and aX = H ) then
         row := 10;
         col := 10;
         doDraw := True;
      end if;
      
      if( doDraw = True ) then
         aLabelWithAlignment.aLabel := Gtk.Label.Gtk_Label_New( " {><} " );
         aLabelWithAlignment.aAlignment := Gtk.Alignment.Gtk_Alignment_New( Xalign => 0.5,
                                                                            Yalign => 0.5,
                                                                            Xscale => 1.0,
                                                                            Yscale => 1.0 );      
         aLabelWithAlignment.aAlignment.Add( Widget => aLabelWithAlignment.aLabel );            
         aTable.Attach( Child         => aLabelWithAlignment.aAlignment,
                        Left_Attach   => Glib.Guint( col-1 ),
                        Right_Attach  => Glib.Guint( col ),
                        Top_Attach    => Glib.Guint( row-1 ),
                        Bottom_Attach => Glib.Guint( row ) );
      end if;
      
      return aLabelWithAlignment;
   end GetEmptyLabel;
   
   function GetLabel( aY : AxisY;
                      aX : AxisX; 
                      aTable : Gtk.Table.Gtk_Table ) 
                     return LabelWithAlignment is
      aLabelWithAlignment : LabelWithAlignment;
      row, col : Integer;
      doDraw : Boolean := false;
   begin
      if( aY = 1 ) then
         row := 1;
         col := AxisX_to_Integer( aX )+1;
         doDraw := True;
         aLabelWithAlignment.aLabel := Gtk.Label.Gtk_Label_New( aX'Img );
      end if;
      
      if( aY = 8 ) then
         row := 10;
         col := AxisX_to_Integer( aX )+1;
         doDraw := True;
         aLabelWithAlignment.aLabel := Gtk.Label.Gtk_Label_New( aX'Img );
      end if;
      
      if( aX = A ) then
         row := Integer( aY )+1;
         col := 1;
         doDraw := True;
         aLabelWithAlignment.aLabel := Gtk.Label.Gtk_Label_New( AxisY_For_Print( aY )'Img );
      end if;
      
      if( aX = H ) then
         row := Integer( aY )+1;
         col := 10;
         doDraw := True;
         aLabelWithAlignment.aLabel := Gtk.Label.Gtk_Label_New( AxisY_For_Print( aY )'Img );
      end if;
      
      if( doDraw = True ) then
         aLabelWithAlignment.aAlignment := Gtk.Alignment.Gtk_Alignment_New( Xalign => 0.5,
                                                                            Yalign => 0.5,
                                                                            Xscale => 1.0,
                                                                            Yscale => 1.0 );      
         aLabelWithAlignment.aAlignment.Add( Widget => aLabelWithAlignment.aLabel );            
         aTable.Attach( Child         => aLabelWithAlignment.aAlignment,
                        Left_Attach   => Glib.Guint( col-1 ),
                        Right_Attach  => Glib.Guint( col ),
                        Top_Attach    => Glib.Guint( row-1 ),
                        Bottom_Attach => Glib.Guint( row ) );
      end if;
      
      return aLabelWithAlignment;
   end GetLabel;
   
   function GetLabel2( aY : AxisY;
                       aX : AxisX; 
                       aTable : Gtk.Table.Gtk_Table ) 
                      return LabelWithAlignment is
      aLabelWithAlignment : LabelWithAlignment;
      row, col : Integer;
      doDraw : Boolean := false;
   begin
      if( (aY = 1) and (aX = A or aX = H) ) then
         row := 1;
         col := AxisX_to_Integer( aX )+1;
         doDraw := True;
         aLabelWithAlignment.aLabel := Gtk.Label.Gtk_Label_New( aX'Img );
      end if;
      
      if( (aY = 8) and (aX = A or aX = H) ) then
         row := 10;
         col := AxisX_to_Integer( aX )+1;
         doDraw := True;
         aLabelWithAlignment.aLabel := Gtk.Label.Gtk_Label_New( aX'Img );
      end if;
      
      if( doDraw = True ) then
         aLabelWithAlignment.aAlignment := Gtk.Alignment.Gtk_Alignment_New( Xalign => 0.5,
                                                                            Yalign => 0.5,
                                                                            Xscale => 1.0,
                                                                            Yscale => 1.0 );      
         aLabelWithAlignment.aAlignment.Add( Widget => aLabelWithAlignment.aLabel );            
         aTable.Attach( Child         => aLabelWithAlignment.aAlignment,
                        Left_Attach   => Glib.Guint( col-1 ),
                        Right_Attach  => Glib.Guint( col ),
                        Top_Attach    => Glib.Guint( row-1 ),
                        Bottom_Attach => Glib.Guint( row ) );
      end if;
      
      return aLabelWithAlignment;
   end GetLabel2;
   
end VisualLayer;
