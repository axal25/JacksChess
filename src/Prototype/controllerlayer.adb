with VisualLayer; use VisualLayer;
with ModelLayer; use ModelLayer;
with Gtk.Main;
with Gtk.Widget;
with Gtk.Window;
with Gtk.Button;
with Gtk.Bin;
with Ada.Text_IO; use Ada.Text_IO;

package body ControllerLayer is

   aAllData : VisualLayer.AllData;
   aActivated_Position : ModelLayer.Position;
   isActivated : Boolean := False;
   aPossibleMoves : PossibleMoves;
   
   procedure Main is 
   begin
      aAllData := VisualLayer.Main;
      SetPossibleToActivate;
        
      aAllData.aMainWindow.aWindow.Show_All;
      Gtk.Main.Main;
   end Main;
   
   procedure SetPossibleToActivate is
      aAliveFigures : ModelLayer.AliveFigures := aAllData.aChessBoard.aAliveFigures;      
      aTmpFigurePosition : ModelLayer.Position;
      aButton : Gtk.Button.Gtk_Button;
      IdPosition : Gtk.Handlers.Handler_Id;
   begin
      for row in aAliveFigures.First(1) .. aAliveFigures.Last(1) loop
         for col in aAliveFigures.First(2) .. aAliveFigures.Last(2) loop
            aTmpFigurePosition := aAllData.aChessBoard.aAliveFigures.aDynamicTable( row, col ).aPosition; 
            aButton := aAllData.aMainWindow.aButtonGrid( VisualLayer.AxisY( aTmpFigurePosition.aYPosition), 
                                                         VisualLayer.AxisX( aTmpFigurePosition.aXPosition ) ); 
            
            IdPosition := UserCallback_Position.Connect( aButton, "clicked", 
                                                         UserCallback_Position.To_Marshaller( Activate_Button_Call'Access ),
                                                         aTmpFigurePosition ); 
            
            Put_Line( "[" & aTmpFigurePosition.aYPosition'Img & ", " & aTmpFigurePosition.aXPosition'Img & " ] is to SetPossibleToActivate " ); 
         end loop;
      end loop;
   end SetPossibleToActivate;
   
   procedure Activate_Button( aPosition : in ModelLayer.Position ) is
      IdPosition : Gtk.Handlers.Handler_Id;
   begin
      if( isActivated = True ) then
         Put_Line("[" & aPosition.aYPosition'Img & "," & aPosition.aXPosition'Img & "] vs. [" &
                    aActivated_Position.aYPosition'Img & "," & aActivated_Position.aXPosition'Img & "]" );
         Deactivate_Button;
      end if;
      SetActive_aActivatedPosition( aPosition );
      aAllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).isActivated := True;
      VisualLayer.Renew_Button( aRowNo      => aPosition.aYPosition,
                                aColNo      => aPosition.aXPosition,
                                aMainWindow => aAllData.aMainWindow,
                                aChessBoard => aAllData.aChessBoard );
      IdPosition := UserCallback_Position.Connect( aAllData.aMainWindow.aButtonGrid( VisualLayer.AxisY( aPosition.aYPosition ), VisualLayer.AxisX( aPosition.aXPosition ) ), 
                                                   "clicked", 
                                                   UserCallback_Position.To_Marshaller( Deactivate_Button_Call'Access ),
                                                   aPosition );
      aAllData.aMainWindow.aWindow.Show_All;
      
      FindPossibleMoves( aPosition );
   end Activate_Button;
   
   procedure Activate_Button_Call( Object : access Gtk.Widget.Gtk_Widget_Record'Class; aPosition : in ModelLayer.Position ) is
   begin
      Activate_Button( aPosition );
   end Activate_Button_Call;
   
   procedure Deactivate_Button is
      aPosition : ModelLayer.Position := aActivated_Position;
      IdPosition : Gtk.Handlers.Handler_Id;
   begin
      aAllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).isActivated := False;
      SetDeactive_aActivatedPosition;
      VisualLayer.Renew_Button( aRowNo      => aPosition.aYPosition,
                                aColNo      => aPosition.aXPosition,
                                aMainWindow => aAllData.aMainWindow,
                                aChessBoard => aAllData.aChessBoard );
      IdPosition := UserCallback_Position.Connect( aAllData.aMainWindow.aButtonGrid( VisualLayer.AxisY( aPosition.aYPosition ), VisualLayer.AxisX( aPosition.aXPosition ) ), 
                                                   "clicked", 
                                                   UserCallback_Position.To_Marshaller( Activate_Button_Call'Access ),
                                                   aPosition ); 
      aAllData.aMainWindow.aWindow.Show_All;
   end Deactivate_Button;
   
   procedure Deactivate_Button_Call( Object : access Gtk.Widget.Gtk_Widget_Record'Class; aPosition : in Position ) is
   begin
      Deactivate_Button;
   end Deactivate_Button_Call;
   
   procedure SetDeactive_aActivatedPosition is
   begin
      isActivated := False;
   end SetDeactive_aActivatedPosition;
                                     
   procedure SetActive_aActivatedPosition( aPosition : in ModelLayer.Position ) is
   begin
      aActivated_Position := aPosition;
      isActivated := True;
   end SetActive_aActivatedPosition;
   
   procedure FindPossibleMoves( aPosition : in ModelLayer.Position ) is
      aFigureType : ModelLayer.FigureType;
   begin
      if( aAllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).isTaken = True ) then
         aFigureType := ModelLayer.FigureType'( aAllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).aAccessFigure.all.aType );
         case ModelLayer.FigureType'( aAllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).aAccessFigure.all.aType ) is
            when ModelLayer.FigureType'( ModelLayer.Pawn ) => Put_Line( "_pawn" );
            when ModelLayer.FigureType'( ModelLayer.Knight ) => Put_Line( "_knight" );
            when ModelLayer.FigureType'( ModelLayer.Bishop ) => Put_Line( "_bishop" );
            when ModelLayer.FigureType'( ModelLayer.Rook ) => Put_Line(  "_rook" );
            when ModelLayer.FigureType'( ModelLayer.Queen ) => Put_Line( "_queen" );
            when ModelLayer.FigureType'( ModelLayer.King ) => Put_Line( "_king" );
         end case;
         aPossibleMoves := newPossibleMoves( aPossibleMoves, 10 );
      end if;
      
      
   end FindPossibleMoves;
   
   function newPossibleMoves( outterPossibleMoves : in out PossibleMoves; newSize : in Natural ) return PossibleMoves is
   begin
      outterPossibleMoves.aDynamicTable := new TableOfPositions(1..newSize);
      outterPossibleMoves.First := 1;
      outterPossibleMoves.Last := newSize;
      
      return outterPossibleMoves;
   end newPossibleMoves;

end ControllerLayer;
