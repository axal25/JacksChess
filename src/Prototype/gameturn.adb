with Ada.Text_IO;
use Ada.Text_IO;

package body GameTurn is

   function Init_Turn( aTurn : in out Turn ) return Turn is
   begin
      aTurn := Player;
      return aTurn;
   end;
   
   function Change_Turn( aTurn : in out Turn ) return Turn is
   begin
      if( aTurn = Player ) then
         aTurn := Computer;
      else
         aTurn := Player;
      end if;
      return aTurn;
   end;
   
   function appendPossibleActivations( aPossibleActivations : in out DynamicTableOfButtons; aButton : in out Gtk.Button.Gtk_Button ) return DynamicTableOfButtons is
      aNewPossibleActivations : DynamicTableOfButtons;
   begin
      if( aPossibleActivations'First = 0 and aPossibleActivations'Last = 0 ) then
         aNewPossibleActivations := new TableOfButtons( 1 .. 1 );
         aNewPossibleActivations( aNewPossibleActivations'First ) := aButton;
         aPossibleActivations := aNewPossibleActivations;
         Put_Line( "0 .. 0 =>" & aNewPossibleActivations'First'Img & " .. " & aNewPossibleActivations'Last'Img );
         else
         aNewPossibleActivations := new TableOfButtons( aPossibleActivations'First .. aPossibleActivations'Last +1 );
         Put_Line( aPossibleActivations'First'Img & " .. " & aPossibleActivations'Last'Img & " => " & aNewPossibleActivations'First'Img & " .. " & aNewPossibleActivations'Last'Img );
         for I in aPossibleActivations'Range loop
            aNewPossibleActivations( I ) := aPossibleActivations( I );
         end loop;
         aNewPossibleActivations( aPossibleActivations'Last +1 ) := aButton;
         aPossibleActivations := aNewPossibleActivations;
      end if;
      Put_Line( aPossibleActivations'First'Img & " .. " & aPossibleActivations'Last'Img );
      return aPossibleActivations;
   end appendPossibleActivations;
   
   function resetPossibleActivations return DynamicTableOfButtons is
      aNewPossibleActivations : DynamicTableOfButtons;
   begin
      aNewPossibleActivations := new TableOfButtons( 0 .. 0 );
      return aNewPossibleActivations;
   end resetPossibleActivations;
   
   function clickRandomButton( aPossibleActivations : DynamicTableOfButtons ) return Gtk.Button.Gtk_Button is
      aButton : Gtk.Button.Gtk_Button;
   begin
      if( aPossibleActivations'First = 0 and aPossibleActivations'Last = 0 ) then
         null; -- do nothing
         Put_Line("do nothing");
      else
         Put_Line("aPossibleActivations(1).Clicked; \/");
         aButton := aPossibleActivations( 10 );
         aButton.Clicked;
         Put_Line("aPossibleActivations(1).Clicked; /\");
      end if;
      return aButton;
   end clickRandomButton;
   
   task body GameTurnMain is
      aTurn : Turn := Player;
      isEnd_of_the_Game : Boolean := False;
      aPossibleActivations : DynamicTableOfButtons := resetPossibleActivations;
      Unhandled_GameTurnMain_Exception : exception;
      lastClickedButton : Gtk.Button.Gtk_Button;
   begin
      accept Start_the_Game;
      
      aTurn := Init_Turn( aTurn );
      Put_Line("Read... Set... Go!");
      Put_Line( aTurn'Img & "'s Turn..." );
         
      while( isEnd_of_the_Game = False ) loop
         select            
            accept End_Turn( outTurn : in out Turn ) do
               aTurn := Change_Turn( aTurn );
               outTurn := aTurn;
               Put_Line( aTurn'Img & "'s Turn..." );
         
               -- Skip computer's turn
               --                 if( aTurn = Computer ) then
               --                    Put_Line( "--------------" );
               --                    aTurn := Change_Turn( aTurn );
               --                    outTurn := aTurn;
               --                    Put_Line( aTurn'Img & "'s Turn..." );
               --                 end if;
            end End_Turn;            
         or              
            accept Get_Turn( outTurn : in out Turn ) do
               outTurn := aTurn;
            end Get_Turn;            
         or            
            accept End_of_the_Game do
               Put_Line("End of the Game");
               isEnd_of_the_Game := True;
            end End_of_the_Game;            
         or
            accept Append_PossibleActivations( aButton : in out Gtk.Button.Gtk_Button ) do
               aPossibleActivations := appendPossibleActivations( aPossibleActivations, aButton );
            end Append_PossibleActivations;
         or
            accept Reset_PossibleActivations do
               aPossibleActivations := resetPossibleActivations;
            end Reset_PossibleActivations;
         or
            accept Get_PossibleActtivations( inoutPossibleActivations : in out DynamicTableOfButtons ) do
               inoutPossibleActivations := aPossibleActivations;
            end Get_PossibleActtivations;   
         or
            accept Click_RandomButton do
               Put_Line("procedure clickRandomButton( aPossibleActivations ); \/");
               lastClickedButton := clickRandomButton( aPossibleActivations );
               Put_Line("procedure clickRandomButton( aPossibleActivations ); /\");
            end Click_RandomButton;
         or
            accept ReClick_Button do
               lastClickedButton.Clicked;
            end ReClick_Button;
         end select;
      end loop;
   exception
      when others => 
         Put_Line("Unhandled_GameTurnMain_Exception");
         raise Unhandled_GameTurnMain_Exception;         
   end GameTurnMain;

end GameTurn;
