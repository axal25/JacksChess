with VisualLayer; use VisualLayer;
with ModelLayer; use ModelLayer;
with GameTurn; use GameTurn;
with Gtk.Main;
with Gtk.Widget;
with Gtk.Window;
with Gtk.Button;
with Gtk.Bin;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package body ControllerLayer is

   aAllData : VisualLayer.AllData;
   aActivated_Position : ModelLayer.Position;
   isActivated : Boolean := False;
   aPossibleMoves : PossibleMoves;
   task_GT : GameTurn.GameTurnMain;
   aTurn : GameTurn.Turn;
   
   procedure Main is 
   begin
      aAllData := VisualLayer.Main;         
      aAllData.aMainWindow.aWindow.On_Destroy( DestroyObject_And_MainQuit'Access );
      Put_Line( "here?" );
      Setup_Task_GameTurn;
      SetPossibleToActivate;
      aAllData.aMainWindow.aWindow.Show_All;
      Gtk.Main.Main;
   end Main;
   
   procedure Setup_Task_GameTurn is
   begin
      task_GT.Start_the_Game;
      task_GT.Get_Turn( aTurn );
      task_GT.End_Turn( aTurn );
      Put_Line( "--------------" );
      task_GT.End_Turn( aTurn );
   end;
   
   procedure SetPossibleToActivate is
      aAliveFigures : ModelLayer.AliveFigures := aAllData.aChessBoard.aAliveFigures;      
      aTmpFigurePosition : ModelLayer.Position;
      aButton : Gtk.Button.Gtk_Button;
      IdPosition : Gtk.Handlers.Handler_Id;
   begin
      declare
         row : Integer;
      begin
         task_GT.Get_Turn( aTurn );
         if( aTurn = GameTurn.Player ) then
            row := 1;
         else
            row := 2;
         end if;
         for col in aAliveFigures.First(2) .. aAliveFigures.Last(2) loop
            aTmpFigurePosition := aAllData.aChessBoard.aAliveFigures.aDynamicTable( row, col ).aPosition; 
            aButton := aAllData.aMainWindow.aButtonGrid( VisualLayer.AxisY( aTmpFigurePosition.aYPosition), 
                                                         VisualLayer.AxisX( aTmpFigurePosition.aXPosition ) ); 
            
            IdPosition := UserCallback_Position.Connect( aButton, "clicked", 
                                                         UserCallback_Position.To_Marshaller( Activate_Button_Call'Access ),
                                                         aTmpFigurePosition ); 
            
            Put_Line( "[" & aTmpFigurePosition.aYPosition'Img & ", " & aTmpFigurePosition.aXPosition'Img & " ] is to SetPossibleToActivate " ); 
         end loop;
      end;
   end SetPossibleToActivate;
   
   procedure Activate_Button( aPosition : in ModelLayer.Position ) is
      IdPosition : Gtk.Handlers.Handler_Id;
   begin
      if( isActivated = True ) then
         Put_Line("Activate_Button [" & aPosition.aYPosition'Img & "," & aPosition.aXPosition'Img & "] vs. [" &
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
      
      FindPossibleMoves( aPosition );
      ShowPossibleMoves;
      aAllData.aMainWindow.aWindow.Show_All;
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
      HidePossibleMoves;
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
      aColor : ModelLayer.Color;
      aFigureType : ModelLayer.FigureType;
      isTaken : Boolean := aAllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).isTaken;
      tmpPosition : ModelLayer.Position := aPosition;
      row : ModelLayer.AxisY := aPosition.aYPosition;
   begin
      ---tmpPosition.aYPosition := aPosition.aYPosition +1;
      ---tmpPosition.aXPosition := ModelLayer.Integer_to_AxisX( ModelLayer.AxisX_to_Integer( tmpPosition.aXPosition ) +1 );
      Put_Line( ">> [" & tmpPosition.aYPosition'Img & "," & tmpPosition.aXPosition'Img & "]" );
      if( isTaken = True ) then
         aFigureType := ModelLayer.FigureType'( aAllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).aAccessFigure.all.aType );
         aColor := ModelLayer.Color'( aAllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).aAccessFigure.all.aColor );
         case aFigureType is
            when ModelLayer.FigureType'( ModelLayer.Pawn ) => Put_Line( "_pawn" );
               FindPossibleMovesPawn(aPosition => aPosition);
            when ModelLayer.FigureType'( ModelLayer.Knight ) => Put_Line( "_knight" );
               FindPossibleMovesKnight(aPosition => aPosition);
            when ModelLayer.FigureType'( ModelLayer.Bishop ) => Put_Line( "_bishop" );
               FindPossibleMovesBishop(aPosition => aPosition);
            when ModelLayer.FigureType'( ModelLayer.Rook ) => Put_Line(  "_rook" );
               FindPossibleMovesRook(aPosition => aPosition);
            when ModelLayer.FigureType'( ModelLayer.Queen ) => Put_Line( "_queen" );
               FindPossibleMovesBishop(aPosition => aPosition);
               FindPossibleMovesRook(aPosition => aPosition);
            when ModelLayer.FigureType'( ModelLayer.King ) => Put_Line( "_king" );
               FindPossibleMovesKing(aPosition => aPosition);
         end case;
         -- aPossibleMoves := newPossibleMoves( aPossibleMoves, 10 );
         -- aPossibleMoves := appendPossibleMoves( aPossibleMoves, aPosition );
         --           aPossibleMoves := newPossibleMoves( aPossibleMoves , 0 );
         --           declare
         --              aPosition1, aPosition2, aPosition3, aPosition4, aPosition5, aPosition6, aPosition7 : ModelLayer.Position;
         --           begin
         --              aPosition1.aYPosition := ModelLayer.AxisY( 1 );     aPosition1.aXPosition := ModelLayer.A;
         --              aPosition2.aYPosition := ModelLayer.AxisY( 2 );     aPosition2.aXPosition := ModelLayer.B;
         --              aPosition3.aYPosition := ModelLayer.AxisY( 3 );     aPosition3.aXPosition := ModelLayer.C;
         --              aPosition4.aYPosition := ModelLayer.AxisY( 4 );     aPosition4.aXPosition := ModelLayer.D;
         --              aPosition5.aYPosition := ModelLayer.AxisY( 5 );     aPosition5.aXPosition := ModelLayer.E;
         --              aPosition6.aYPosition := ModelLayer.AxisY( 6 );     aPosition6.aXPosition := ModelLayer.F;
         --              aPosition7.aYPosition := ModelLayer.AxisY( 7 );     aPosition7.aXPosition := ModelLayer.G;
         --              
         --              aPossibleMoves := appendPossibleMoves( aPossibleMoves, aPosition1 );
         --              aPossibleMoves := appendPossibleMoves( aPossibleMoves, aPosition2 );
         --              aPossibleMoves := appendPossibleMoves( aPossibleMoves, aPosition3 );
         --              aPossibleMoves := appendPossibleMoves( aPossibleMoves, aPosition4 );
         --              aPossibleMoves := appendPossibleMoves( aPossibleMoves, aPosition5 );
         --              aPossibleMoves := appendPossibleMoves( aPossibleMoves, aPosition6 );
         --              aPossibleMoves := appendPossibleMoves( aPossibleMoves, aPosition7 );
         --           end;
         Put_Line( "FindPossibleMoves: " & PossibleMovesToString( aPossibleMoves ) );
      end if;
      
   end FindPossibleMoves;
   
   procedure FindPossibleMovesPawn( aPosition : in ModelLayer.Position ) is
      aColor : ModelLayer.Color := aAllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).aAccessFigure.aColor;
      isTaken : Boolean := aAllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).isTaken;
      --tmpPosition : ModelLayer.Position := aPosition;
      row : ModelLayer.AxisY := aPosition.aYPosition;
      col : ModelLayer.AxisX := aPosition.aXPosition;
      tmp_row : ModelLayer.AxisY := aPosition.aYPosition;
      tmp_col : ModelLayer.AxisX := aPosition.aXPosition;
      aReturnPosition : Position;
   begin
      Put_Line( ">> sprawdzam" );    
      if(row > 1) then
         tmp_row := row -1;
         if(aColor = White) and (aAllData.aChessBoard.aGrid( tmp_row, tmp_col ).isTaken = False) then
            Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
            aPossibleMoves := appendPossibleMoves(outterPossibleMoves => aPossibleMoves,
                                                  aY                  => tmp_row,
                                                  ax                  => tmp_col);
            if(row = 7) then
               tmp_col := col;  
               tmp_row := row - 2;
               if(aAllData.aChessBoard.aGrid( tmp_row, tmp_col).isTaken = False) then
                  Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
                  aPossibleMoves := appendPossibleMoves(outterPossibleMoves => aPossibleMoves,
                                                        aY                  => tmp_row,
                                                        ax                  => tmp_col);
               end if;     
            end if;
            tmp_row := row -1;
         end if;

         PawnAttackMoves(tmp_row => tmp_row,
                         col     => col,
                         aColor  => aColor);    
      end if;
      if(row <8) then
         tmp_row := row +1;
         
         if(aColor = Black) and (aAllData.aChessBoard.aGrid( tmp_row, tmp_col ).isTaken = False) then
            Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
            aPossibleMoves := appendPossibleMoves(outterPossibleMoves => aPossibleMoves,
                                                  aY                  => tmp_row,
                                                  ax                  => tmp_col);
            if(row = 2) then
               tmp_col := col;  
               tmp_row := 4;
               if(aAllData.aChessBoard.aGrid( tmp_row, tmp_col).isTaken = False) then
                  Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
                  aPossibleMoves := appendPossibleMoves(outterPossibleMoves => aPossibleMoves,
                                                        aY                  => tmp_row,
                                                        ax                  => tmp_col);
               end if;     
            end if;
            tmp_row := row +1;
         end if; 
         PawnAttackMoves(tmp_row => tmp_row,
                         col     => col,
                         aColor  => aColor);    
      end if;          
   end FindPossibleMovesPawn;   
 
   procedure PawnAttackMoves( tmp_row : in ModelLayer.AxisY; col : in ModelLayer.AxisX; aColor : in ModelLayer.Color ) is
      tmp_col : ModelLayer.AxisX;
   begin
      if( ModelLayer.AxisX_to_Integer( col )>1) then
         tmp_col := ModelLayer.Integer_to_AxisX( ModelLayer.AxisX_to_Integer( col )-1) ;
         if(aAllData.aChessBoard.aGrid( tmp_row, tmp_col ).isTaken = True) then
            if (aAllData.aChessBoard.aGrid( tmp_row, tmp_col ).aAccessFigure.aColor /= aColor) then
               Put_Line( ">> ATTACK POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
               aPossibleMoves := appendPossibleMoves(outterPossibleMoves => aPossibleMoves,
                                                     aY                  => tmp_row,
                                                     ax                  => tmp_col);
            end if;
         end if;
      end if;
            
      if( ModelLayer.AxisX_to_Integer( col )<8) then
         tmp_col := ModelLayer.Integer_to_AxisX( ModelLayer.AxisX_to_Integer( col )+1) ;
         if(aAllData.aChessBoard.aGrid( tmp_row, tmp_col ).isTaken = True) then
            if (aAllData.aChessBoard.aGrid( tmp_row, tmp_col ).aAccessFigure.aColor /= aColor) then
               Put_Line( ">> ATTACK POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
               aPossibleMoves := appendPossibleMoves(outterPossibleMoves => aPossibleMoves,
                                                     aY                  => tmp_row,
                                                     ax                  => tmp_col);
            end if;
         end if;
      end if;     
   end PawnAttackMoves;
   
   procedure FindPossibleMovesKnight( aPosition : in ModelLayer.Position ) is
      tmp_Color : ModelLayer.Color := Black;
      aColor : ModelLayer.Color := aAllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).aAccessFigure.aColor;
      --   aFigureType : ModelLayer.FigureType;
      isTaken : Boolean := aAllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).isTaken;
      tmpPosition : ModelLayer.Position := aPosition;
      row : ModelLayer.AxisY := aPosition.aYPosition;
      col : ModelLayer.AxisX := aPosition.aXPosition;
      tmp_row : ModelLayer.AxisY := aPosition.aYPosition;
      tmp_col : ModelLayer.AxisX := aPosition.aXPosition;
   begin
      if(ModelLayer.AxisX_to_Integer( col )>2) then
         tmp_col := ModelLayer.Integer_to_AxisX( ModelLayer.AxisX_to_Integer( col )-2);
         if(row>1) then
            tmp_row := row -1;
            if(isEnemyOrEmpty(tmp_row, tmp_col, aColor)) then
               Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
               aPossibleMoves := appendPossibleMoves(outterPossibleMoves => aPossibleMoves,
                                                     aY                  => tmp_row,
                                                     ax                  => tmp_col);
            end if;
         end if;
         if(row<8) then
            tmp_row := row +1;
            if(isEnemyOrEmpty(tmp_row, tmp_col, aColor)) then
               Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
               aPossibleMoves := appendPossibleMoves(outterPossibleMoves => aPossibleMoves,
                                                     aY                  => tmp_row,
                                                     ax                  => tmp_col);
            end if;
         end if;
      end if;   
      -------------
      if(ModelLayer.AxisX_to_Integer( col )>1) then
         tmp_col := ModelLayer.Integer_to_AxisX( ModelLayer.AxisX_to_Integer( col )-1);
         if(row>2) then
            tmp_row := row -2;
            if(isEnemyOrEmpty(tmp_row, tmp_col, aColor)) then
               Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
               aPossibleMoves := appendPossibleMoves(outterPossibleMoves => aPossibleMoves,
                                                     aY                  => tmp_row,
                                                     ax                  => tmp_col);
            end if;
         end if;
         if(row<7) then
            tmp_row := row +2;
            if(isEnemyOrEmpty(tmp_row, tmp_col, aColor)) then
               Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
               aPossibleMoves := appendPossibleMoves(outterPossibleMoves => aPossibleMoves,
                                                     aY                  => tmp_row,
                                                     ax                  => tmp_col);
            end if;
         end if;
      end if;   
      ------------
      if(ModelLayer.AxisX_to_Integer( col )<7) then
         tmp_col := ModelLayer.Integer_to_AxisX( ModelLayer.AxisX_to_Integer( col )+2);
         if(row>1) then
            tmp_row := row -1;
            if(isEnemyOrEmpty(tmp_row, tmp_col, aColor)) then
               Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
               aPossibleMoves := appendPossibleMoves(outterPossibleMoves => aPossibleMoves,
                                                     aY                  => tmp_row,
                                                     ax                  => tmp_col);
            end if;
         end if;
         if(row<8) then
            tmp_row := row +1;
            if(isEnemyOrEmpty(tmp_row, tmp_col, aColor)) then
               Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
               aPossibleMoves := appendPossibleMoves(outterPossibleMoves => aPossibleMoves,
                                                     aY                  => tmp_row,
                                                     ax                  => tmp_col);
            end if;
         end if;
      end if;   
      -------------
      if(ModelLayer.AxisX_to_Integer( col )<8) then
         tmp_col := ModelLayer.Integer_to_AxisX( ModelLayer.AxisX_to_Integer( col )+1);
         if(row>2) then
            tmp_row := row -2;
            if(isEnemyOrEmpty(tmp_row, tmp_col, aColor)) then
               Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
               aPossibleMoves := appendPossibleMoves(outterPossibleMoves => aPossibleMoves,
                                                     aY                  => tmp_row,
                                                     ax                  => tmp_col);
            end if;
         end if;
         if(row<7) then
            tmp_row := row +2;
            if(isEnemyOrEmpty(tmp_row, tmp_col, aColor)) then
               Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
               aPossibleMoves := appendPossibleMoves(outterPossibleMoves => aPossibleMoves,
                                                     aY                  => tmp_row,
                                                     ax                  => tmp_col);
            end if;
         end if;
      end if;   		
          
   end FindPossibleMovesKnight;   
   

         
   procedure FindPossibleMovesBishop( aPosition : in ModelLayer.Position ) is
      tmp_Color : ModelLayer.Color := Black;
      aColor : ModelLayer.Color := aAllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).aAccessFigure.aColor;
      --   aFigureType : ModelLayer.FigureType;
      isTaken : Boolean := aAllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).isTaken;
      tmpPosition : ModelLayer.Position := aPosition;
      row : ModelLayer.AxisY := aPosition.aYPosition;
      col : ModelLayer.AxisX := aPosition.aXPosition;
      tmp_row : ModelLayer.AxisY := aPosition.aYPosition;
      tmp_col : ModelLayer.AxisX := aPosition.aXPosition;

   begin

      for i in Integer range 1..8 loop
         --Put_Line( ">> check1 [" & tmp_row'Img & "," & tmp_col'Img & "]" );
         if(Integer(row)>i) and (ModelLayer.AxisX_to_Integer( col )>i) then
            tmp_row := row - ModelLayer.AxisY(i);
            tmp_col := ModelLayer.Integer_to_AxisX( ModelLayer.AxisX_to_Integer( col )-i);
            if(FindPossibleMovesInLine(tmp_row => tmp_row,
                                       tmp_col => tmp_col,
                                       aColor  => aColor) = true) then
               exit;
            end if;
            
         end if;
      end loop;
      for i in Integer range 1..8 loop
         if(Integer(row)<9-i) and (ModelLayer.AxisX_to_Integer( col )<9-i) then
            tmp_row := row + ModelLayer.AxisY(i);
            tmp_col := ModelLayer.Integer_to_AxisX( ModelLayer.AxisX_to_Integer( col )+i);
            if(FindPossibleMovesInLine(tmp_row => tmp_row,
                                       tmp_col => tmp_col,
                                       aColor  => aColor) = true) then
               exit;
            end if;
            
         end if;
      end loop;
      for i in Integer range 1..8 loop
         if(Integer(row)>i) and (ModelLayer.AxisX_to_Integer( col )<9-i) then
            tmp_row := row - ModelLayer.AxisY(i);
            tmp_col := ModelLayer.Integer_to_AxisX( ModelLayer.AxisX_to_Integer( col )+i);
            if(FindPossibleMovesInLine(tmp_row => tmp_row,
                                       tmp_col => tmp_col,
                                       aColor  => aColor) = true) then
               exit;
            end if;
            
         end if;
      end loop;
      for i in Integer range 1..8 loop
         if(Integer(row)<9-i) and (ModelLayer.AxisX_to_Integer( col )>i) then
            tmp_row := row + ModelLayer.AxisY(i);
            tmp_col := ModelLayer.Integer_to_AxisX( ModelLayer.AxisX_to_Integer( col )-i);
            if(FindPossibleMovesInLine(tmp_row => tmp_row,
                                       tmp_col => tmp_col,
                                       aColor  => aColor) = true) then
               exit;
            end if;
            
         end if;
      end loop;
     
      
   end FindPossibleMovesBishop;
   
   procedure FindPossibleMovesRook( aPosition : in ModelLayer.Position ) is
      tmp_Color : ModelLayer.Color := Black;
      aColor : ModelLayer.Color := aAllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).aAccessFigure.aColor;
      --   aFigureType : ModelLayer.FigureType;
      isTaken : Boolean := aAllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).isTaken;
      tmpPosition : ModelLayer.Position := aPosition;
      row : ModelLayer.AxisY := aPosition.aYPosition;
      col : ModelLayer.AxisX := aPosition.aXPosition;
      tmp_row : ModelLayer.AxisY := aPosition.aYPosition;
      tmp_col : ModelLayer.AxisX := aPosition.aXPosition;

   begin

      for i in Integer range 1..8 loop
         --Put_Line( ">> check1 [" & tmp_row'Img & "," & tmp_col'Img & "]" );
         if(ModelLayer.AxisX_to_Integer( col )>i) then
            tmp_row := row;
            tmp_col := ModelLayer.Integer_to_AxisX( ModelLayer.AxisX_to_Integer( col )-i);
            if(FindPossibleMovesInLine(tmp_row => tmp_row,
                                       tmp_col => tmp_col,
                                       aColor  => aColor) = true) then
               exit;
            end if;
            
         end if;
      end loop;
      for i in Integer range 1..8 loop
         if(ModelLayer.AxisX_to_Integer( col )<9-i) then
            tmp_row := row;
            tmp_col := ModelLayer.Integer_to_AxisX( ModelLayer.AxisX_to_Integer( col )+i);
            if(FindPossibleMovesInLine(tmp_row => tmp_row,
                                       tmp_col => tmp_col,
                                       aColor  => aColor) = true) then
               exit;
            end if;
            
         end if;
      end loop;
      for i in Integer range 1..8 loop
         if(Integer(row)>i) then
            tmp_row := row - ModelLayer.AxisY(i);
            tmp_col := col;
            if(FindPossibleMovesInLine(tmp_row => tmp_row,
                                       tmp_col => tmp_col,
                                       aColor  => aColor) = true) then
               exit;
            end if;
            
         end if;
      end loop;
      for i in Integer range 1..8 loop
         if(Integer(row)<9-i) then
            tmp_row := row + ModelLayer.AxisY(i);
            tmp_col := col;
            if(FindPossibleMovesInLine(tmp_row => tmp_row,
                                       tmp_col => tmp_col,
                                       aColor  => aColor) = true) then
               exit;
            end if;
            
         end if;
      end loop;
     
      
   end FindPossibleMovesRook;
   
   procedure FindPossibleMovesKing( aPosition : in ModelLayer.Position ) is
      tmp_Color : ModelLayer.Color := Black;
      aColor : ModelLayer.Color := aAllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).aAccessFigure.aColor;
      --   aFigureType : ModelLayer.FigureType;
      isTaken : Boolean := aAllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).isTaken;
      tmpPosition : ModelLayer.Position := aPosition;
      row : ModelLayer.AxisY := aPosition.aYPosition;
      col : ModelLayer.AxisX := aPosition.aXPosition;
      tmp_row : ModelLayer.AxisY := aPosition.aYPosition;
      tmp_col : ModelLayer.AxisX := aPosition.aXPosition;

   begin

      if(ModelLayer.AxisX_to_Integer( col )>1) then
         tmp_col := ModelLayer.Integer_to_AxisX( ModelLayer.AxisX_to_Integer( col )-1);
         if(isEnemyOrEmpty(row    => tmp_row,
                           col    => tmp_col,
                           aColor => aColor)=true) then
            Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
            aPossibleMoves := appendPossibleMoves(outterPossibleMoves => aPossibleMoves,
                                                  aY                  => tmp_row,
                                                  ax                  => tmp_col);
         end if;
      end if;
      if(ModelLayer.AxisX_to_Integer( col )<8) then
         tmp_col := ModelLayer.Integer_to_AxisX( ModelLayer.AxisX_to_Integer( col )+1);
         if(isEnemyOrEmpty(row    => tmp_row,
                           col    => tmp_col,
                           aColor => aColor)=true) then
            Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
            aPossibleMoves := appendPossibleMoves(outterPossibleMoves => aPossibleMoves,
                                                  aY                  => tmp_row,
                                                  ax                  => tmp_col);
         end if;  
      end if;
      if(row>1) then
         tmp_row := row - 1;
         tmp_col := col;
         if(isEnemyOrEmpty(row    => tmp_row,
                           col    => col,
                           aColor => aColor)) then
            Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
            aPossibleMoves := appendPossibleMoves(outterPossibleMoves => aPossibleMoves,
                                                  aY                  => tmp_row,
                                                  ax                  => tmp_col);
         end if;
         if(ModelLayer.AxisX_to_Integer( col )>1) then
            tmp_col := ModelLayer.Integer_to_AxisX( ModelLayer.AxisX_to_Integer( col )-1);
            if(isEnemyOrEmpty(row    => tmp_row,
                              col    => tmp_col,
                              aColor => aColor)=true) then
               Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
               aPossibleMoves := appendPossibleMoves(outterPossibleMoves => aPossibleMoves,
                                                     aY                  => tmp_row,
                                                     ax                  => tmp_col);
            end if;
         end if;
         if(ModelLayer.AxisX_to_Integer( col )<8) then
            tmp_col := ModelLayer.Integer_to_AxisX( ModelLayer.AxisX_to_Integer( col )+1);
            if(isEnemyOrEmpty(row    => tmp_row,
                              col    => tmp_col,
                              aColor => aColor)=true) then
               Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
               aPossibleMoves := appendPossibleMoves(outterPossibleMoves => aPossibleMoves,
                                                     aY                  => tmp_row,
                                                     ax                  => tmp_col);
            end if;  
         end if; 
      end if;
      if(row<8) then
         tmp_row := row + 1;
         tmp_col :=col;
         if(isEnemyOrEmpty(row    => tmp_row,
                           col    => col,
                           aColor => aColor)) then
            Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
            aPossibleMoves := appendPossibleMoves(outterPossibleMoves => aPossibleMoves,
                                                  aY                  => tmp_row,
                                                  ax                  => tmp_col);
         end if;
         if(ModelLayer.AxisX_to_Integer( col )>1) then
            tmp_col := ModelLayer.Integer_to_AxisX( ModelLayer.AxisX_to_Integer( col )-1);
            if(isEnemyOrEmpty(row    => tmp_row,
                              col    => tmp_col,
                              aColor => aColor)=true) then
               Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
               aPossibleMoves := appendPossibleMoves(outterPossibleMoves => aPossibleMoves,
                                                     aY                  => tmp_row,
                                                     ax                  => tmp_col);
            end if;
         end if;
         if(ModelLayer.AxisX_to_Integer( col )<8) then
            tmp_col := ModelLayer.Integer_to_AxisX( ModelLayer.AxisX_to_Integer( col )+1);
            if(isEnemyOrEmpty(row    => tmp_row,
                              col    => tmp_col,
                              aColor => aColor)=true) then
               Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
               aPossibleMoves := appendPossibleMoves(outterPossibleMoves => aPossibleMoves,
                                                     aY                  => tmp_row,
                                                     ax                  => tmp_col);
            end if;  
         end if; 
      end if;
      
   end FindPossibleMovesKing;
   
   function FindPossibleMovesInLine ( tmp_row : in out ModelLayer.AxisY; tmp_col : in out ModelLayer.AxisX; aColor : in out ModelLayer.Color ) return Boolean is
      result : Boolean := false;
   begin
      if(aAllData.aChessBoard.aGrid( tmp_row, tmp_col ).isTaken = False) then
         Put_Line( ">> PUSTY POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
         aPossibleMoves := appendPossibleMoves(outterPossibleMoves => aPossibleMoves,
                                               aY                  => tmp_row,
                                               ax                  => tmp_col);
      else
         if(aAllData.aChessBoard.aGrid( tmp_row, tmp_col ).aAccessFigure.aColor /= aColor) then
            Put_Line( ">> ENEMY POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
            aPossibleMoves := appendPossibleMoves(outterPossibleMoves => aPossibleMoves,
                                                  aY                  => tmp_row,
                                                  ax                  => tmp_col);
                  
            result := true;
         else
            Put_Line( ">> MY BRO" );
            result := true;
         end if;
               
      end if;
      return result;
   end FindPossibleMovesInLine;
   
   function isEnemyOrEmpty( row : in out ModelLayer.AxisY; col : in out ModelLayer.AxisX; aColor : in out ModelLayer.Color ) return Boolean is
      result : Boolean := false;
   begin
      if(aAllData.aChessBoard.aGrid( row, col ).isTaken = False) then
         result := true;
      else
         if (aAllData.aChessBoard.aGrid( row, col  ).aAccessFigure.aColor /= aColor) then  
            result := true;
         end if;
      end if;
      return result;
   end isEnemyOrEmpty;

   function newPossibleMoves( outterPossibleMoves : in out PossibleMoves; newSize : in NaturalAndZero ) return PossibleMoves is
      aNewPossibleMoves : PossibleMoves;
   begin
      if( newSize > 0 ) then
         aNewPossibleMoves.aDynamicTable := new TableOfPositions(1..newSize);
         aNewPossibleMoves.First := 1;
         aNewPossibleMoves.Last := newSize;
      else
         aNewPossibleMoves.aDynamicTable := null;
         aNewPossibleMoves.First := 0;
         aNewPossibleMoves.Last := 0;
      end if;
      outterPossibleMoves := aNewPossibleMoves;
      return outterPossibleMoves;
   end newPossibleMoves;
   
   function appendPossibleMoves( outterPossibleMoves : in out PossibleMoves; newPosition : in ModelLayer.Position ) return PossibleMoves is
      aNewPossibleMoves : PossibleMoves; 
   begin
      aNewPossibleMoves := newPossibleMoves( aNewPossibleMoves, outterPossibleMoves.Last +1 );
      if( aNewPossibleMoves.Last = 0 ) then
         Put_Line( "nigdy?" );
      else
         if( aNewPossibleMoves.First = aNewPossibleMoves.Last ) then
            aNewPossibleMoves.aDynamicTable( aNewPossibleMoves.First ) := newPosition;
         else
            for I in outterPossibleMoves.First .. outterPossibleMoves.Last loop
               aNewPossibleMoves.aDynamicTable( I ) := outterPossibleMoves.aDynamicTable( I );
            end loop;
            aNewPossibleMoves.aDynamicTable( outterPossibleMoves.Last +1 ) := newPosition;
         end if;
      end if;
      
      outterPossibleMoves := aNewPossibleMoves;
      return outterPossibleMoves;
   end appendPossibleMoves;
   
   function appendPossibleMoves( outterPossibleMoves : in out PossibleMoves; 
                                 aY : ModelLayer.AxisY; ax : ModelLayer.AxisX ) 
                                return PossibleMoves is
      newPosition : ModelLayer.Position;
   begin
      newPosition.aYPosition := aY;
      newPosition.aXPosition := aX;
      outterPossibleMoves := appendPossibleMoves( outterPossibleMoves, newPosition );
      Put_Line( "append( ..., aY, aX) => " & PossibleMovesToString( aPossibleMoves ) );
      return outterPossibleMoves;
   end appendPossibleMoves;
   
   function removePossibleMoves( outterPossibleMoves : in out PossibleMoves; aPosition : in ModelLayer.Position ) return PossibleMoves is
      aNewPossibleMoves : PossibleMoves; 
      J : NaturalAndZero;
   begin
      if( outterPossibleMoves.Last = 0 ) then
         null; -- do nothing
      else
         aNewPossibleMoves := newPossibleMoves( aNewPossibleMoves, outterPossibleMoves.Last -1 );
         if( aNewPossibleMoves.Last = 0 ) then
            null; -- do nothing
         else
            if( aNewPossibleMoves.First = aNewPossibleMoves.Last ) then
               for i in outterPossibleMoves.First .. outterPossibleMoves.Last loop
                  if( outterPossibleMoves.aDynamicTable( I ).aYPosition = aPosition.aYPosition and
                       outterPossibleMoves.aDynamicTable( I ).aXPosition = aPosition.aXPosition ) then
                     null; -- do nothing
                  else
                     aNewPossibleMoves.aDynamicTable( aNewPossibleMoves.First ) := outterPossibleMoves.aDynamicTable( I );
                  end if;
               end loop;
            else
               J := aNewPossibleMoves.First;
               for I in outterPossibleMoves.First .. outterPossibleMoves.Last loop
                  if( outterPossibleMoves.aDynamicTable( I ).aYPosition = aPosition.aYPosition and
                       outterPossibleMoves.aDynamicTable( I ).aXPosition = aPosition.aXPosition ) then
                     null; -- do nothing
                  else
                     aNewPossibleMoves.aDynamicTable( J ) := outterPossibleMoves.aDynamicTable( I );
                     J := J + 1;
                  end if;
                  exit when J > aNewPossibleMoves.Last;
               end loop;
            end if;
      
         end if;
         outterPossibleMoves := aNewPossibleMoves;
      end if;
      return outterPossibleMoves;
   end removePossibleMoves;
   
   function isPossibleMovesEmpty( outterPossibleMoves : in out PossibleMoves ) return Boolean is
      isEmpty : Boolean := False;
   begin
      if( outterPossibleMoves.First = outterPossibleMoves.Last and
           outterPossibleMoves.Last = 0 and
             outterPossibleMoves.aDynamicTable = null ) then
         isEmpty := True;
      else
         isEmpty := False;
      end if;
      
      return isEmpty;
   end;
   
   function PossibleMovesToString( outterPossibleMoves : in out PossibleMoves ) return String is
      aDynString : Ada.Strings.Unbounded.Unbounded_String := Ada.Strings.Unbounded.To_Unbounded_String("[ ");
   begin
      if( isPossibleMovesEmpty( outterPossibleMoves ) = True ) then
         null; -- do nothing
      else
         if( outterPossibleMoves.First = outterPossibleMoves.Last ) then
            aDynString := aDynString & "{" & outterPossibleMoves.aDynamicTable( outterPossibleMoves.First ).aYPosition'Img & 
              "," & outterPossibleMoves.aDynamicTable( outterPossibleMoves.First ).aXPosition'Img & "}";
         else
            for I in outterPossibleMoves.First .. outterPossibleMoves.Last loop
               if( I = outterPossibleMoves.First ) then
                  aDynString := aDynString & "{" & outterPossibleMoves.aDynamicTable( I ).aYPosition'Img & 
                    "," & outterPossibleMoves.aDynamicTable( I ).aXPosition'Img & "}";
               else
                  aDynString := aDynString & " , {" & outterPossibleMoves.aDynamicTable( I ).aYPosition'Img & 
                    "," & outterPossibleMoves.aDynamicTable( I ).aXPosition'Img & "}";
               end if;
            end loop;
         end if;
      end if;
         
      aDynString := aDynString & " ]";
      declare
         aString : String := Ada.Strings.Unbounded.To_String( aDynString );
      begin
         return aString;
      end;
   end;
   
   procedure ShowPossibleMoves is
   begin
      if( aPossibleMoves.Last = 0 ) then
         null; --do nothing
      else
         if( aPossibleMoves.First = aPossibleMoves.Last ) then
            ShowPossibleMove( aPossibleMoves.aDynamicTable( aPossibleMoves.Last ) );
         else
            for I in aPossibleMoves.First .. aPossibleMoves.Last loop
               ShowPossibleMove( aPossibleMoves.aDynamicTable( I ) );
            end loop;
         end if;
      end if;
   end ShowPossibleMoves;
   
   procedure ShowPossibleMove( aPosition : in out ModelLayer.Position ) is
      IdPosition : Gtk.Handlers.Handler_Id;
   begin
      aAllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).isPossibleMove := True;
      VisualLayer.Renew_Button( aRowNo      => aPosition.aYPosition,
                                aColNo      => aPosition.aXPosition,
                                aMainWindow => aAllData.aMainWindow,
                                aChessBoard => aAllData.aChessBoard );
      IdPosition := UserCallback_Position.Connect( aAllData.aMainWindow.aButtonGrid( VisualLayer.AxisY( aPosition.aYPosition ), VisualLayer.AxisX( aPosition.aXPosition ) ), 
                                                   "clicked", 
                                                   UserCallback_Position.To_Marshaller( Move_Figure_Call'Access ),
                                                   aPosition );
   end;
   
   procedure HidePossibleMoves is
   begin
      if( isPossibleMovesEmpty( aPossibleMoves ) ) then
         null; --do nothing
      else
         if( aPossibleMoves.First = aPossibleMoves.Last ) then
            HidePossibleMove( aPossibleMoves.aDynamicTable( aPossibleMoves.Last ) );
         else
            while( isPossibleMovesEmpty( aPossibleMoves ) = False ) loop
               HidePossibleMove( aPossibleMoves.aDynamicTable( aPossibleMoves.Last ) );
            end loop;
         end if;
      end if;
   end;
   
   procedure HidePossibleMove( aPosition : in out ModelLayer.Position ) is
      IdPosition : Gtk.Handlers.Handler_Id;
   begin
      aAllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).isPossibleMove := False;
      VisualLayer.Renew_Button( aRowNo      => aPosition.aYPosition,
                                aColNo      => aPosition.aXPosition,
                                aMainWindow => aAllData.aMainWindow,
                                aChessBoard => aAllData.aChessBoard );
      if( aAllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).isTaken = True ) then
         IdPosition := UserCallback_Position.Connect( aAllData.aMainWindow.aButtonGrid( VisualLayer.AxisY( aPosition.aYPosition ), VisualLayer.AxisX( aPosition.aXPosition ) ), 
                                                      "clicked", 
                                                      UserCallback_Position.To_Marshaller( Activate_Button_Call'Access ),
                                                      aPosition );
      end if;
      aPossibleMoves := removePossibleMoves( outterPossibleMoves => aPossibleMoves,
                                             aPosition           => aPosition );
   end HidePossibleMove;
   
   procedure Move_Figure_Call( Object : access Gtk.Widget.Gtk_Widget_Record'Class; aToPosition : in ModelLayer.Position ) is
   begin
      Put_Line("#1 Move_Figure_Call => [" & aToPosition.aYPosition'Img & "," & aToPosition.aXPosition'Img & "]");
      Move_Figure( aToPosition );
      Put_Line("#1 Move_Figure_Call => [" & aToPosition.aYPosition'Img & "," & aToPosition.aXPosition'Img & "]");
   end Move_Figure_Call;
   
   procedure Move_Figure( aToPosition : in ModelLayer.Position ) is
      aFromPosition : ModelLayer.Position;
   begin
      Put_Line("#1 Move_Figure => [" & aToPosition.aYPosition'Img & "," & aToPosition.aXPosition'Img & "] <-- [" &
                 aFromPosition.aYPosition'Img & "," & aFromPosition.aXPosition'Img & "] (isActivated = " & isActivated'Img & ")" );
      if( isActivated = True ) then
         aFromPosition := aActivated_Position;
         
         aAllData.aChessBoard := ModelLayer.MoveFigure( aFromPosition, aToPosition, aAllData.aChessBoard );
         
         if( aAllData.aChessBoard.aGrid( aToPosition.aYPosition, aToPosition.aXPosition ).isTaken = False ) then
            aAllData.aChessBoard.aGrid( aToPosition.aYPosition, aToPosition.aXPosition ).isTaken := True;
         end if;
         Deactivate_Button;
         HidePossibleMoves;
      else
         null; -- do nothing
      end if;
      Put_Line("#2 Move_Figure => [" & aToPosition.aYPosition'Img & "," & aToPosition.aXPosition'Img & "] <-- [" &
                 aFromPosition.aYPosition'Img & "," & aFromPosition.aXPosition'Img & "] (isActivated = " & isActivated'Img & ")" );
   end Move_Figure;
   
   procedure DestroyObject_And_MainQuit( Object: access Gtk.Widget.Gtk_Widget_Record'Class ) is --on event
      -- close main window if Delete_Event return False (it means it's allowed to close);
   begin
      Ada.Text_IO.Put_Line( "X clicked - Destroying object" );
      Gtk.Widget.Destroy( Object );
      Gtk.Main.Main_Quit;
      task_GT.End_of_the_Game;
   end DestroyObject_And_MainQuit;

end ControllerLayer;
