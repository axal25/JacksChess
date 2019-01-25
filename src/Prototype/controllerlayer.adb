with VisualLayer; use VisualLayer;
with ModelLayer; use ModelLayer;
with GameTurn; use GameTurn;
with AfterGameWindow;
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
   aTurn : GameTurn.Turn := GameTurn.Player;
   
   procedure Main is 
   begin
      aAllData := VisualLayer.Main;         
      aAllData.aMainWindow.aWindow.On_Destroy( DestroyObject_And_MainQuit'Access );
      Setup_Task_GameTurn;
      SetPossibleToActivate;
      aAllData.aMainWindow.aWindow.Show_All;
      Gtk.Main.Main;
   end Main;
   
   procedure Setup_Task_GameTurn is
   begin
      task_GT.Start_the_Game;
   end;
   
   procedure SetPossibleToActivate is
      aAliveFigures : ModelLayer.AliveFigures := aAllData.aChessBoard.aAliveFigures;      
      aTmpFigurePosition : ModelLayer.Position;
      aTmpButton : Gtk.Button.Gtk_Button;
      IdPosition : Gtk.Handlers.Handler_Id;
   begin
      declare
         row : Integer;
      begin
         if( aTurn = GameTurn.Player ) then
            row := 1;
         else
            row := 2;
            task_GT.Reset_PossibleActivations;
         end if;
         for col in aAliveFigures.First(2) .. aAliveFigures.Last(2) loop
            aTmpFigurePosition := aAllData.aChessBoard.aAliveFigures.aDynamicTable( row, col ).aPosition; 
            aTmpButton := aAllData.aMainWindow.aButtonGrid( VisualLayer.AxisY( aTmpFigurePosition.aYPosition), 
                                                            VisualLayer.AxisX( aTmpFigurePosition.aXPosition ) ); 
            
            IdPosition := UserCallback_Position.Connect( aTmpButton, "clicked", 
                                                         UserCallback_Position.To_Marshaller( Activate_Button_Call'Access ),
                                                         aTmpFigurePosition ); 
            
            --              Put_Line( "[" & aTmpFigurePosition.aYPosition'Img & ", " & aTmpFigurePosition.aXPosition'Img & " ] is to SetPossibleToActivate " ); 
            if( aTurn = GameTurn.Computer ) then
               task_GT.Append_PossibleActivations( aTmpButton );
            end if;
         end loop;
         
         if( aTurn = GameTurn.Computer ) then
            while( isPossibleMovesEmpty( aPossibleMoves ) ) loop
               Put_Line( " >> 1nd button click - computer activate << " );
               task_GT.Click_RandomButton;
               if( isPossibleMovesEmpty( aPossibleMoves ) ) then
                  ComputerDeactivateOnEmptyPossibleMoves;
               end if;
            end loop;
            task_GT.Reset_PossibleActivations;
            for I in aPossibleMoves.First .. aPossibleMoves.Last loop
               task_GT.Append_PossibleActivations( 
                                                   aAllData.aMainWindow.aButtonGrid( 
                                                     VisualLayer.AxisY( aPossibleMoves.aDynamicTable( I ).aYPosition ), 
                                                     VisualLayer.AxisX( aPossibleMoves.aDynamicTable( I ).aXPosition )
                                                    )
                                                  );
            end loop;
            Put_Line( " >> 2nd button click - computer move << " );
            task_GT.Click_RandomButton;
            Put_Line( " !!! ### Powrot do SetPossibleToActivate ### !!! " );
         end if;
         
      end;
      Put_Line("is SetPossibleToActivate ever dieing?");
   end SetPossibleToActivate;
   
   procedure DeSetPossibleToActivate is
      row : Integer;
      aTmpFigurePosition : ModelLayer.Position;
   begin
      
      if( aTurn = GameTurn.Player ) then
         row := 1;
      else
         row := 2;
      end if;
      for col in aAllData.aChessBoard.aAliveFigures.First(2) .. aAllData.aChessBoard.aAliveFigures.Last(2) loop
         aTmpFigurePosition := aAllData.aChessBoard.aAliveFigures.aDynamicTable( row, col ).aPosition; 
         VisualLayer.Renew_Button( aRowNo      => aTmpFigurePosition.aYPosition,
                                   aColNo      => aTmpFigurePosition.aXPosition,
                                   aMainWindow => aAllData.aMainWindow,
                                   aChessBoard => aAllData.aChessBoard );
         --              Put_Line( "[" & aTmpFigurePosition.aYPosition'Img & ", " & aTmpFigurePosition.aXPosition'Img & " ] is to DeSetPossibleToActivate " ); 
      end loop;
      aAllData.aMainWindow.aWindow.Show_All;
         
   end DeSetPossibleToActivate;   
   
   procedure ComputerDeactivateOnEmptyPossibleMoves is
      aActivated_Button : Gtk.Button.Gtk_Button;
   begin
      if( aTurn = GameTurn.Computer ) then
         if( isActivated = True ) then
            aActivated_Button := aAllData.aMainWindow.aButtonGrid( VisualLayer.AxisY( aActivated_Position.aYPosition ), 
                                                                   VisualLayer.AxisX( aActivated_Position.aXPosition ) );
            task_GT.Set_ButtonToReclick( aActivated_Button );
            if( isPossibleMovesEmpty( aPossibleMoves ) ) then
               Put_Line( "task_GT.ReClick_Button; \/" );
               task_GT.ReClick_Button;
               Put_Line( "task_GT.ReClick_Button; /\" );
            end if;
         end if;
      end if;
   end ComputerDeactivateOnEmptyPossibleMoves;
   
   procedure Activate_Button( aPosition : in ModelLayer.Position ) is
      IdPosition : Gtk.Handlers.Handler_Id;
      --        aButtonToDeactivate : Gtk.Button.Gtk_Button;
   begin
      if( isActivated = True ) then
         Put_Line("Activate_Button [" & aPosition.aYPosition'Img & "," & aPosition.aXPosition'Img & "] vs. [" &
                    aActivated_Position.aYPosition'Img & "," & aActivated_Position.aXPosition'Img & "]" );
         Deactivate_Button;
      end if;
      SetActive_aActivatedPosition( aPosition );
      VisualLayer.Renew_Button( aRowNo      => aPosition.aYPosition,
                                aColNo      => aPosition.aXPosition,
                                aMainWindow => aAllData.aMainWindow,
                                aChessBoard => aAllData.aChessBoard );
      
      --        if( aTurn = GameTurn.Computer ) then
      --           aButtonToDeactivate := aAllData.aMainWindow.aButtonGrid( VisualLayer.AxisY( aPosition.aYPosition), 
      --                                                                 VisualLayer.AxisX( aPosition.aXPosition ) ); 
      --           task_GT.Set_ButtonToReclick( aButtonToDeactivate );
      --        end if;
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
      aAllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).isActivated := True;
      aActivated_Position := aPosition;
      isActivated := True;
   end SetActive_aActivatedPosition;
   
   procedure FindPossibleMoves( aPosition : in ModelLayer.Position ) is
      aColor : ModelLayer.Color;
      aFigureType : ModelLayer.FigureType;
      isTaken : Boolean := aAllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).isTaken;
      tmpPosition : ModelLayer.Position := aPosition;
      row : ModelLayer.AxisY := aPosition.aYPosition;
      tmpPossibleMoves : PossibleMoves;
   begin
      aPossibleMoves := FindMoves(tmp_AllData => aAllData,
                                  aPosition   => tmpPosition,
                                  aColor      => aColor);
      ---tmpPosition.aYPosition := aPosition.aYPosition +1;
      ---tmpPosition.aXPosition := ModelLayer.Integer_to_AxisX( ModelLayer.AxisX_to_Integer( tmpPosition.aXPosition ) +1 );
      --   Put_Line( ">> [" & tmpPosition.aYPosition'Img & "," & tmpPosition.aXPosition'Img & "]" );
      
      
   end FindPossibleMoves;
   
   function FindMoves (tmp_AllData : in  VisualLayer.AllData; aPosition : in ModelLayer.Position; aColor :in  ModelLayer.Color) return PossibleMoves is
      bColor : ModelLayer.Color;
      aFigureType : ModelLayer.FigureType;
      isTaken : Boolean := tmp_AllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).isTaken;
      tmpPosition : ModelLayer.Position := aPosition;
      row : ModelLayer.AxisY := aPosition.aYPosition;
      tmpPossibleMoves : PossibleMoves;
   begin
      if( isTaken = True ) then
         aFigureType := ModelLayer.FigureType'( tmp_AllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).aAccessFigure.all.aType );
         bColor := ModelLayer.Color'( tmp_AllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).aAccessFigure.all.aColor );
         case aFigureType is
            when ModelLayer.FigureType'( ModelLayer.Pawn ) => Put_Line( "_pawn" );
               tmpPossibleMoves := FindPossibleMovesPawn(tmp_AllData => tmp_AllData,
                                                         aPosition       => tmpPosition,
                                                         inPossibleMoves => tmpPossibleMoves);
            when ModelLayer.FigureType'( ModelLayer.Knight ) => Put_Line( "_knight" );
               tmpPossibleMoves := FindPossibleMovesKnight(tmp_AllData => tmp_AllData,
                                                           aPosition       => tmpPosition,
                                                           inPossibleMoves => tmpPossibleMoves);
            when ModelLayer.FigureType'( ModelLayer.Bishop ) => Put_Line( "_bishop" );
               tmpPossibleMoves := FindPossibleMovesBishop(tmp_AllData => tmp_AllData,
                                                           aPosition       => tmpPosition,
                                                           inPossibleMoves => tmpPossibleMoves);
            when ModelLayer.FigureType'( ModelLayer.Rook ) => Put_Line(  "_rook" );
               tmpPossibleMoves := FindPossibleMovesRook(tmp_AllData => tmp_AllData,
                                                         aPosition       => tmpPosition,
                                                         inPossibleMoves => tmpPossibleMoves);
            when ModelLayer.FigureType'( ModelLayer.Queen ) => Put_Line( "_queen" );
               tmpPossibleMoves := FindPossibleMovesBishop(tmp_AllData => tmp_AllData,
                                                           aPosition       => tmpPosition,
                                                           inPossibleMoves => tmpPossibleMoves);
               tmpPossibleMoves := FindPossibleMovesRook(tmp_AllData => tmp_AllData,
                                                         aPosition       => tmpPosition,
                                                         inPossibleMoves => tmpPossibleMoves);
            when ModelLayer.FigureType'( ModelLayer.King ) => Put_Line( "_king" );
               tmpPossibleMoves := FindPossibleMovesKing(tmp_AllData => tmp_AllData,
                                                         aPosition       => tmpPosition,
                                                         inPossibleMoves => tmpPossibleMoves);
         end case;
         Put_Line( "FindPossibleMoves: " & PossibleMovesToString( tmpPossibleMoves ) );
      end if;
      return tmpPossibleMoves;
   end FindMoves;
   
   function FindPossibleMovesPawn( tmp_AllData : in  VisualLayer.AllData; aPosition : in ModelLayer.Position; inPossibleMoves : in out PossibleMoves ) return PossibleMoves is
      tmpPossibleMoves : PossibleMoves := inPossibleMoves;
      aColor : ModelLayer.Color := tmp_AllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).aAccessFigure.aColor;
      isTaken : Boolean := tmp_AllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).isTaken;
      --tmpPosition : ModelLayer.Position := aPosition;
      row : ModelLayer.AxisY := aPosition.aYPosition;
      col : ModelLayer.AxisX := aPosition.aXPosition;
      tmp_row : ModelLayer.AxisY := aPosition.aYPosition;
      tmp_col : ModelLayer.AxisX := aPosition.aXPosition;
      aReturnPosition : Position;

   begin
      --   Put_Line( ">> sprawdzam" );    
      if(row > 1) then
         tmp_row := row -1;
         if(aColor = White) and (tmp_AllData.aChessBoard.aGrid( tmp_row, tmp_col ).isTaken = False) then
            --   Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
            tmpPossibleMoves := appendPossibleMoves(outterPossibleMoves => tmpPossibleMoves,
                                                    aY                  => tmp_row,
                                                    ax                  => tmp_col);
            if(row = 7) then
               tmp_col := col;  
               tmp_row := row - 2;
               if(tmp_AllData.aChessBoard.aGrid( tmp_row, tmp_col).isTaken = False) then
                  --        Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
                  tmpPossibleMoves := appendPossibleMoves(outterPossibleMoves => tmpPossibleMoves,
                                                          aY                  => tmp_row,
                                                          ax                  => tmp_col);
               end if;     
            end if;
            tmp_row := row -1;
         end if;
         
         tmpPossibleMoves := PawnAttackMoves(tmp_row => tmp_row,
                                             col     => col,
                                             aColor  => aColor,
                                             tmp_AllData => tmp_AllData,
                                             inPossibleMoves => tmpPossibleMoves );      
      end if;
      if(row <8) then
         tmp_row := row +1;
         
         if(aColor = Black) and (tmp_AllData.aChessBoard.aGrid( tmp_row, tmp_col ).isTaken = False) then
            --   Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
            tmpPossibleMoves := appendPossibleMoves(outterPossibleMoves => tmpPossibleMoves,
                                                    aY                  => tmp_row,
                                                    ax                  => tmp_col);
            if(row = 2) then
               tmp_col := col;  
               tmp_row := 4;
               if(tmp_AllData.aChessBoard.aGrid( tmp_row, tmp_col).isTaken = False) then
                  --     Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
                  tmpPossibleMoves := appendPossibleMoves(outterPossibleMoves => tmpPossibleMoves,
                                                          aY                  => tmp_row,
                                                          ax                  => tmp_col);
               end if;     
            end if;
            tmp_row := row +1;
         end if; 
         tmpPossibleMoves := PawnAttackMoves(tmp_row => tmp_row,
                                             col     => col,
                                             aColor  => aColor,
                                             tmp_AllData => tmp_AllData,
                                             inPossibleMoves => tmpPossibleMoves );    
      end if; 
      return tmpPossibleMoves;
   end FindPossibleMovesPawn;   
 
   function PawnAttackMoves( tmp_row : in ModelLayer.AxisY; col : in ModelLayer.AxisX ; aColor : in ModelLayer.Color; tmp_AllData : in  VisualLayer.AllData; inPossibleMoves : in out PossibleMoves ) return PossibleMoves is
      tmpPossibleMoves : PossibleMoves := inPossibleMoves;
      tmp_col : ModelLayer.AxisX;
   begin
      if( ModelLayer.AxisX_to_Integer( col )>1) then 
         tmp_col := ModelLayer.Integer_to_AxisX( ModelLayer.AxisX_to_Integer( col )-1) ;
         if(tmp_AllData.aChessBoard.aGrid( tmp_row, tmp_col ).isTaken = True) then
            if (tmp_AllData.aChessBoard.aGrid( tmp_row, tmp_col ).aAccessFigure.aColor /= aColor) then
               --  Put_Line( ">> ATTACK POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
               tmpPossibleMoves := appendPossibleMoves(outterPossibleMoves => tmpPossibleMoves,
                                                       aY                  => tmp_row,
                                                       ax                  => tmp_col);
            end if;
         end if;
      end if;
            
      if( ModelLayer.AxisX_to_Integer( col )<8) then
         tmp_col := ModelLayer.Integer_to_AxisX( ModelLayer.AxisX_to_Integer( col )+1) ;
         if(tmp_AllData.aChessBoard.aGrid( tmp_row, tmp_col ).isTaken = True) then
            if (tmp_AllData.aChessBoard.aGrid( tmp_row, tmp_col ).aAccessFigure.aColor /= aColor) then
               --    Put_Line( ">> ATTACK POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
               tmpPossibleMoves := appendPossibleMoves(outterPossibleMoves => tmpPossibleMoves,
                                                       aY                  => tmp_row,
                                                       ax                  => tmp_col);
            end if;
         end if;
      end if;     
      return tmpPossibleMoves;
   end PawnAttackMoves;
   
   function FindPossibleMovesKnight( tmp_AllData : in  VisualLayer.AllData; aPosition : in ModelLayer.Position; inPossibleMoves : in out PossibleMoves ) return PossibleMoves is
      tmpPossibleMoves : PossibleMoves := inPossibleMoves;
      tmp_Color : ModelLayer.Color := Black;
      aColor : ModelLayer.Color := tmp_AllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).aAccessFigure.aColor;
      --   aFigureType : ModelLayer.FigureType;
      isTaken : Boolean := tmp_AllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).isTaken;
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
            if(isEnemyOrEmpty(tmp_AllData,tmp_row, tmp_col, aColor)) then
               --   Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
               tmpPossibleMoves := appendPossibleMoves(outterPossibleMoves => tmpPossibleMoves,
                                                       aY                  => tmp_row,
                                                       ax                  => tmp_col);
            end if;
         end if;
         if(row<8) then
            tmp_row := row +1;
            if(isEnemyOrEmpty(tmp_AllData,tmp_row, tmp_col, aColor)) then
               --   Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
               tmpPossibleMoves := appendPossibleMoves(outterPossibleMoves => tmpPossibleMoves,
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
            if(isEnemyOrEmpty(tmp_AllData,tmp_row, tmp_col, aColor)) then
               --    Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
               tmpPossibleMoves := appendPossibleMoves(outterPossibleMoves => tmpPossibleMoves,
                                                       aY                  => tmp_row,
                                                       ax                  => tmp_col);
            end if;
         end if;
         if(row<7) then
            tmp_row := row +2;
            if(isEnemyOrEmpty(tmp_AllData,tmp_row, tmp_col, aColor)) then
               --    Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
               tmpPossibleMoves := appendPossibleMoves(outterPossibleMoves => tmpPossibleMoves,
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
            if(isEnemyOrEmpty(tmp_AllData,tmp_row, tmp_col, aColor)) then
               --     Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
               tmpPossibleMoves := appendPossibleMoves(outterPossibleMoves => tmpPossibleMoves,
                                                       aY                  => tmp_row,
                                                       ax                  => tmp_col);
            end if;
         end if;
         if(row<8) then
            tmp_row := row +1;
            if(isEnemyOrEmpty(tmp_AllData,tmp_row, tmp_col, aColor)) then
               --   Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
               tmpPossibleMoves := appendPossibleMoves(outterPossibleMoves => tmpPossibleMoves,
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
            if(isEnemyOrEmpty(tmp_AllData,tmp_row, tmp_col, aColor)) then
               --     Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
               tmpPossibleMoves := appendPossibleMoves(outterPossibleMoves => tmpPossibleMoves,
                                                       aY                  => tmp_row,
                                                       ax                  => tmp_col);
            end if;
         end if;
         if(row<7) then
            tmp_row := row +2;
            if(isEnemyOrEmpty(tmp_AllData,tmp_row, tmp_col, aColor)) then
               --     Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
               tmpPossibleMoves := appendPossibleMoves(outterPossibleMoves => tmpPossibleMoves,
                                                       aY                  => tmp_row,
                                                       ax                  => tmp_col);
            end if;
         end if;
      end if;   		
      return tmpPossibleMoves;    
   end FindPossibleMovesKnight;   
   

         
   function FindPossibleMovesBishop( tmp_AllData : in  VisualLayer.AllData; aPosition : in ModelLayer.Position; inPossibleMoves : in out PossibleMoves ) return PossibleMoves is
      tmpPossibleMoves : PossibleMoves := inPossibleMoves;
      tmp_Color : ModelLayer.Color := Black;
      aColor : ModelLayer.Color := tmp_AllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).aAccessFigure.aColor;
      --   aFigureType : ModelLayer.FigureType;
      isTaken : Boolean := tmp_AllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).isTaken;
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
            if(FindPossibleMovesInLine(tmp_AllData => tmp_AllData,
                                       inPossibleMoves => tmpPossibleMoves,
                                       tmp_row => tmp_row,
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
            if(FindPossibleMovesInLine(tmp_AllData => tmp_AllData,
                                       inPossibleMoves => tmpPossibleMoves,
                                       tmp_row => tmp_row,
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
            if(FindPossibleMovesInLine(tmp_AllData => tmp_AllData,
                                       inPossibleMoves => tmpPossibleMoves,
                                       tmp_row => tmp_row,
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
            if(FindPossibleMovesInLine(tmp_AllData => tmp_AllData,
                                       inPossibleMoves => tmpPossibleMoves,
                                       tmp_row => tmp_row,
                                       tmp_col => tmp_col,
                                       aColor  => aColor) = true) then
               exit;
            end if;
            
         end if;
      end loop;
     
      return tmpPossibleMoves;
   end FindPossibleMovesBishop;
   
   function FindPossibleMovesRook( tmp_AllData : in  VisualLayer.AllData; aPosition : in ModelLayer.Position; inPossibleMoves : in out PossibleMoves ) return PossibleMoves is
      tmpPossibleMoves : PossibleMoves := inPossibleMoves;
      tmp_Color : ModelLayer.Color := Black;
      aColor : ModelLayer.Color := tmp_AllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).aAccessFigure.aColor;
      --   aFigureType : ModelLayer.FigureType;
      isTaken : Boolean := tmp_AllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).isTaken;
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
            if(FindPossibleMovesInLine(tmp_AllData => tmp_AllData,
                                       inPossibleMoves => tmpPossibleMoves,
                                       tmp_row => tmp_row,
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
            if(FindPossibleMovesInLine(tmp_AllData => tmp_AllData,
                                       inPossibleMoves => tmpPossibleMoves,
                                       tmp_row => tmp_row,
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
            if(FindPossibleMovesInLine(tmp_AllData => tmp_AllData,
                                       inPossibleMoves => tmpPossibleMoves,
                                       tmp_row => tmp_row,
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
            if(FindPossibleMovesInLine(tmp_AllData => tmp_AllData,
                                       inPossibleMoves => tmpPossibleMoves,
                                       tmp_row => tmp_row,
                                       tmp_col => tmp_col,
                                       aColor  => aColor) = true) then
               exit;
            end if;
            
         end if;
      end loop;
     
      return tmpPossibleMoves;
   end FindPossibleMovesRook;
   
   function FindPossibleMovesKing( tmp_AllData : in  VisualLayer.AllData; aPosition : in ModelLayer.Position; inPossibleMoves : in out PossibleMoves ) return PossibleMoves is
      tmpPossibleMoves : PossibleMoves := inPossibleMoves;
      aKingDangerSquares : PossibleMoves;
      tmp_Color : ModelLayer.Color := Black;
      aColor : ModelLayer.Color := tmp_AllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).aAccessFigure.aColor;
      --   aFigureType : ModelLayer.FigureType;
      isTaken : Boolean := tmp_AllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).isTaken;
      tmpPosition : ModelLayer.Position := aPosition;
      row : ModelLayer.AxisY := aPosition.aYPosition;
      col : ModelLayer.AxisX := aPosition.aXPosition;
      tmp_row : ModelLayer.AxisY := aPosition.aYPosition;
      tmp_col : ModelLayer.AxisX := aPosition.aXPosition;
      czyJestSzach : Boolean := false;
   begin

      if(ModelLayer.AxisX_to_Integer( col )>1) then
         tmp_col := ModelLayer.Integer_to_AxisX( ModelLayer.AxisX_to_Integer( col )-1);
         if(isEnemyOrEmpty(tmp_AllData => tmp_AllData,
                           row    => tmp_row,
                           col    => tmp_col,
                           aColor => aColor)=true) then
            --     Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
            tmpPossibleMoves := appendPossibleMoves(outterPossibleMoves => tmpPossibleMoves,
                                                    aY                  => tmp_row,
                                                    ax                  => tmp_col);
         end if;
      end if;
      if(ModelLayer.AxisX_to_Integer( col )<8) then
         tmp_col := ModelLayer.Integer_to_AxisX( ModelLayer.AxisX_to_Integer( col )+1);
         if(isEnemyOrEmpty(tmp_AllData => tmp_AllData,
                           row    => tmp_row,
                           col    => tmp_col,
                           aColor => aColor)=true) then
            --     Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
            tmpPossibleMoves := appendPossibleMoves(outterPossibleMoves => tmpPossibleMoves,
                                                    aY                  => tmp_row,
                                                    ax                  => tmp_col);
         end if;  
      end if;
      if(row>1) then
         tmp_row := row - 1;
         tmp_col := col;
         if(isEnemyOrEmpty(tmp_AllData => tmp_AllData,
                           row    => tmp_row,
                           col    => col,
                           aColor => aColor)) then
            --      Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
            tmpPossibleMoves := appendPossibleMoves(outterPossibleMoves => tmpPossibleMoves,
                                                    aY                  => tmp_row,
                                                    ax                  => tmp_col);
         end if;
         if(ModelLayer.AxisX_to_Integer( col )>1) then
            tmp_col := ModelLayer.Integer_to_AxisX( ModelLayer.AxisX_to_Integer( col )-1);
            if(isEnemyOrEmpty(tmp_AllData => tmp_AllData,
                              row    => tmp_row,
                              col    => tmp_col,
                              aColor => aColor)=true) then
               --       Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
               tmpPossibleMoves := appendPossibleMoves(outterPossibleMoves => tmpPossibleMoves,
                                                       aY                  => tmp_row,
                                                       ax                  => tmp_col);
            end if;
         end if;
         if(ModelLayer.AxisX_to_Integer( col )<8) then
            tmp_col := ModelLayer.Integer_to_AxisX( ModelLayer.AxisX_to_Integer( col )+1);
            if(isEnemyOrEmpty(tmp_AllData => tmp_AllData,
                              row    => tmp_row,
                              col    => tmp_col,
                              aColor => aColor)=true) then
               --     Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
               tmpPossibleMoves := appendPossibleMoves(outterPossibleMoves => tmpPossibleMoves,
                                                       aY                  => tmp_row,
                                                       ax                  => tmp_col);
            end if;  
         end if; 
      end if;
      if(row<8) then
         tmp_row := row + 1;
         tmp_col :=col;
         if(isEnemyOrEmpty(tmp_AllData => tmp_AllData,
                           row    => tmp_row,
                           col    => col,
                           aColor => aColor)) then
            --     Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
            tmpPossibleMoves := appendPossibleMoves(outterPossibleMoves => tmpPossibleMoves,
                                                    aY                  => tmp_row,
                                                    ax                  => tmp_col);
         end if;
         if(ModelLayer.AxisX_to_Integer( col )>1) then
            tmp_col := ModelLayer.Integer_to_AxisX( ModelLayer.AxisX_to_Integer( col )-1);
            if(isEnemyOrEmpty(tmp_AllData => tmp_AllData,
                              row    => tmp_row,
                              col    => tmp_col,
                              aColor => aColor)=true) then
               --       Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
               tmpPossibleMoves := appendPossibleMoves(outterPossibleMoves => tmpPossibleMoves,
                                                       aY                  => tmp_row,
                                                       ax                  => tmp_col);
            end if;
         end if;
         if(ModelLayer.AxisX_to_Integer( col )<8) then
            tmp_col := ModelLayer.Integer_to_AxisX( ModelLayer.AxisX_to_Integer( col )+1);
            if(isEnemyOrEmpty(tmp_AllData => tmp_AllData,
                              row    => tmp_row,
                              col    => tmp_col,
                              aColor => aColor)=true) then
               --      Put_Line( ">> POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
               tmpPossibleMoves := appendPossibleMoves(outterPossibleMoves => tmpPossibleMoves,
                                                       aY                  => tmp_row,
                                                       ax                  => tmp_col);
            end if;  
         end if; 
      end if;
      --aKingDangerSquares := kingDangerSquares(tmp_AllData => tmp_AllData,
      --                                        aColor      => aColor);
      --if(isPossibleMovesEmpty(aKingDangerSquares) = False) then
      --   Put_Line( ">>DANGER" & String(PossibleMovesToString(outterPossibleMoves => aKingDangerSquares)));
      --end if;
      czyJestSzach := isKingInDanger(tmp_AllData  => tmp_AllData,
                     aColor       => aColor,
                                     kingPosition => tmpPosition);
      if(czyJestSzach = True) then
      Put_Line( ">>JEST SZACH");
      else
      Put_Line( ">>NIE MA SZACHA");
      end if;
      
      return tmpPossibleMoves;
   end FindPossibleMovesKing;
   
   function kingDangerSquares (tmp_AllData : in  VisualLayer.AllData; aColor :in  ModelLayer.Color) return PossibleMoves is
      bColor :  ModelLayer.Color;
      kingDangerSquares : PossibleMoves;
      tmpPossibleMoves : PossibleMoves;
      kingPosition : ModelLayer.Position;
      tmpPosition : ModelLayer.Position;
      copy_AllData : VisualLayer.AllData := tmp_AllData;
      copy_AliveFigures : ModelLayer.AliveFigures := copy_AllData.aChessBoard.aAliveFigures;   
      row : Integer;
      iter : Integer;
      
   begin
      if(aColor=White) then
         row:=1;
      else
         row:=2;
      end if;
      
      for col in copy_AliveFigures.First(2) .. copy_AliveFigures.Last(2) loop
                  
         if(copy_AliveFigures.aDynamicTable( row, col ).aType = King) then
            kingPosition := copy_AliveFigures.aDynamicTable( row, col ).aPosition; 
            Put_Line( ">>>>>>>>TU ZNLAZLEM KROLA[" & kingPosition.aYPosition'Img & ", " & kingPosition.aXPosition'Img & " ] " );
         end if;  
      end loop;
      
      
      if(aColor=White) then
         row:=2;
         bColor := Black;
      else
         row:=1;
         bColor := White;
      end if;
      copy_AllData.aChessBoard.aGrid( kingPosition.aYPosition, kingPosition.aXPosition ).isTaken := False;
      for col in copy_AliveFigures.First(2) .. copy_AliveFigures.Last(2) loop
                  
         if(copy_AliveFigures.aDynamicTable( row, col ).isAlive = True)  then
            tmpPosition := copy_AliveFigures.aDynamicTable( row, col ).aPosition; 
            tmpPossibleMoves:= FindMoves(tmp_AllData => copy_AllData,
                                         aPosition   => tmpPosition,
                                         aColor      => bColor);
            
            if(isPossibleMovesEmpty(kingDangerSquares) = True) then
               kingDangerSquares := tmpPossibleMoves;
               
            end if;
            if(isPossibleMovesEmpty(tmpPossibleMoves) = False) then
               kingDangerSquares := concatenatePossibleMoves(kingDangerSquares,tmpPossibleMoves);
               
            end if;
         end if;
      end loop;
      -- end if   
      
      
      return kingDangerSquares;
   end kingDangerSquares;	
   
   function isKingInDanger(tmp_AllData : in  VisualLayer.AllData; aColor :in  ModelLayer.Color; kingPosition : in out ModelLayer.Position) return Boolean is
      czyJestSzach : Boolean := false;
      aKingDangerSquares : PossibleMoves;
   begin   
      aKingDangerSquares := kingDangerSquares(tmp_AllData => tmp_AllData,
                                              aColor      => aColor);
      
      for I in aKingDangerSquares.First .. aKingDangerSquares.Last loop
         if(aKingDangerSquares.aDynamicTable( I ).aYPosition = kingPosition.aYPosition) and (aKingDangerSquares.aDynamicTable( I ).aXPosition = kingPosition.aXPosition) then
            czyJestSzach := True;
            exit;
         end if;   
      end loop;  
        
      return czyJestSzach;
   end isKingInDanger;
   
   function FindPossibleMovesInLine ( tmp_AllData : in  VisualLayer.AllData; inPossibleMoves : in out PossibleMoves; tmp_row : in out ModelLayer.AxisY; tmp_col : in out ModelLayer.AxisX; aColor : in out ModelLayer.Color ) return Boolean is
      result : Boolean := false;
   begin
      if(tmp_AllData.aChessBoard.aGrid( tmp_row, tmp_col ).isTaken = False) then
         --     Put_Line( ">> PUSTY POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
         inPossibleMoves := appendPossibleMoves(outterPossibleMoves => inPossibleMoves,
                                                aY                  => tmp_row,
                                                ax                  => tmp_col);
      else
         if(tmp_AllData.aChessBoard.aGrid( tmp_row, tmp_col ).aAccessFigure.aColor /= aColor) then
            --     Put_Line( ">> ENEMY POSMOVE [" & tmp_row'Img & "," & tmp_col'Img & "]" );
            inPossibleMoves := appendPossibleMoves(outterPossibleMoves => inPossibleMoves,
                                                   aY                  => tmp_row,
                                                   ax                  => tmp_col);
                  
            result := true;
         else
            --     Put_Line( ">> MY BRO" );
            result := true;
         end if;
               
      end if;
      return result;
   end FindPossibleMovesInLine;
   
   function isEnemyOrEmpty( tmp_AllData : in  VisualLayer.AllData; row : in out ModelLayer.AxisY; col : in out ModelLayer.AxisX; aColor : in out ModelLayer.Color ) return Boolean is
      result : Boolean := false;
   begin
      if(tmp_AllData.aChessBoard.aGrid( row, col ).isTaken = False) then
         result := true;
      else
         if (tmp_AllData.aChessBoard.aGrid( row, col  ).aAccessFigure.aColor /= aColor) then  
            result := true;
         end if;
      end if;
      return result;
   end isEnemyOrEmpty;

   
   function concatenatePossibleMoves( outterPossibleMoves1 : in PossibleMoves; 
                                      outterPossibleMoves2 : in PossibleMoves  ) 
                                     return PossibleMoves is
      aNewPossibleMoves : PossibleMoves;
   begin
      for I in outterPossibleMoves1.First .. outterPossibleMoves1.Last loop
         aNewPossibleMoves:= appendPossibleMoves( aNewPossibleMoves, 
                                                  outterPossibleMoves1.aDynamicTable( I ).aYPosition, 
                                                  outterPossibleMoves1.aDynamicTable( I ).aXPosition );
      end loop;
      for I in outterPossibleMoves2.First .. outterPossibleMoves2.Last loop
         aNewPossibleMoves:= appendPossibleMoves( aNewPossibleMoves, 
                                                  outterPossibleMoves2.aDynamicTable( I ).aYPosition, 
                                                  outterPossibleMoves2.aDynamicTable( I ).aXPosition );
      end loop;
      
      return aNewPossibleMoves;
   end concatenatePossibleMoves;

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
      isColorMatchingTurn : Boolean := False;
   begin
      aAllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).isPossibleMove := False;
      VisualLayer.Renew_Button( aRowNo      => aPosition.aYPosition,
                                aColNo      => aPosition.aXPosition,
                                aMainWindow => aAllData.aMainWindow,
                                aChessBoard => aAllData.aChessBoard );
      if( aAllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).isTaken = True ) then
         if( aTurn = GameTurn.Player ) then
            isColorMatchingTurn := ModelLayer.isWhite( aAllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).aAccessFigure.all.aColor );
         else
            isColorMatchingTurn := ModelLayer.isBlack( aAllData.aChessBoard.aGrid( aPosition.aYPosition, aPosition.aXPosition ).aAccessFigure.all.aColor );
         end if;
         if( isColorMatchingTurn = True ) then
            IdPosition := UserCallback_Position.Connect( aAllData.aMainWindow.aButtonGrid( VisualLayer.AxisY( aPosition.aYPosition ), VisualLayer.AxisX( aPosition.aXPosition ) ), 
                                                         "clicked", 
                                                         UserCallback_Position.To_Marshaller( Activate_Button_Call'Access ),
                                                         aPosition );
         end if;
      end if;
      
      aPossibleMoves := removePossibleMoves( outterPossibleMoves => aPossibleMoves,
                                             aPosition           => aPosition );
   end HidePossibleMove;
   
   procedure Move_Figure_Call( Object : access Gtk.Widget.Gtk_Widget_Record'Class; aToPosition : in ModelLayer.Position ) is
   begin
      --        Put_Line("#1 Move_Figure_Call => [" & aToPosition.aYPosition'Img & "," & aToPosition.aXPosition'Img & "]");
      Move_Figure( aToPosition );
      --        Put_Line("#1 Move_Figure_Call => [" & aToPosition.aYPosition'Img & "," & aToPosition.aXPosition'Img & "]");
      DeSetPossibleToActivate;
      
      if( Is_End_of_the_Game = True ) then
         End_of_the_Game( aTurn );
      end if;
      
      aTurn := End_Turn( aTurn );
      
      SetPossibleToActivate;
   end Move_Figure_Call;
   
   procedure Move_Figure( aToPosition : in ModelLayer.Position ) is
      aFromPosition : ModelLayer.Position;
   begin
      --        Put_Line("#1 Move_Figure => [" & aToPosition.aYPosition'Img & "," & aToPosition.aXPosition'Img & "] <-- [" &
      --                   aFromPosition.aYPosition'Img & "," & aFromPosition.aXPosition'Img & "] (isActivated = " & isActivated'Img & ")" );
      if( isActivated = True ) then
         aFromPosition := aActivated_Position;
         aAllData := MoveFigureAndFreeInModel( aFromPosition => aFromPosition,
                                               aToPosition => aToPosition, 
                                               aAllData => aAllData );
         
         Deactivate_Button;
         HidePossibleMoves;
      else
         null; -- do nothing
      end if;
      --        Put_Line("#2 Move_Figure => [" & aToPosition.aYPosition'Img & "," & aToPosition.aXPosition'Img & "] <-- [" &
      --                   aFromPosition.aYPosition'Img & "," & aFromPosition.aXPosition'Img & "] (isActivated = " & isActivated'Img & ")" );
   end Move_Figure;
   
   function MoveFigureAndFreeInModel( aFromPosition : in ModelLayer.Position; aToPosition : in ModelLayer.Position; aAllData : in out VisualLayer.AllData ) return VisualLayer.AllData is
   begin
      aAllData.aChessBoard.aGrid := ModelLayer.Kill_Figure( aAllData.aChessBoard.aGrid, aToPosition );
      aAllData.aChessBoard.aAliveFigures := ModelLayer.Kill_Figure( aAllData.aChessBoard.aAliveFigures, aToPosition );
      
      -- Transfer data from FROM to TO
      -- aAllData.aChessBoard.aGrid( aToPosition.aYPosition, aToPosition.aXPosition ).aAccessFigure := new ModelLayer.Figure;
      aAllData.aChessBoard.aGrid( aToPosition.aYPosition, aToPosition.aXPosition ).aAccessFigure :=
        aAllData.aChessBoard.aGrid( aFromPosition.aYPosition, aFromPosition.aXPosition ).aAccessFigure;
      ChangeFigureSPostion( oldPosition => aFromPosition,
                            newPosition => aToPosition );
      aAllData.aChessBoard.aGrid( aToPosition.aYPosition, aToPosition.aXPosition ).isTaken := True;
      
      -- Free aFromPosition
      aAllData.aChessBoard.aGrid( aFromPosition.aYPosition, aFromPosition.aXPosition ).aAccessFigure := null;
      aAllData.aChessBoard.aGrid( aFromPosition.aYPosition, aFromPosition.aXPosition ).isTaken := False;
      
      return aAllData;
   end MoveFigureAndFreeInModel;
   
   procedure ChangeFigureSPostion( oldPosition : ModelLayer.Position; newPosition : ModelLayer.Position ) is
      innerAliveFigures : AliveFigures := aAllData.aChessBoard.aAliveFigures;
   begin
      for row in innerAliveFigures.First(1) .. innerAliveFigures.Last(1) loop
         for col in innerAliveFigures.First(2) .. innerAliveFigures.Last(2) loop
            if( innerAliveFigures.aDynamicTable(row, col).isAlive = True
               and innerAliveFigures.aDynamicTable(row, col).aPosition.aYPosition = oldPosition.aYPosition 
               and innerAliveFigures.aDynamicTable(row, col).aPosition.aXPosition = oldPosition.aXPosition ) then
               innerAliveFigures.aDynamicTable(row, col).aPosition := newPosition;
            end if;
         end loop;
      end loop;
      
      aAllData.aChessBoard.aGrid( newPosition.aYPosition, newPosition.aXPosition ).aAccessFigure.all.aPosition := newPosition;
      aAllData.aChessBoard.aAliveFigures := innerAliveFigures;
   end ChangeFigureSPostion;
   
   procedure DestroyObject_And_MainQuit( Object: access Gtk.Widget.Gtk_Widget_Record'Class ) is --on event
      -- close main window if Delete_Event return False (it means it's allowed to close);
   begin
      Ada.Text_IO.Put_Line( "X clicked - Destroying object" );
      Gtk.Widget.Destroy( Object );
      Gtk.Main.Main_Quit;
      task_GT.End_of_the_Game;
   end DestroyObject_And_MainQuit;
   
   function End_Turn( aTurn : in out GameTurn.Turn ) return GameTurn.Turn is
   begin
      if( aTurn = GameTurn.Player ) then
         aTurn := GameTurn.Computer;
      else
         aTurn := GameTurn.Player;
      end if;
      
      return aTurn;
   end End_Turn;
   
   function Is_End_of_the_Game return Boolean is
   begin
      null;
      return False;
   end Is_End_of_the_Game;
   
   procedure End_of_the_Game( aTurn : in GameTurn.Turn ) is
   begin
      aAllData.aMainWindow.aWindow.Destroy;
         
      AfterGameWindow.Main( aWinner => aTurn );
   end End_of_the_Game;

end ControllerLayer;
